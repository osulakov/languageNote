//
//  ViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/6/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <Firebase.h>
#import "OSDataManagerViewController.h"

typedef enum {
    
    OSChangeSortingByDateDay,
    OSChangeSortingByDateWeek,
    OSChangeSortingByDateMonth,
    OSChangeSortingByDateAll
    
} OSChangeSortingByDate;

@interface OSWordViewController : OSDataManagerViewController

@property (assign, nonatomic) IBOutlet UISegmentedControl* wordListModeControl;

- (IBAction)actionChangeSortingByDate:(UISegmentedControl*)sender;

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

//- (void)configureSelectedCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

@end

