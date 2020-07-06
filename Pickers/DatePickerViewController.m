//
//  DatePickerViewController.m
//  Pickers
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "DatePickerViewController.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController
- (IBAction)onButtonPressed:(UIButton *)sender {
    NSDate *date = _datePicker.date;
    
    NSString *message = [NSString stringWithFormat:@"The date and time you selected is %@", date];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Date and time selected" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"That's so true!" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSinceNow:0];
    
    _datePicker.date = date;
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
