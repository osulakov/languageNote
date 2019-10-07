//
//  OSAreaViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/28/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OSDataManagerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OSCategoryViewController : OSDataManagerViewController

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath;

@end

NS_ASSUME_NONNULL_END
