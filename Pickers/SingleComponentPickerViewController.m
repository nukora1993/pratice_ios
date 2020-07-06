//
//  SingleComponentPickerViewController.m
//  Pickers
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "SingleComponentPickerViewController.h"

@interface SingleComponentPickerViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray* characterNames;

@end

@implementation SingleComponentPickerViewController

# pragma mark - picker data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _characterNames.count;
}

# pragma mark - picker delegate
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _characterNames[row];
}

- (IBAction)onButtonPressed:(UIButton *)sender {
    NSInteger row = [_singlePicker selectedRowInComponent:0];
    
    NSString *selected = _characterNames[row];
    
    NSString *title = [NSString stringWithFormat:@"You selected %@", selected];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:@"Than you for choosing" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"You're welcome" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _characterNames = @[@"Han", @"mei", @"mei", @"li", @"lei"];
    
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
