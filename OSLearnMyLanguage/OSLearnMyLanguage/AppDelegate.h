//
//  AppDelegate.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/6/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Firebase.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

