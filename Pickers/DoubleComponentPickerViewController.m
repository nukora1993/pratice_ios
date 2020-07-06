//
//  DoubleComponentPickerViewController.m
//  Pickers
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "DoubleComponentPickerViewController.h"

@interface DoubleComponentPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) int fillingComponent;
@property (nonatomic) int breadComponent;
@property (nonatomic) NSArray *fillingTypes;
@property (nonatomic) NSArray *breadTypes;
@end

@implementation DoubleComponentPickerViewController
# pragma mark - picker data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == _breadComponent) {
        return _breadTypes.count;
    }else{
        return _fillingTypes.count;
    }
}

# pragma mark - picker delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == _breadComponent) {
        return _breadTypes[row];
    }else{
        return _fillingTypes[row];
    }
}

- (IBAction)onButtonPressed:(UIButton *)sender {
    NSInteger fillingRow = [_doublePicker selectedRowInComponent:_fillingComponent];
    
    NSInteger breadRow = [_doublePicker selectedRowInComponent:_breadComponent];
    
    NSString *filling = _fillingTypes[fillingRow];
    
    NSString *bread = _breadTypes[breadRow];
    
    NSString *message = [NSString stringWithFormat:@"You filling %@ on %@ bread will be bright up", filling, bread];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Than you for your code" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Great" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _fillingComponent = 0;
    
    _breadComponent = 1;
    
    _fillingTypes = @[@"egg", @"pork", @"water"];
    
    _breadTypes = @[@"white", @"black"];
    
    
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
