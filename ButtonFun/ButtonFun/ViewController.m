//
//  ViewController.m
//  ButtonFun
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)buttonPressed:(UIButton *)sender {
    NSString *title = [sender titleForState:UIControlStateSelected];
    NSString *text = [NSString stringWithFormat:@"%@ button pressed", title];
    _statusLabel.text = text;
    
    // attribute text
    NSMutableAttributedString *styledText = [[NSMutableAttributedString alloc] initWithString:text];
    NSDictionary *attribute = @{
        NSFontAttributeName:[UIFont boldSystemFontOfSize:_statusLabel.font.pointSize]
    };
    NSRange nameRange = [text rangeOfString:title];
    [styledText setAttributes:attribute range:nameRange];
    _statusLabel.attributedText = styledText;
    
    
    
    
    
    
}


@end
