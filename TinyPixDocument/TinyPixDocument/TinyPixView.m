//
//  TinyPixView.m
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "TinyPixView.h"
#import "TinyPixDocument.h"

@implementation TinyPixView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit{
    [self calculateGridForSize:self.bounds.size];
}

- (void)calculateGridForSize:(CGSize)size{
    CGFloat space = MIN(size.width, size.height);
    _gap = space / 57;
    CGFloat cellSide = _gap*6;
    _blockSize = CGSizeMake(cellSide, cellSide);
    _gridRect = CGRectMake((size.width - space) / 2, (size.height - space) / 2, space, space);
}

- (void)drawRect:(CGRect)rect{
    if (self.document) {
        CGSize size =self.bounds.size;
        if (!(size.width == self.lastSize.width) && (size.height == self.lastSize.height)) {
            self.lastSize = size;
            [self calculateGridForSize:size];
        }
        
        for (int row = 0; row < 8; row++) {
            for (int column = 0; column < 8; column++) {
                [self drawBlockAtRow:row Column:column];
            }
        }
    }
    
}

- (void)drawBlockAtRow:(int)row Column:(int)column{
    CGFloat startX = self.gridRect.origin.x + self.gap + (self.blockSize.width + self.gap) * (7 - column) + 1;
    CGFloat startY = self.gridRect.origin.y + self.gap + (self.blockSize.height + self.gap) * row + 1;
    
    CGRect blockFrame = CGRectMake(startX, startY, self.blockSize.width, self.blockSize.height);
    
    UIColor *color = [self.document stateAtRow:row Column:column] ? UIColor.blackColor : UIColor.whiteColor;
    
    [color setFill];
    [self.tintColor setStroke];
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:blockFrame];
    [path fill];
    [path stroke];
}

- (struct GridIndex)touchedGridIndexFromTouches:(NSSet *)touches{
    struct GridIndex result = {-1, -1};
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    if (self.gridRect.origin.x <= location.x && self.gridRect.origin.x + self.gridRect.size.width >= location.x
        && self.gridRect.origin.y <= location.y && self.gridRect.origin.y + self.gridRect.size.height >= location.y) {
        location.x -= self.gridRect.origin.x;
        location.y -= self.gridRect.origin.y;
        result.column = 8 - (location.x * 8 / self.gridRect.size.width);
        result.row = location.y * 8 / self.gridRect.size.height;
    }
    
    return result;
}

- (void)toggleSelectedBlock{
    if (self.selectedBlockIndex.row != -1 && self.selectedBlockIndex.column != -1) {
        [self.document toggleStateAtRow:self.selectedBlockIndex.row Column:self.selectedBlockIndex.column];
        
        [[self.document.undoManager prepareWithInvocationTarget:self.document] toggleStateAtRow:self.selectedBlockIndex.row Column:self.selectedBlockIndex.column];
        
        [self setNeedsDisplay];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.selectedBlockIndex = [self touchedGridIndexFromTouches:touches];
    [self toggleSelectedBlock];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    struct GridIndex touched = [self touchedGridIndexFromTouches:touches];
    if (touched.row != self.selectedBlockIndex.row && touched.column != self.selectedBlockIndex.column) {
        self.selectedBlockIndex = touched;
        [self toggleSelectedBlock];
    }
}

@end
