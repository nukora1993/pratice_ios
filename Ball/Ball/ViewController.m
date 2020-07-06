//
//  ViewController.m
//  Ball
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import "BallView.h"

static float updateInterval = 1.0 / 60;

@interface ViewController ()

@property (nonatomic) CMMotionManager *motionManager;
@property (nonatomic) NSOperationQueue *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = updateInterval;
    self.queue = [[NSOperationQueue alloc] init];
    BallView *ballView = (BallView *)self.view;
    
    
    [self.motionManager startDeviceMotionUpdatesToQueue:self.queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
        ballView.acceleration = motion.gravity;
        dispatch_async(dispatch_get_main_queue(), ^{
            [ballView update];
        });
    }];
    
}


@end
