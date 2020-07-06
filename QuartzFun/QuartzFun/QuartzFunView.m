//
//  QuartzFunView.m
//  QuartzFun
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "QuartzFunView.h"

@interface QuartzFunView ()

@property (nonatomic) UIImage *myImage;
@property (nonatomic) CGPoint firstTouchLocation;
@property (nonatomic) CGPoint lastTouchLocation;
@property (nonatomic) CGRect redrawRect;

@end

@implementation QuartzFunView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGRect)currentRect{
    return CGRectMake(self.firstTouchLocation.x, self.firstTouchLocation.y, self.lastTouchLocation.x - self.firstTouchLocation.x, self.lastTouchLocation.y - self.firstTouchLocation.y);
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _currentColor = UIColor.redColor;
        _myImage = [UIImage imageNamed:@"smiley.jpg"];
    }
    
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _currentColor = UIColor.redColor;
        _myImage = [UIImage imageNamed:@"smiley.jpg"];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        _currentColor = UIColor.redColor;
        _myImage = [UIImage imageNamed:@"smiley.jpg"];
    }
    return self;
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if (touch) {
        if (self.useRandomColor) {
            self.currentColor = [UIColor randomColor];
            
        }
        
        self.firstTouchLocation = [touch locationInView:self];
        self.lastTouchLocation = self.firstTouchLocation;
        
        self.redrawRect = CGRectZero;
        [self setNeedsDisplay];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if (touch) {
        self.lastTouchLocation = [touch locationInView:self];
        if (self.shape == image) {
            CGFloat horizontalOffset = self.myImage.size.width / 2.0;
            CGFloat verticalOffset = self.myImage.size.height / 2.0;
            // union image area
            self.redrawRect = CGRectUnion(self.redrawRect, CGRectMake(self.lastTouchLocation.x - horizontalOffset, self.lastTouchLocation.y - verticalOffset, self.myImage.size.width, self.myImage.size.height));
        }else{
            self.redrawRect = CGRectUnion(self.redrawRect, [self currentRect]);
        }
        
//        [self setNeedsDisplay];
        [self setNeedsDisplayInRect:self.redrawRect];
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = touches.anyObject;
    if (touch) {
        self.lastTouchLocation = [touch locationInView:self];
        if (self.shape == image) {
            CGFloat horizontalOffset = self.myImage.size.width / 2.0;
            CGFloat verticalOffset = self.myImage.size.height / 2.0;
            // union image area
            self.redrawRect = CGRectUnion(self.redrawRect, CGRectMake(self.lastTouchLocation.x - horizontalOffset, self.lastTouchLocation.y - verticalOffset, self.myImage.size.width, self.myImage.size.height));
        }else{
            self.redrawRect = CGRectUnion(self.redrawRect, [self currentRect]);
        }
        
//        [self setNeedsDisplay];
        [self setNeedsDisplayInRect:self.redrawRect];
    }
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, self.currentColor.CGColor);
    CGContextSetFillColorWithColor(context, self.currentColor.CGColor);
    
    CGRect currentRect = CGRectMake(self.firstTouchLocation.x, self.firstTouchLocation.y, self.lastTouchLocation.x - self.firstTouchLocation.x, self.lastTouchLocation.y - self.firstTouchLocation.y);
    
    switch (self.shape) {
        case line:{
            CGContextMoveToPoint(context, self.firstTouchLocation.x, self.firstTouchLocation.y);
            CGContextAddLineToPoint(context, self.lastTouchLocation.x, self.lastTouchLocation.y);
            CGContextStrokePath(context);
            break;
        }
            
        case rectangle:{
            CGContextAddRect(context, [self currentRect]);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        }
        case ellipse:{
            CGContextAddEllipseInRect(context, [self currentRect]);
            CGContextDrawPath(context, kCGPathFillStroke);
            break;
        }
        case image:{
            CGFloat horizontalOffset = self.myImage.size.width / 2.0;
            CGFloat verticalOffset = self.myImage.size.height / 2.0;
            CGPoint drawPoint = CGPointMake(self.lastTouchLocation.x - horizontalOffset, self.lastTouchLocation.y - verticalOffset);
            [self.myImage drawAtPoint:drawPoint];
           break;
        }
            
        default:
            break;
    }
}

@end
