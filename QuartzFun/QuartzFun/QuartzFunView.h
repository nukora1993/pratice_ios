//
//  QuartzFunView.h
//  QuartzFun
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (randomColor)

+ (UIColor *)randomColor;

@end

@implementation UIColor (randomColor)

+ (UIColor *)randomColor{
    CGFloat red = arc4random_uniform(255) / 255.0;
    CGFloat green = arc4random_uniform(255) / 255.0;
    CGFloat blue = arc4random_uniform(255) /255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end

//@

typedef NS_ENUM(NSInteger, Shape){
    line = 0,
    rectangle,
    ellipse,
    image
};

typedef NS_ENUM(NSInteger, DrawingColor){
    red = 0,
    blue,
    yellow,
    green,
    randomColor
};

@interface QuartzFunView : UIView

@property (nonatomic) Shape shape;
@property (nonatomic) UIColor *currentColor;
@property (nonatomic) BOOL useRandomColor;



@end

NS_ASSUME_NONNULL_END
