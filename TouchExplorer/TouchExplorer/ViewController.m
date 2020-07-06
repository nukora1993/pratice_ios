//
//  ViewController.m
//  TouchExplorer
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)updateLabelsFromTouches:(UITouch *)touch AllTouches:(NSSet *)allTouches{
    NSInteger numTaps = touch.tapCount;
    NSString *tapMessage = [NSString stringWithFormat:@"%ld touches detected", numTaps];
    self.tapsLabel.text = tapMessage;
    
    NSInteger numTouches = allTouches.count;
    NSString *touchMeg = [NSString stringWithFormat:@"%ld touches detected", numTouches];
    self.touchesLabel.text = touchMeg;
    
    if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        self.forceLabel.text = [NSString stringWithFormat:@"Force: %f \n"
                                "Max force: %f", touch.force, touch.maximumPossibleForce];
    }else{
        self.forceLabel.text = @"3D Touch not available";
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.messageLabel.text = @"Touches began";
    [self updateLabelsFromTouches:touches.anyObject AllTouches:touches];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.messageLabel.text = @"Touches cancelled";
    [self updateLabelsFromTouches:touches.anyObject AllTouches:touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.messageLabel.text = @"Touches ended";
    [self updateLabelsFromTouches:touches.anyObject AllTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.messageLabel.text = @"Drag detected";
    [self updateLabelsFromTouches:touches.anyObject AllTouches:touches];
}


@end
