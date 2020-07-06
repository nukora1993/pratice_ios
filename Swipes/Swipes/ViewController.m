//
//  ViewController.m
//  Swipes
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

static float minimumGestureLength = 25.0;
static float maximumVariance = 5.0;

@interface ViewController ()

@property (nonatomic) CGPoint gestureStartPoint;

@end

@implementation ViewController

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    // Do any additional setup after loading the view.
//    UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVerticalSwipe:)];
//
//    vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
//
//    [self.view addGestureRecognizer:vertical];
//
//    UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
//
//    horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
//
//    [self.view addGestureRecognizer:horizontal];
//
//
//}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    for (int touchCount = 0; touchCount < 5; touchCount++) {
        UISwipeGestureRecognizer *vertical = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVerticalSwipe:)];
        vertical.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
        vertical.numberOfTouchesRequired = touchCount;
        [self.view addGestureRecognizer:vertical];
        
        UISwipeGestureRecognizer *horizontal = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe:)];
        horizontal.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
        horizontal.numberOfTouchesRequired = touchCount;
        [self.view addGestureRecognizer:horizontal];
        
        
    }
}

- (NSString *)descriptionForTouchCount:(NSInteger)touchCount{
    switch (touchCount) {
        case 1:
            return @"Single";
            break;
        case 2:
            return @"Double";
            break;
        case 3:
            return @"Tripe";
            break;
        case 4:
            return @"Quadruple";
            break;
        case 5:
            return @"Quintuple";
            break;
            
        default:
            return @"";
    }
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = touches.anyObject;
//    if (touch) {
//        self.gestureStartPoint = [touch locationInView:self.view];
//    }
//}

- (void)reportHorizontalSwipe:(UIGestureRecognizer *)recognizer{
    self.label.text = @"Horizontal swipe detected";
    
    NSString *count = [self descriptionForTouchCount:recognizer.numberOfTouches];
    self.label.text = [NSString stringWithFormat:@"%@ finger horizontal swipe detected", count];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.label.text = @"";
    });
}

- (void)reportVerticalSwipe:(UIGestureRecognizer *)recognizer{
    self.label.text = @"Vertical swipe detected";
    
    NSString *count = [self descriptionForTouchCount:recognizer.numberOfTouches];
    self.label.text = [NSString stringWithFormat:@"%@ finger vertical swipe detected", count];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.label.text = @"";
    });
}

//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    UITouch *touch = touches.anyObject;
//    CGPoint gesturePoint = self.gestureStartPoint;
//
//    CGPoint currentPosition = [touch locationInView:self.view];
//
//    float deltaX = fabsf(self.gestureStartPoint.x - currentPosition.x);
//    float deltaY = fabsf(self.gestureStartPoint.y - currentPosition.y);
//
//    if (deltaX >= minimumGestureLength && deltaY <= maximumVariance) {
//        self.label.text = @"Horizontal swipe detected";
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.label.text = @"";
//        });
//    }else if (deltaY >= minimumGestureLength && deltaX <= maximumVariance){
//        self.label.text = @"Vertical swipe detected";
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            self.label.text = @"";
//        });
//    }
//}


@end
