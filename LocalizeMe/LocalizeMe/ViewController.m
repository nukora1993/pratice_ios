//
//  ViewController.m
//  LocalizeMe
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLocale *locale = NSLocale.currentLocale;
    NSString *currentLangID = NSLocale.preferredLanguages[0];
    NSString *displayLang = [locale displayNameForKey:NSLocaleLanguageCode value:currentLangID];
    NSString *capitalized = [displayLang capitalizedStringWithLocale:locale];
    self.localeLabel.text = capitalized;
    
    
    ((UILabel *)self.labels[0]).text = NSLocalizedString(@"LABEL_ONE", @"The number 1");
    ((UILabel *)self.labels[1]).text = NSLocalizedString(@"LABEL_TWO", @"The number 2");
    ((UILabel *)self.labels[2]).text = NSLocalizedString(@"LABEL_THREE", @"The number 3");
    ((UILabel *)self.labels[3]).text = NSLocalizedString(@"LABEL_FOUR", @"The number 4");
    ((UILabel *)self.labels[4]).text = NSLocalizedString(@"LABEL_FIVE", @"The number 5");
    
    NSString *flagFile = NSLocalizedString(@"FLAG_FILE", @"Name of the flag");
    self.flagImageView.image = [UIImage imageNamed:flagFile];




    
        
    
    
    
}


@end
