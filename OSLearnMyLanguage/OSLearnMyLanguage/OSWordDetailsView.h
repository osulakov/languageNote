//
//  OSWordDetailsViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 9/4/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSWordEntity+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface OSWordDetailsView : UIView

- (instancetype)initWithFrame:(CGRect)frame andWord:(OSWordEntity*)word;

@end

NS_ASSUME_NONNULL_END
