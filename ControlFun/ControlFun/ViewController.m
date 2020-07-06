//
//  ViewController.m
//  ControlFun
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)textFieldDoneEditing:(UITextField *)sender {
    [sender resignFirstResponder];
}
- (IBAction)onTapGestureRecognized:(UITapGestureRecognizer *)sender {
    [_nameField resignFirstResponder];
    [_numberField resignFirstResponder];
}
- (IBAction)sliderChanged:(UISlider *)sender {
    
    
    _sliderLabel.text = [NSString stringWithFormat:@"%d", (int)(sender.value*100)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _sliderLabel.text = @"50";
}
- (IBAction)onButtonPressed:(UIButton *)sender {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:@"Are you show?" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yesAction = [UIAlertAction actionWithTitle:@"Yes, sure!" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSString *msg = [self.nameField.text isEqualToString:@""]
        ?@"You can breath easy, everything went OK."
        :[NSString stringWithFormat:@"You can breath easy %@, everything went OK", self.nameField.text];
        
        UIAlertController *controller2 = [UIAlertController alertControllerWithTitle:@"Some thing was done!" message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Phew" style:UIAlertActionStyleCancel handler:nil];
        [controller2 addAction:cancelAction];
        [self presentViewController:controller2 animated:YES completion:nil];
        
    }];
    
    // invalid on iPad
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"No way!" style:UIAlertActionStyleCancel handler:nil];
    
    [controller addAction:yesAction];
    [controller addAction:noAction];
    
    
    UIPopoverPresentationController *ppc = controller.popoverPresentationController;
    if (ppc) {
        ppc.sourceView = sender;
        ppc.sourceRect = sender.bounds;
        ppc.permittedArrowDirections = UIPopoverArrowDirectionDown;
    }
    
    [self presentViewController:controller animated:YES completion:nil];
}
- (IBAction)onSwitchChanged:(UISwitch *)sender {
    Boolean setting = sender.isOn;
    [_leftSwitch setOn:setting animated:YES];
    [_rightSwitch setOn:setting animated:YES];
    
}

- (IBAction)toggleControls:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        _leftSwitch.hidden = false;
        _rightSwitch.hidden = false;
        _doSomethingButton.hidden = true;
    }else{
        _leftSwitch.hidden = true;
        _rightSwitch.hidden = true;
        _doSomethingButton.hidden = false;
    }
}

@end
