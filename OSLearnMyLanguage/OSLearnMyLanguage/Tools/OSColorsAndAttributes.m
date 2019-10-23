//
//  OSTextAttributes.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/30/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSColorsAndAttributes.h"

#define FONT_SIZE_TITLE 20
#define FONT_SIZE_TEXT 18
#define FONT_NAME @"Helvetica-Light"

//Color scheme #1 GREEN
#define COLOR_0 [self getColorWithRed:50 andGreen:137 andBlue:68 andAlpha:1.0] //extra dark
#define COLOR_1 [self getColorWithRed:50 andGreen:183 andBlue:68 andAlpha:1.0] //strong darkness
#define COLOR_2 [self getColorWithRed:50 andGreen:183 andBlue:68 andAlpha:1.0] //medium darkness
#define COLOR_3 [self getColorWithRed:50 andGreen:183 andBlue:68 andAlpha:0.2] //light
#define COLOR_4 [self getColorWithRed:50 andGreen:183 andBlue:68 andAlpha:0.05] //extra light

#define COLOR_5 [self getColorWithRed:246 andGreen:246 andBlue:246 andAlpha:1.0] //extra light gray


@implementation OSColorsAndAttributes

+ (NSAttributedString*)getAttributedTitleStringFromString:(NSString*)string {
    
    UIFont* font = [UIFont fontWithName:FONT_NAME size:FONT_SIZE_TITLE];
    UIColor* color = COLOR_2;
    
    NSMutableAttributedString* attributedStr =
    [[NSMutableAttributedString alloc] initWithString:string
                                           attributes:@{
                                                        NSFontAttributeName : font,
                                                        NSForegroundColorAttributeName : color
                                                        }];
    
    return attributedStr;
}

+ (NSAttributedString*)getAttributedTextStringFromString:(NSString*)string {
    
    UIFont* font = [UIFont fontWithName:FONT_NAME size:FONT_SIZE_TEXT];
    UIColor* color = COLOR_2;
    
    NSMutableAttributedString* attributedStr =
    [[NSMutableAttributedString alloc] initWithString:string
                                           attributes:@{
                                                        NSFontAttributeName : font,
                                                        NSForegroundColorAttributeName : color
                                                        }];
    
    return attributedStr;
}

+ (NSAttributedString*)highlightWord:(NSString*)string inText:(NSString*)text {
    
    UIFont* font = [UIFont fontWithName:FONT_NAME size:FONT_SIZE_TEXT];
    UIColor* color = [UIColor darkGrayColor];
    UIColor* colorHighlighted = [self getColorWithRed:250 andGreen:250 andBlue:250 andAlpha:1.0];
    UIColor* colorHighlightedBackground = [self getColorWithRed:250 andGreen:0 andBlue:0 andAlpha:1.0];
    
    NSMutableAttributedString* attributedStr =
    [[NSMutableAttributedString alloc] initWithString:text
                                           attributes:@{
                                                        NSFontAttributeName : font,
                                                        NSForegroundColorAttributeName : color
                                                        }];
    
    if ([text rangeOfString:string].location != NSNotFound) {
        
        NSRange stringRange = NSMakeRange([text rangeOfString:string].location, string.length);
        
        [attributedStr addAttribute:NSForegroundColorAttributeName value:colorHighlighted range:stringRange];
        [attributedStr addAttribute:NSBackgroundColorAttributeName value:colorHighlightedBackground range:stringRange];
        
    }
    
    
    return attributedStr;
    
}

+ (UIColor*)getColorWithRed:(NSInteger)red andGreen:(NSInteger)green andBlue:(NSInteger)blue andAlpha:(CGFloat)alpha {
    
    CGFloat r = (CGFloat)red / 255.f;
    CGFloat g = (CGFloat)green / 255.f;
    CGFloat b = (CGFloat)blue / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
    
}

+ (UIFont*)getTextFont {
    UIFont* textFont = [UIFont fontWithName:FONT_NAME size:FONT_SIZE_TEXT];
    return textFont;
}

+ (UIColor*)getExtraDarkGreenColor {
    UIColor* textColor = COLOR_0;
    return textColor;
}

+ (UIColor*)getDarkGreenColor {
    UIColor* color = COLOR_1;
    return color;
}

+ (UIColor*)getMediumGreenColor {
    UIColor* color = COLOR_2;
    return color;
}

+ (UIColor*)getViewBackgroundColor {
    //UIColor* color = COLOR_3;
    return [UIColor whiteColor];
}

+ (UIColor*)getCellColor {
    UIColor* color = COLOR_4;
    return color;
}

+ (UIColor*)getExtraLightGrayColor {
    UIColor* color = COLOR_5;
    return color;
}

@end
