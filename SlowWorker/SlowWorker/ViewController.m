//
//  ViewController.m
//  SlowWorker
//
//  Created by nuko on 2020/7/4.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (NSString *)fetchSomethingFromServer{
    [NSThread sleepForTimeInterval:1];
    return @"Hi there";
}

- (NSString *)processData:(NSString *)data{
    [NSThread sleepForTimeInterval:1];
    return data.uppercaseString;
}

- (NSString *)calculateFirstResult:(NSString *)data{
    [NSThread sleepForTimeInterval:1];
    return [NSString stringWithFormat:@"Number of chars %ld", data.length];
}

- (NSString *)calculateSecondResult:(NSString *)data{
    [NSThread sleepForTimeInterval:1];
    return [data stringByReplacingOccurrencesOfString:@"E" withString:@"e"];
}

- (void)doWork:(id)sender{
    NSDate *startTime = [NSDate date];
    self.resultsTextView.text = @"";
    
    self.startButton.enabled = NO;
    [self.spinner startAnimating];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        NSString *fetchedData = [self fetchSomethingFromServer];
        NSString *processedData = [self processData:fetchedData];
        
        
        __block NSString *firstResult = nil;
        __block NSString *secondResult = nil;
        __block NSString *resultSummary = nil;
        
        dispatch_group_t group = dispatch_group_create();
        
        dispatch_group_async(group, queue, ^{
           firstResult = [self calculateFirstResult:processedData];
        });
        
        dispatch_group_async(group, queue, ^{
            secondResult = [self calculateSecondResult:processedData];
        });
        
        dispatch_group_notify(group, queue, ^{
            resultSummary = [NSString stringWithFormat:@"First result: %@ \n Second result: %@", firstResult, secondResult];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                       self.resultsTextView.text = resultSummary;
                       self.startButton.enabled = YES;
                       [self.spinner stopAnimating];
                   });
                   
                   NSDate *endTime = [NSDate date];
                   NSLog(@"Completed in %f seconds", [endTime timeIntervalSinceDate:startTime]);
        });
        
        
        
       
    });
    
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end
