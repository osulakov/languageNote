//
//  OSSmallCardView.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 9/17/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSSmallCardView : UIView

@property (strong, nonatomic) UILabel* centerLabel;
@property (strong, nonatomic) UILabel* nameLabel;
@property (strong, nonatomic) UILabel* translationLabel;

@end

NS_ASSUME_NONNULL_END
