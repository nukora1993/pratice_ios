//
//  DetailViewController.h
//  TinyPixDocument
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TinyPixView;
@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet TinyPixView *pixView;

@end

