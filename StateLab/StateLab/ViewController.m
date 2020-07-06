//
//  ViewController.m
//  StateLab
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic) UILabel *label;
@property (nonatomic) BOOL animate;
@property (nonatomic) UIImage *smiley;
@property (nonatomic) UIImageView *smileyView;
@property (nonatomic) UISegmentedControl *segmentedControl;
@property (nonatomic) NSInteger index;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.animate = NO;
    // Do any additional setup after loading the view.
    CGRect bounds = self.view.bounds;
    
    CGRect labelFrame = CGRectMake(bounds.origin.x, (bounds.origin.y + bounds.size.height) / 2 - 50, bounds.size
                                   .width, 100);
    
    self.label = [[UILabel alloc] initWithFrame:labelFrame];
    self.label.font = [UIFont fontWithName:@"Helvetica" size:70];
    self.label.text = @"Bazinga";
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.backgroundColor = UIColor.clearColor;
    
    
    CGRect smileyFrame = CGRectMake((bounds.origin.x + bounds.size.width) / 2 - 42, (bounds.origin.y + bounds.size.height) / 2, 84, 84);
    
    self.smileyView = [[UIImageView alloc] initWithFrame:smileyFrame];
    self.smileyView.contentMode = UIViewContentModeCenter;
    NSString *smilePath = [NSBundle.mainBundle pathForResource:@"smiley" ofType:@"jpg"];
    self.smiley = [UIImage imageWithContentsOfFile:smilePath];
    self.smileyView.image = self.smiley;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"one", @"two", @"three", @"four"]];
    
    self.segmentedControl.frame = CGRectMake(bounds.origin.x + 20, 50, bounds.size.width - 40, 50);
    [self.segmentedControl addTarget:self action:@selector(selectionChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:self.segmentedControl];
    
    [self.view addSubview:self.smileyView];
    
    
    [self.view addSubview:self.label];
    
    self.index = [NSUserDefaults.standardUserDefaults integerForKey:@"index"];
    self.segmentedControl.selectedSegmentIndex = self.index;
    
//    [self rotateLabelDown];
    
    NSNotificationCenter *center = NSNotificationCenter.defaultCenter;
    [center addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:nil];
    [center addObserver:self selector:@selector(applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [center addObserver:self selector:@selector(applicationDidEnterBackground:) name:UISceneDidEnterBackgroundNotification object:nil];
    [center addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)selectionChanged:(UISegmentedControl *)sender{
    self.index = self.segmentedControl.selectedSegmentIndex;
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.animate = NO;
}

- (void)applicationDidBecomeActive:(NSNotification *)notification{
    self.animate = YES;
    [self rotateLabelDown];
}

- (void)applicationDidEnterBackground:(NSNotification *)notification{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    self.smiley = nil;
    self.smileyView.image = nil;
    
    [NSUserDefaults.standardUserDefaults setInteger:self.index forKey:@"index"];
    
    
    // require more time for background
    UIApplication *app = UIApplication.sharedApplication;
    UIBackgroundTaskIdentifier taskId = UIBackgroundTaskInvalid;
    UIBackgroundTaskIdentifier tid = [app beginBackgroundTaskWithExpirationHandler:^{
        NSLog(@"background task ran out of time");
        [app endBackgroundTask:taskId];
    }];
    
    taskId = tid;
    
    if (taskId == UIBackgroundTaskInvalid) {
        NSLog(@"failed to start background task");
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"starting background task with %f seconds remaining", app.backgroundTimeRemaining);
        
        self.smiley = nil;
        self.smileyView.image = nil;
        
        [NSThread sleepForTimeInterval:25];
        
        NSLog(@"finish background task with %f seconds remaining", app.backgroundTimeRemaining);
        
        [app endBackgroundTask:taskId];
    });
    
    
}

- (void)applicationWillEnterForeground:(NSNotification *)notification{
    NSLog(@"%@", NSStringFromSelector(_cmd));
    NSString *smilePath = [NSBundle.mainBundle pathForResource:@"smiley" ofType:@"jpg"];
    self.smiley = [UIImage imageWithContentsOfFile:smilePath];
    self.smileyView.image = self.smiley;
}

- (void)rotateLabelDown{
    [UIView animateWithDuration:0.5 animations:^{
        self.label.transform = CGAffineTransformRotate(self.label.transform , M_PI);
    } completion:^(BOOL finished) {
        [self rotateLabelUp];
    }];
}

- (void)rotateLabelUp{
    [UIView animateWithDuration:0.5 animations:^{
        self.label.transform = CGAffineTransformRotate(self.label.transform, 0);
    } completion:^(BOOL finished) {
        if (self.animate) {
            [self rotateLabelDown];
        }
    }];
}


@end
