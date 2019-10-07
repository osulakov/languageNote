//
//  OSDataManager.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/21/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (OSDataManager*)sharedManager;

- (void)createWordWithName:(NSString*)name translation:(NSString*)translation area:(NSString*)area explanation:(NSString*)explanation context:(NSString*)context;

- (void)saveContext;

@end

NS_ASSUME_NONNULL_END
