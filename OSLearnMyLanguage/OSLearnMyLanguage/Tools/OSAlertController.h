//
//  OSAlertController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/21/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSAlertController : UIAlertController

+ (UIAlertController*)alertActionWithMessage:(NSString*)message;

@end

NS_ASSUME_NONNULL_END
