//
//  OSSmallCardView.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 9/17/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSSmallCardView.h"
#import "OSColorsAndAttributes.h"

@implementation OSSmallCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect labelRect0 = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        UILabel* centerLabel = [[UILabel alloc] initWithFrame:labelRect0];
        centerLabel.backgroundColor = [UIColor clearColor];
        centerLabel.textColor = [UIColor whiteColor];
        centerLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:45];
        centerLabel.textAlignment = NSTextAlignmentCenter;
        centerLabel.alpha = 1.0;
        
        self.centerLabel = centerLabel;
        [self addSubview:self.centerLabel]; //subview with index 0
        
        CGRect labelRect = CGRectMake(0, 0, frame.size.width, frame.size.height / 2);
        
        UILabel* nameLabel = [[UILabel alloc] initWithFrame:labelRect];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor whiteColor];
        nameLabel.textAlignment = NSTextAlignmentCenter;
        nameLabel.alpha = 0;
        
        self.nameLabel = nameLabel;
        [self addSubview:self.nameLabel]; //subview with index 1
        
        CGRect labelRect2 = CGRectMake(0, frame.size.height / 2,
                                       frame.size.width,
                                       frame.size.height / 2);
        
        UILabel* translationLabel = [[UILabel alloc] initWithFrame:labelRect2];
        translationLabel.backgroundColor = [UIColor clearColor];
        translationLabel.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
        translationLabel.textAlignment = NSTextAlignmentCenter;
        translationLabel.alpha = 0;
        
        self.translationLabel = translationLabel;
        [self addSubview:self.translationLabel]; //subview with index 2
        
        
    }
    return self;
}

@end
