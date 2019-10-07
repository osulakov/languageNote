//
//  OSTextAttributes.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/30/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSColorsAndAttributes : NSObject

+ (NSAttributedString*)getAttributedTitleStringFromString:(NSString*)string;
+ (NSAttributedString*)getAttributedTextStringFromString:(NSString*)string;
+ (NSAttributedString*)highlightWord:(NSString*)string inText:(NSString*)text;
+ (UIColor*)getColorWithRed:(NSInteger)red andGreen:(NSInteger)green andBlue:(NSInteger)blue andAlpha:(CGFloat)alpha;
+ (UIColor*)darkGreenTextColor;
+ (UIFont*)getTextFont;
+ (UIColor*)getExtraDarkGreenColor;
+ (UIColor*)getTabBarItemColor;
+ (UIColor*)getViewBackgroundColor;
+ (UIColor*)getCellColor;
+ (UIColor*)getDarkGreenColor;

@end

NS_ASSUME_NONNULL_END
