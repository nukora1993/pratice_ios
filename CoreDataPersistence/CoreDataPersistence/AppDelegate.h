//
//  AppDelegate.h
//  CoreDataPersistence
//
//  Created by nuko on 2020/7/1.
//  Copyright © 2020 nuko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

//@property (readonly, strong) NSPersistentContainer *persistentContainer;

@property (nonatomic) NSURL *applicationDocumentDirectory;
@property (nonatomic) NSManagedObjectModel *managedObjectModel;
@property (nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

- (void)saveContext;


@end

