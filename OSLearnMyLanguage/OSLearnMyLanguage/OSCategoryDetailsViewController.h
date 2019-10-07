//
//  OSAreaDetailsViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/29/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OSDataManagerViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface OSCategoryDetailsViewController : OSDataManagerViewController

@property (strong, nonatomic) NSString* areaName;

@end

NS_ASSUME_NONNULL_END
