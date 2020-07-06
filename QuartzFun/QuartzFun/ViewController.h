//
//  ViewController.h
//  QuartzFun
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorController;

- (IBAction)changeColor:(UISegmentedControl *)sender;
- (IBAction)changeShape:(UISegmentedControl *)sender;

@end

