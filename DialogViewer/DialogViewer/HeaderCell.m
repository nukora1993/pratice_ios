//
//  HeaderCell.m
//  DialogViewer
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "HeaderCell.h"

@implementation HeaderCell

+ (UIFont *)defaultFont{
    return [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.label.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.8 alpha:1.0];
        self.label.textColor = UIColor.blackColor;
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    return [super initWithCoder:coder];
}

@end
