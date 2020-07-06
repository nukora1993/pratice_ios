//
//  ViewController.m
//  CoreDataPersistence
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

static NSString * const lineEntityName = @"Line";
static NSString * const lineNumberKey = @"lineNumber";
static NSString * const lineTextKey = @"lineText";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:lineEntityName];
    
    NSArray *objects = [context executeFetchRequest:request error:nil];
    
    
    for (id object in objects) {
        NSNumber *lineNum = [object valueForKey:lineNumberKey];
        NSString *lineText = [object valueForKey:lineTextKey];
        UITextField *textField = self.lineFields[lineNum.intValue];
        textField.text = lineText;
        
    }
    
    UIApplication *app = UIApplication.sharedApplication;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    AppDelegate *appDelegate = (AppDelegate *)UIApplication.sharedApplication.delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    for (int i = 0; i < self.lineFields.count; i++) {
        UITextField *textField = self.lineFields[i];
        
        NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:lineEntityName];
        
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"%K = %d", lineNumberKey, i];
        
        request.predicate = pred;
        
        NSArray *objects = [context executeFetchRequest:request error:nil];
        
        NSManagedObject *theLine = objects.firstObject;
        
        // if it is first save
        if (!theLine) {
            theLine = [NSEntityDescription insertNewObjectForEntityForName:lineEntityName inManagedObjectContext:context];
        }
        
        // update managed object
        [theLine setValue:[NSNumber numberWithInt:i] forKey:lineNumberKey];
        [theLine setValue:textField.text forKey:lineTextKey];
        
    }
    
    // save managed object to disk
    [appDelegate saveContext];
}
    
    


@end
