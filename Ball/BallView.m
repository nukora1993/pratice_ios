//
//  BallView.m
//  Ball
//
//  Created by nuko on 2020/7/6.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "BallView.h"

@interface BallView ()

@property (nonatomic) UIImage *image;
@property (nonatomic) CGPoint currentPoint;
@property (nonatomic) float ballXVelocity;
@property (nonatomic) float ballYVelocity;
@property (nonatomic) NSDate *lastUpdateTime;

@end

@implementation BallView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (void)commonInit{
    self.image = [UIImage imageNamed:@"ball.jpeg"];
    self.lastUpdateTime = [NSDate date];
    self.currentPoint = CGPointMake(self.bounds.size.width / 2.0 + self.image.size.width / 2.0, self.bounds.size.height / 2.0 + self.image.size.height / 2.0);
}

- (void)drawRect:(CGRect)rect{
    [self.image drawAtPoint:self.currentPoint];
}

- (void)update{
    NSDate *now = [NSDate date];
    NSTimeInterval secondsSinceLastDraw = [now timeIntervalSinceDate:self.lastUpdateTime];
    
    self.ballXVelocity = self.ballXVelocity + (self.acceleration.x * secondsSinceLastDraw);
    self.ballYVelocity = self.ballYVelocity - (self.acceleration.y * secondsSinceLastDraw);
    
    double xDelta = secondsSinceLastDraw * self.ballXVelocity * 500;
    double yDelta = secondsSinceLastDraw * self.ballYVelocity * 500;
    
    self.currentPoint = CGPointMake(self.currentPoint.x + xDelta, self.currentPoint.y + yDelta);
    
    self.lastUpdateTime = now;
}

- (void)setCurrentPoint:(CGPoint)currentPoint{
    double newX = currentPoint.x;
    double newY = currentPoint.y;
    
    CGRect prevRect = CGRectMake(self.currentPoint.x, self.currentPoint.y, self.image.size.width, self.image.size.height);

    
    if (newX < 0) {
        newX = 0;
        self.ballXVelocity = 0;
    }else if (newX > self.bounds.size.width - self.image.size.width){
        newX = self.bounds.size.width - self.image.size.width;
        self.ballXVelocity = 0;
    }
    
    if (newY < 0) {
        newY = 0;
        self.ballYVelocity = 0;
    }else if (newY > self.bounds.size.height - self.image.size.height){
        newY = self.bounds.size.height - self.image.size.height;
        self.ballYVelocity = 0;
    }
    
    _currentPoint = CGPointMake(newX, newY);
    CGRect currentRect = CGRectMake(newX, newY, newX + self.image.size.width, newY + self.image.size.height);
    
    [self setNeedsDisplayInRect:CGRectUnion(prevRect, currentRect)];
    
    }



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
