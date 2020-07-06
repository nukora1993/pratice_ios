//
//  ViewController.m
//  MotionMonitor
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>
@interface ViewController ()

@property (nonatomic) CMMotionManager *motionManager;
//@property (nonatomic) NSOperationQueue *queue;
@property (nonatomic) NSTimer *updateTimer;

@end

@implementation ViewController

- (void)viewDidLoad{
    self.motionManager = [[CMMotionManager alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.motionManager.isDeviceMotionAvailable) {
        self.motionManager.deviceMotionUpdateInterval = 0.1;
        [self.motionManager startDeviceMotionUpdates];
        self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(updateDisplay) userInfo:nil repeats:YES];
    }
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (self.motionManager.isDeviceMotionAvailable) {
        [self.motionManager stopDeviceMotionUpdates];
        [self.updateTimer invalidate];
        self.updateTimer = nil;
    }
}


- (void)updateDisplay{
    CMDeviceMotion *motion = self.motionManager.deviceMotion;
    if (motion) {
        CMRotationRate rotationRate = motion.rotationRate;
        CMAcceleration gravity = motion.gravity;
        CMAcceleration userAcc = motion.userAcceleration;
        CMAttitude* attitude = motion.attitude;
        
        NSString *gyroscopeText = [NSString stringWithFormat:@"Rotation Rate:\n-----------\n"
                                   "x: %+.2f\n"
                                   "y: %+.2f\n"
                                   "z: %+.2f\n",
                                   rotationRate.x, rotationRate.y, rotationRate.z];
        
        NSString *acceleratorText = [NSString stringWithFormat:@"Acceleration:\n-----------\n"
                                     "Gravity x: %+.2f \t\t User x: %+.2f\n"
                                     "Gravity y: %+.2f \t\t User y: %+.2f\n"
                                     "Gravity z: %+.2f \t\t User z: %+.2f\n",
                                     gravity.x, userAcc.x, gravity.y, userAcc.y, gravity.z, userAcc.z];
        
        NSString *attitudeText = [NSString stringWithFormat:@"Attitude:\n-----------\n"
                                  "Roll: %+.2f\n"
                                  "Pitch: %+.2f\n"
                                  "Yaw: %+.2f\n",
                                  attitude.roll, attitude.pitch, attitude.yaw];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.gyroscopeLabel.text = gyroscopeText;
            self.accelerometerLabel.text = acceleratorText;
            self.attitudeLabel.text = attitudeText;
        });
    }
}



@end
