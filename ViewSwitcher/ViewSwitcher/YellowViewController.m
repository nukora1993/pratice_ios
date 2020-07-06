//
//  YellowViewController.m
//  ViewSwitcher
//
//  Created by nuko on 2020/6/26.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "YellowViewController.h"

@interface YellowViewController ()

@end

@implementation YellowViewController

- (IBAction)yellowButtonPressed:(UIButton *)sender{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"yellow view button Pressed" message:@"You pressed the button on the yellow view" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Yes, I did" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
