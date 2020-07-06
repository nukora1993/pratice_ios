//
//  FirstViewController.m
//  BridgeControl
//
//  Created by nuko on 2020/6/29.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "FirstViewController.h"
#import "Constants.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [NSNotificationCenter.defaultCenter removeObserver:self];
}

- (void)applicationWillEnterForeground:(NSNotification *)notification{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    [self refreshFields];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self refreshFields];
}

- (void)viewWillAppear:(BOOL)animated{
    [self refreshFields];
    
    UIApplication *app = UIApplication.sharedApplication;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:app];
}

- (void)refreshFields{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.officerLabel.text = [defaults stringForKey:officerKey];
    self.authorizationCodeLabel.text = [defaults stringForKey:authorizationCodeKey];
    self.rankLabel.text = [defaults stringForKey:ranKey];
    self.warpDriveLabel.text = [defaults stringForKey:warpDriveKey];
    self.warpFactorLabel.text = [defaults stringForKey:warpFactorKey];
}


@end
