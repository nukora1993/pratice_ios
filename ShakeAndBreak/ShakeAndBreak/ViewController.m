//
//  ViewController.m
//  ShakeAndBreak
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (nonatomic) UIImage *baidu;
@property (nonatomic) UIImage *pdd;
@property (nonatomic) BOOL brokenScreenShowing;
@property (nonatomic) AVAudioPlayer *crashPlayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *url = [NSBundle.mainBundle URLForResource:@"glass" withExtension:@"mp3"];
    if (url) {
        self.crashPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        self.baidu = [UIImage imageNamed:@"baidu"];
        self.pdd = [UIImage imageNamed:@"pdd"];
        self.imageView.image = self.baidu;
    }
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    if (!self.brokenScreenShowing && motion == UIEventSubtypeMotionShake) {
        self.imageView.image = self.pdd;
        [self.crashPlayer play];
        self.brokenScreenShowing = YES;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.imageView.image = self.baidu;
    self.brokenScreenShowing = NO;
}


@end
