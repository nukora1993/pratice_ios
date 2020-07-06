//
//  BallView.h
//  Ball
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

NS_ASSUME_NONNULL_BEGIN

@interface BallView : UIView

@property (nonatomic) CMAcceleration acceleration;

- (void)update;

@end

NS_ASSUME_NONNULL_END
