//
//  SecondViewController.m
//  BridgeControl
//
//  Created by nuko on 2020/6/29.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "SecondViewController.h"
#include "Constants.h"

@interface SecondViewController ()

@end

@implementation SecondViewController
- (void)applicationWillEnterForeground:(NSNotification *)notification{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}

- (void)refreshFields{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.engineSwitch.on = [defaults boolForKey:warpDriveKey];
    self.warpFactorSlider.value = [defaults floatForKey:warpFactorKey];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [self refreshFields];
    
    UIApplication *app = UIApplication.sharedApplication;
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:app];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (IBAction)onEngineSwitchTapped:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:self.warpFactorSlider.value forKey:warpFactorKey];
    [defaults synchronize];
}

- (IBAction)onWarpSliderDragged:(UISlider *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.engineSwitch.on forKey:warpDriveKey];
    
    [defaults synchronize];
}
- (IBAction)onSettingButtonTapped:(UIButton *)sender {
    UIApplication *application = UIApplication.sharedApplication;
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    
    if ([application canOpenURL:url]) {
        [application openURL:url options:@{@"" : @"" } completionHandler:nil];
    }
    
}

@end
