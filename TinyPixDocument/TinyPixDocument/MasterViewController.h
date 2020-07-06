//
//  MasterViewController.h
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@property (nonatomic, weak) IBOutlet UISegmentedControl* colorControl;

- (IBAction)chooseColor:(UISegmentedControl *)sender;


@end

