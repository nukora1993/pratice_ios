//
//  FontInfoViewController.m
//  Fonts
//
//  Created by nuko on 2020/6/28.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "FontInfoViewController.h"
#import "FavoritesList.h"

@interface FontInfoViewController ()

@end

@implementation FontInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _favorite = NO;
    _fontSampleLabel.font = _font;
    _fontSampleLabel.text = @"AaBbCcDdEe1234567890";
    _fontSizeSlider.value = _font.pointSize;
    _fontSizeLabel.text = [NSString stringWithFormat:@"%d", (int)_font.pointSize];
    _favoriteSwitch.on = _favorite;
    
   
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)toggleFavorite:(UISwitch *)sender {
    FavoritesList *favoritesList = [FavoritesList sharedFavoriteList];
    if (sender.isOn) {
        [favoritesList addFavorite:_font.fontName];
        
    }else{
        [favoritesList removeFavorite:_font.fontName];
    }
    
}
- (IBAction)slideFontSize:(UISlider *)sender {
    int newSize = roundf(sender.value);
    _fontSampleLabel.font = [_font fontWithSize:(CGFloat)newSize];
    _fontSizeLabel.text = [NSString stringWithFormat:@"%d", newSize];
    
    
}



@end
