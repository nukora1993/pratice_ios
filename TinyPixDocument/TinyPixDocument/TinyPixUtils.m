//
//  TinyPixUtils.m
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "TinyPixUtils.h"
#import <UIKit/UIKit.h>
@implementation TinyPixUtils

+ (UIColor *)getTintColorForIndex:(NSInteger)index{
    UIColor *color;
    switch (index) {
        case 0:
            color = UIColor.redColor;
            break;
        case 1:
            color = [UIColor colorWithRed:0 green:0.6 blue:0 alpha:1];
            break;
        case 2:
            color = UIColor.blueColor;
            break;
        default:
            color = UIColor.redColor;
            
            break;
    }
    return color;
}

@end
