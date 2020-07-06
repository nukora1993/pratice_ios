//
//  ViewController.m
//  SQLitePersistence
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import "ViewController.h"
#import <sqlite3.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    sqlite3 *database = nil;
    
    
    int result = sqlite3_open([self dataFilePath].UTF8String, &database);
    if (result != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Failed to open database");
        return;
    }
    
    NSString *createSQL = @"CREATE TABLE IF NOT EXISTS FIELDS"
    "(ROW INTEGER PRIMARY KEY, FIELD_DATA TEXT);";
    
    char *error;
    result = sqlite3_exec(database, createSQL.UTF8String, nil, nil, &error);
    if (result != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Failed to create table");
        return;
    }
    
    NSString *query = @"SELECT ROW, FIELD_DATA FROM FIELDS ORDER BY ROW";
    sqlite3_stmt *statement;
    result = sqlite3_prepare_v2(database, query.UTF8String, -1, &statement, nil);
    if (result == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int row = sqlite3_column_int(statement, 0);
            const unsigned char *rowData = sqlite3_column_text(statement, 1);
            NSString *fieldValue = [NSString stringWithCString:rowData encoding:NSUTF8StringEncoding];
            
            ((UITextField *)self.lineFields[row]).text = fieldValue;
            
            
            
        }
        
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    
    UIApplication *app = UIApplication.sharedApplication;
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
}

- (void)applicationWillResignActive:(NSNotification *)notification{
    sqlite3 *database;
    int result = sqlite3_open([self dataFilePath].UTF8String, &database);
    if (result != SQLITE_OK) {
        sqlite3_close(database);
        NSLog(@"Failed to open database");
        return;
    }
    
    for (int i = 0 ; i < self.lineFields.count; i++) {
        UITextField *field = self.lineFields[i];
        NSString *update = @"INSERT OR REPLACE INTO FIELDS (ROW, FIELD_DATA) "
        "VALUES (?, ?);";
        
        sqlite3_stmt *statement;
        
        result = sqlite3_prepare_v2(database, update.UTF8String, -1, &statement, nil);
        if (result == SQLITE_OK) {
            NSString *text = field.text;
            sqlite3_bind_int(statement, 1, i);
            sqlite3_bind_text(statement, 2, text.UTF8String, -1, nil);
            
        }
        
        result = sqlite3_step(statement);
        if ( result != SQLITE_DONE) {
            NSLog(@"Error updating table");
            sqlite3_close(database);
            return;
        }
        
        sqlite3_finalize(statement);
    }
    
    sqlite3_close(database);
    
}

- (NSString *)dataFilePath{
    NSArray *urls = [NSFileManager.defaultManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSString *url = nil;
    url = [urls.firstObject URLByAppendingPathComponent:@"data.sqlite3"].path;
    return url;
}


@end
