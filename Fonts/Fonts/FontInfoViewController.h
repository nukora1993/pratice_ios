//
//  FontInfoViewController.h
//  Fonts
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FontInfoViewController : UIViewController

@property (nonatomic) UIFont *font;
@property (nonatomic) BOOL favorite;
@property (weak, nonatomic) IBOutlet UILabel *fontSampleLabel;
@property (weak, nonatomic) IBOutlet UILabel *fontSizeLabel;
@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;

@property (weak, nonatomic) IBOutlet UISwitch *favoriteSwitch;

@end

NS_ASSUME_NONNULL_END
