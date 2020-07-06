//
//  ViewController.m
//  Persistence
//
//  Created by nuko on 2020/6/29.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import "FourLines.h"
static NSString * const rootKey = @"rootKey";

@interface ViewController ()

@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSURL *fileURL = [self dataFileURL];
    
    if ([NSFileManager.defaultManager fileExistsAtPath:fileURL.path]) {
        NSArray *array = [NSArray arrayWithContentsOfURL:fileURL];
        if (array) {
            for (int i = 0 ; i < array.count; i++) {
                ((UITextField *)(self.lineFields[i])).text = array[i];
            }
        }
        
        NSMutableData *data = [NSMutableData dataWithContentsOfURL:fileURL];
        NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingFromData:data error:nil];
        
        FourLines *fourLines = [unarchiver decodeObjectForKey:rootKey];
        [unarchiver finishDecoding];
        
        
        
        NSArray *newLines = fourLines.lines;
        if (newLines) {
            for (int i = 0; i < newLines.count; i++) {
                ((UITextField *)(self.lineFields[i])).text = newLines[i];
            }
        }
        
        
    }
    
    
    
    UIApplication *app = UIApplication.sharedApplication;
    if (app) {
        [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    }
    
    
    
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    NSURL *fileURL = [self dataFileURL];
    
    FourLines *fourLines =[[FourLines alloc] init];
    
    NSArray *array = [self.lineFields valueForKey:@"text"];
    fourLines.lines = array;
    
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];



    [archiver encodeObject:fourLines forKey:rootKey];
    [archiver finishEncoding];
    [data writeToURL:fileURL atomically:YES];
    
    [NSKeyedArchiver archiveRootObject:<#(nonnull id)#> toFile:<#(nonnull NSString *)#>]
    
    
    
//    NSError *error = nil;
//    [array writeToURL:fileURL error:&error];
}

- (NSURL *)dataFileURL{
    NSArray *urls = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL *url = [NSURL fileURLWithPath:@""];
//    url = [urls.firstObject URLByAppendingPathComponent:@"data.plist"];
    url = [urls.firstObject URLByAppendingPathComponent:@"data.archive"];
    return url;
}


@end
