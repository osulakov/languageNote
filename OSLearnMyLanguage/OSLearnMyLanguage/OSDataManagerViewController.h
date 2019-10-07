//
//  OSDataManagerViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/29/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSDataManagerViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@end

NS_ASSUME_NONNULL_END
