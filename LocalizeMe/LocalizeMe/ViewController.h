//
//  ViewController.h
//  LocalizeMe
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) IBOutlet UILabel *localeLabel;
@property (nonatomic) IBOutlet UIImageView *flagImageView;
@property (nonatomic) IBOutletCollection(UILabel) NSArray *labels;


@end

