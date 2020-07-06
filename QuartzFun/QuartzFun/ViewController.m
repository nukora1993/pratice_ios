//
//  ViewController.m
//  QuartzFun
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import "QuartzFunView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)changeShape:(UISegmentedControl *)sender {
    Shape shapeSelection = sender.selectedSegmentIndex;
    Shape shape = shapeSelection;
    if (shape >= 0) {
        QuartzFunView *funView = (QuartzFunView *)self.view;
        funView.shape = shape;
        self.colorController.hidden = shape == image;
        
    }
}

- (IBAction)changeColor:(UISegmentedControl *)sender {
    DrawingColor drawingColorSelection = sender.selectedSegmentIndex;
    DrawingColor drawingColor = drawingColorSelection;
    if (drawingColor >= 0) {
        QuartzFunView *funView = (QuartzFunView *)self.view;
        switch (drawingColor) {
            case red:
                funView.currentColor = UIColor.redColor;
                funView.useRandomColor = NO;
                break;
            case blue:
                funView.currentColor = UIColor.blueColor;
                funView.useRandomColor = NO;
                break;
            case yellow:
                funView.currentColor = UIColor.yellowColor;
                funView.useRandomColor = NO;
                break;
            case randomColor:
                funView.useRandomColor = YES;
                break;
                
                
            default:
                break;
        }
    }
    
}
@end
