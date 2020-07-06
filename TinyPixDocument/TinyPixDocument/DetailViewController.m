//
//  DetailViewController.m
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "DetailViewController.h"
#import "TinyPixView.h"
#import "TinyPixUtils.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)configureView {
    // Update the user interface for the detail item.
//    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
//    }
    if (self.detailItem && self.isViewLoaded) {
        self.pixView.document = self.detailItem;
        [self.pixView setNeedsDisplay];
    }
}

- (void)updateTintColor{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger selectedColorIndex = [prefs integerForKey:@"selectedColorIndex"];
    UIColor *tintColor = [TinyPixUtils getTintColorForIndex:selectedColorIndex];
    self.pixView.tintColor = tintColor;
    [self.pixView setNeedsDisplay];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureView];
    [self updateTintColor];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(onSettingsChanged:) name:NSUserDefaultsDidChangeNotification object:nil];
}

- (void)onSettingsChanged:(NSNotification *)notification{
    [self updateTintColor];
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(NSDate *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)dealloc{
    [NSNotificationCenter.defaultCenter removeObserver:self name:NSUserDefaultsDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    UIDocument *doc = self.detailItem;
    if (doc) {
        [doc closeWithCompletionHandler:nil];
    }
}


@end
