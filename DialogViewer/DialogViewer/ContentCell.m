//
//  ContentCell.m
//  DialogViewer
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ContentCell.h"

@implementation ContentCell

+ (CGSize)sizeForContentString:(NSString *)s forMaxWidth:(CGFloat)maxWidth{
//    return CGSizeZero;
    CGSize maxSize = CGSizeMake(maxWidth, 1000);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin;
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineBreakMode = NSLineBreakByCharWrapping;
    NSDictionary *attributes = @{
        NSFontAttributeName : [self defaultFont],
        NSParagraphStyleAttributeName : style
    };
    
    NSString *string = s;
    CGRect rect = [string boundingRectWithSize:maxSize options:opts attributes:attributes context:nil];
    
    return rect.size;
    
}

+ (UIFont *)defaultFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        _label.opaque = false;
        _label.backgroundColor = [UIColor colorWithRed:0.8 green:0.9 blue:1.0 alpha:1.0];
        _label.textColor = UIColor.blackColor;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [ContentCell defaultFont];
    
        [self.contentView addSubview:_label];
    }
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    return self;
}

- (NSString *)text{
    return _label.text;
}

- (void)setText:(NSString *)text{
    _label.text = text;
    CGRect newLabelFrame = _label.frame;
    CGRect newContentFrame = self.contentView.frame;
    CGSize textSize = [ContentCell sizeForContentString:text forMaxWidth:_maxWidth];
    
    newLabelFrame.size = textSize;
    newContentFrame.size = textSize;
    _label.frame = newLabelFrame;
    self.contentView.frame = newContentFrame;
}



@end
