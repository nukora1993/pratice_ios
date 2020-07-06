//
//  CustomPickerViewController.m
//  Pickers
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "CustomPickerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CustomPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) NSArray *images;
@property (nonatomic) SystemSoundID winSoundID;
@property (nonatomic) SystemSoundID crunchSoundID;

@end

@implementation CustomPickerViewController
# pragma mark - picker data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _images.count;
}

# pragma mark - picker delegate
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UIImage *image = _images[row];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    imageView.clipsToBounds = YES;
    return imageView;
}

- (void)showButton{
    _button.hidden = false;
}

- (void)playWinSound{
    if (_winSoundID == 0) {
        // load audio resouce
        CFURLRef soundURL = (__bridge CFURLRef)[NSBundle.mainBundle URLForResource:@"win" withExtension:@"wav"];
        AudioServicesCreateSystemSoundID(soundURL, &_winSoundID);
    }
    
    AudioServicesPlaySystemSound(_winSoundID);
    _winLabel.text = @"Winner";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showButton];
    });
}

- (IBAction)spin:(UIButton *)sender {
    Boolean win = NO;
    int numInRow = -1;
    int lastVal = -1;
    for (int i = 0; i < 5; i++) {
        int newValue = (int)arc4random_uniform(_images.count);
        
        if (newValue == lastVal) {
            numInRow += 1;
        }else{
            numInRow = 1;
        }
        
        lastVal = newValue;
        
        [_picker selectRow:newValue inComponent:i animated:YES];
        [_picker reloadComponent:i];
        if (numInRow >= 3) {
            win = YES;
        }
    }
    
    if (_crunchSoundID == 0) {
        CFURLRef soundURL = (__bridge CFURLRef)[NSBundle.mainBundle URLForResource:@"crunch" withExtension:@"wav"];
        AudioServicesCreateSystemSoundID(soundURL, &_crunchSoundID);
    }
    AudioServicesPlaySystemSound(_crunchSoundID);
    
    if (win) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self playWinSound];
        });
    }else{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self showButton];
        });
    }
    
    _button.hidden = YES;
    _winLabel.text = @" ";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // image
    _winSoundID = 0;
    _crunchSoundID = 0;
    
    NSString *baidu = @"https://www.baidu.com/img/flexible/logo/pc/result@2.png";
    NSString *jd = @"https://misc.360buyimg.com/lib/img/e/logo-201305-b.png";
    NSString *tianmao = @"https://img.alicdn.com/tfs/TB1MaLKRXXXXXaWXFXXXXXXXXXX-480-260.png";
    NSString *pdd = @"https://cdn.pinduoduo.com/home/static/img/common/pdd_logo_v2.png";
    NSString *tencent = @"https://mat1.gtimg.com/pingjs/ext2020/qqindex2018/dist/img/qq_logo_2x.png";
    
    
    
    
    
    
    
    
    NSArray * imageData = @[
    [NSData dataWithContentsOfURL:[NSURL URLWithString:baidu]],
    [NSData dataWithContentsOfURL:[NSURL URLWithString:jd]],
    [NSData dataWithContentsOfURL:[NSURL URLWithString:tianmao]],
    [NSData dataWithContentsOfURL:[NSURL URLWithString:pdd]],
    [NSData dataWithContentsOfURL:[NSURL URLWithString:tencent]]
    ];
    
    _images = @[
    [UIImage imageWithData:imageData[0]],
    [UIImage imageWithData:imageData[1]],
    [UIImage imageWithData:imageData[2]],
    [UIImage imageWithData:imageData[3]],
    [UIImage imageWithData:imageData[4]]
    ];
    
    
    
    _winLabel.text = @" ";
    arc4random_stir();
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
