//
//  ViewController.m
//  PinchMe
//
//  Created by nuko on 2020/7/5.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) CGFloat scale;
@property (nonatomic) CGFloat previousScale;
@property (nonatomic) CGFloat rotation;
@property (nonatomic) CGFloat previousRotation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scale = 1.0;
    self.previousScale = 1.0;
    
    // Do any additional setup after loading the view.
    
    UIImage *image = [UIImage imageNamed:@"smiley.jpg"];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.center = self.view.center;
    CGRect newFrame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, 200, 200);
    self.imageView.frame = newFrame;
    [self.view addSubview:self.imageView];
    
    UIPinchGestureRecognizer *pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(doPinch:)];
    
    pinchGesture.delegate = self;
    [self.imageView addGestureRecognizer:pinchGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(doRotate:)];
    rotationGesture.delegate = self;
    [self.imageView addGestureRecognizer:rotationGesture];
    
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

- (void)transformImageView{
    CGAffineTransform t = CGAffineTransformMakeScale(self.scale * self.previousScale, self.scale*self.previousScale);
    
    t = CGAffineTransformRotate(t, self.rotation + self.previousRotation);
    self.imageView.transform = t;
}

- (void)doPinch:(UIPinchGestureRecognizer *)gesture{
    self.scale = gesture.scale;
    [self transformImageView];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.previousScale = self.scale * self.previousScale;
        self.scale = 1;
    }
}

- (void)doRotate:(UIRotationGestureRecognizer *)gesture{
    self.rotation = gesture.rotation;
    [self transformImageView];
    if (gesture.state == UIGestureRecognizerStateEnded) {
        self.previousRotation = self.rotation + self.previousRotation;
        self.rotation = 0;
    }
}


@end
