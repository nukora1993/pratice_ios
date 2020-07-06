//
//  DependentComponentPickerViewController.m
//  Pickers
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "DependentComponentPickerViewController.h"

@interface DependentComponentPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) int provinceComponent;
@property (nonatomic) int zipComponent;
@property (nonatomic) NSDictionary *provinceZips;
@property (nonatomic) NSArray *provinces;
@property (nonatomic) NSArray *zips;

@end

@implementation DependentComponentPickerViewController

# pragma mark - picker data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == _provinceComponent) {
        return _provinces.count;
    }else{
        return _zips.count;
    }
}

# pragma mark - picker delegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == _provinceComponent) {
        return _provinces[row];
    }else{
        return _zips[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == _provinceComponent) {
        NSString *selectedProvince = _provinces[row];
        _zips = _provinceZips[selectedProvince];
        [_dependentPicker reloadComponent:_zipComponent];
        [_dependentPicker selectRow:0 inComponent:_zipComponent animated:true];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    NSUInteger pickerWidth = pickerView.bounds.size.width;
    if (component == _zipComponent) {
        return pickerWidth / 3;
    }else{
        return 2 * pickerWidth / 3;
    }
    
}

- (IBAction)onButtonPressed:(UIButton *)sender {
    NSInteger provinceRow = [_dependentPicker selectedRowInComponent:_provinceComponent];
    
    NSInteger zipRow = [_dependentPicker selectedRowInComponent:_zipComponent];
    
    NSString *province = _provinces[provinceRow];
    
    NSString *zip = _zips[zipRow];
    
    NSString *title = [NSString stringWithFormat:@"You selected zip code %@", zip];
    
    NSString *message = [NSString stringWithFormat:@"zip %@ is province %@", zip, province];
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Boolean fake = YES;
    _provinceComponent = 0;
    _zipComponent = 1;
    
    if (fake) {
        _provinceZips = @{@"jiangsu" : @[@"212400", @"215000"],
                          @"whatever province" : @[@"??????", @"?????", @"?????"]
        };
    }else{
        NSBundle *bundle = NSBundle.mainBundle;
        NSURL *plistURL = [bundle URLForResource:@"province_dictionary" withExtension:@"plist"];
        
        _provinceZips = [[NSDictionary alloc] initWithContentsOfURL:plistURL];
        
    }
    NSArray *allProvinces = _provinceZips.allKeys;
    
    _provinces = allProvinces;
    
    NSString *selectedProvince = _provinces[0];
    
    _zips = _provinceZips[selectedProvince];
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
