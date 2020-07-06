//
//  SwitchingViewController.m
//  ViewSwitcher
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "SwitchingViewController.h"
#import "BlueViewController.h"
#import "YellowViewController.h"

@interface SwitchingViewController ()

@property (nonatomic, weak) BlueViewController *blueViewController;
@property (nonatomic, weak) YellowViewController *yellowViewController;

@end

@implementation SwitchingViewController

- (void)switchViewControllerFrom:(UIViewController *)fromVC To:(UIViewController *)toVC{
    // common for vc
    if (fromVC) {
        [fromVC willMoveToParentViewController:nil];
        [fromVC.view removeFromSuperview];
        [fromVC removeFromParentViewController];
    }
    
    if (toVC) {
        [self addChildViewController:toVC];
        [self.view insertSubview:toVC.view atIndex:0];
        [toVC didMoveToParentViewController:self];
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    
    if (_blueViewController && !_blueViewController.view.superview) {
        _blueViewController = nil;
    }
    
    if (_yellowViewController && !_yellowViewController.view.superview) {
        _yellowViewController = nil;
    }
}

- (IBAction)switchViews:(UIBarButtonItem *)sender{
    
//    if (_yellowViewController.view.superview == nil) {
//        if (_yellowViewController == nil) {
//            _yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Yellow"];
//        }
//    }else if (_blueViewController.view.superview == nil){
//        if (_blueViewController == nil) {
//            _blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
//        }
//    }
    if (!_yellowViewController) {
        _yellowViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Yellow"];
    }
    
    if (!_blueViewController) {
        _blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
    }
    
    // animation
    [UIView beginAnimations:@"View Flip" context:nil];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    
    if(_blueViewController && _blueViewController.view.superview){
        // apply animation
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
        
        _yellowViewController.view.frame = self.view.frame;
        // switch vc
        [self switchViewControllerFrom:_blueViewController To:_yellowViewController];
    }else{
        //apply animation
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view cache:YES];
        
        _blueViewController.view.frame = self.view.frame;
        // switch vc
        [self switchViewControllerFrom:_yellowViewController To:_blueViewController];
    }
    
    [UIView commitAnimations];
    

    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _blueViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"Blue"];
    
    _blueViewController.view.frame = self.view.frame;
    [self switchViewControllerFrom:nil To:_blueViewController];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
