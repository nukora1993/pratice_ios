//
//  ViewController.h
//  SlowWorker
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (nonatomic) IBOutlet UIButton *startButton;
@property (nonatomic) IBOutlet UITextView *resultsTextView;
@property (nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (NSString *)fetchSomethingFromServer;
- (NSString *)processData:(NSString *)data;
- (NSString *)calculateFirstResult:(NSString *)data;
- (NSString *)calculateSecondResult:(NSString *)data;

- (IBAction)doWork:(id)sender;

@end

