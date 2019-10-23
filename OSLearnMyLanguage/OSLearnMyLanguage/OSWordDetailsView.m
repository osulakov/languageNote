//
//  OSWordDetailsViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 9/4/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSWordDetailsView.h"
#import "OSWordArea+CoreDataClass.h"
#import "OSColorsAndAttributes.h"

@interface OSWordDetailsView ()

@property (strong, nonatomic) UIVisualEffectView* blurEffectView;

@end

@implementation OSWordDetailsView

- (instancetype)initWithFrame:(CGRect)frame andWord:(OSWordEntity*)word
{
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [OSColorsAndAttributes getMediumGreenColor];
    self.alpha = 0.8;
    self.layer.cornerRadius = 4;
    
    double frameOffset = 7;
    
    double part = self.bounds.size.width / 15;
    
    CGRect contentRect = CGRectMake(frameOffset, self.bounds.size.height / 8,
                                self.bounds.size.width - (frameOffset * 2),
                                self.bounds.size.height / 8 * 6);
    UIView* contentView = [[UIView alloc] initWithFrame:contentRect];
    contentView.backgroundColor = [OSColorsAndAttributes getExtraLightGrayColor];
    contentView.alpha = 1.0;
    
    contentView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addSubview:contentView];
    
    double lineWidth = contentView.bounds.size.width;
    
    CGRect line1Rect = CGRectMake(0, 0, lineWidth, part);
    UILabel* line1Label = [[UILabel alloc] initWithFrame:line1Rect];
    line1Label.backgroundColor = [OSColorsAndAttributes getExtraLightGrayColor];
    line1Label.textColor = [UIColor grayColor];
    line1Label.alpha = 1.0;
    line1Label.font = [UIFont fontWithName:@"Helvetica-Light" size:10];
    line1Label.text = [NSString stringWithFormat:@"   Word name"];
    line1Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line1Label];
    
    CGRect line2Rect = CGRectMake(0, line1Rect.size.height, lineWidth, part * 1.2);
    UILabel* line2Label = [[UILabel alloc] initWithFrame:line2Rect];
    line2Label.backgroundColor = [UIColor whiteColor];
    line2Label.alpha = 1.0;
    line2Label.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    line2Label.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
    line2Label.text = [NSString stringWithFormat:@"  %@", word.wordName];
    line2Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line2Label];
    
    CGRect line3Rect = CGRectMake(0, line2Rect.origin.y + line2Rect.size.height, lineWidth, part);
    UILabel* line3Label = [[UILabel alloc] initWithFrame:line3Rect];
    line3Label.backgroundColor = [OSColorsAndAttributes getExtraLightGrayColor];
    line3Label.textColor = [UIColor grayColor];
    line3Label.alpha = 1.0;
    line3Label.font = [UIFont fontWithName:@"Helvetica-Light" size:10];
    line3Label.text = [NSString stringWithFormat:@"   Word translation"];
    line3Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line3Label];
    
    CGRect line4Rect = CGRectMake(0, line3Rect.origin.y + line3Rect.size.height, lineWidth, part * 1.2);
    UILabel* line4Label = [[UILabel alloc] initWithFrame:line4Rect];
    line4Label.backgroundColor = [UIColor whiteColor];
    line4Label.alpha = 1.0;
    line4Label.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    line4Label.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
    line4Label.text = [NSString stringWithFormat:@"  %@", word.wordTranslation];
    line4Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line4Label];
    
    CGRect line5Rect = CGRectMake(0, line4Rect.origin.y + line4Rect.size.height, lineWidth, part);
    UILabel* line5Label = [[UILabel alloc] initWithFrame:line5Rect];
    line5Label.backgroundColor = [OSColorsAndAttributes getExtraLightGrayColor];
    line5Label.textColor = [UIColor grayColor];
    line5Label.alpha = 1.0;
    line5Label.font = [UIFont fontWithName:@"Helvetica-Light" size:10];
    line5Label.text = [NSString stringWithFormat:@"   Word category"];
    line5Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line5Label];
    
    CGRect line6Rect = CGRectMake(0, line5Rect.origin.y + line5Rect.size.height, lineWidth, part * 1.2);
    UILabel* line6Label = [[UILabel alloc] initWithFrame:line6Rect];
    line6Label.backgroundColor = [UIColor whiteColor];
    line6Label.alpha = 1.0;
    line6Label.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    line6Label.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
    line6Label.text = [NSString stringWithFormat:@"  %@", word.area.areaName];
    line6Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line6Label];
    
    CGRect line7Rect = CGRectMake(0, line6Rect.origin.y + line6Rect.size.height, lineWidth, part);
    UILabel* line7Label = [[UILabel alloc] initWithFrame:line7Rect];
    line7Label.backgroundColor = [OSColorsAndAttributes getExtraLightGrayColor];
    line7Label.textColor = [UIColor grayColor];
    line7Label.alpha = 1.0;
    line7Label.font = [UIFont fontWithName:@"Helvetica-Light" size:10];
    line7Label.text = [NSString stringWithFormat:@"   Explanation"];
    line7Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line7Label];
    
    CGRect line8Rect = CGRectMake(0, line7Rect.origin.y + line7Rect.size.height, lineWidth, part * 2); //make it flexible !!
    UITextView* line8TextView = [[UITextView alloc] initWithFrame:line8Rect];
    line8TextView.backgroundColor = [UIColor whiteColor];
    line8TextView.alpha = 1.0;
    line8TextView.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    line8TextView.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
    line8TextView.text = [NSString stringWithFormat:@"  %@", word.wordExplanation];
    line8TextView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line8TextView];
    
    CGRect line9Rect = CGRectMake(0, line8Rect.origin.y + line8Rect.size.height, lineWidth, part);
    UILabel* line9Label = [[UILabel alloc] initWithFrame:line9Rect];
    line9Label.backgroundColor = [OSColorsAndAttributes getExtraLightGrayColor];
    line9Label.textColor = [UIColor grayColor];
    line9Label.alpha = 1.0;
    line9Label.font = [UIFont fontWithName:@"Helvetica-Light" size:10];
    line9Label.text = [NSString stringWithFormat:@"   Context"];
    line9Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line9Label];
    
    CGRect line10Rect = CGRectMake(0, line9Rect.origin.y + line9Rect.size.height, lineWidth, part * 2); //make it flexible !!
    UITextView* line10TextView = [[UITextView alloc] initWithFrame:line10Rect];
    line10TextView.backgroundColor = [UIColor whiteColor];
    line10TextView.alpha = 1.0;
    line10TextView.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    line10TextView.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
    line10TextView.text = [NSString stringWithFormat:@"  %@", word.wordContext];
    line10TextView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [contentView addSubview:line10TextView];
    
    CGRect bottomRect = CGRectMake(frameOffset,
                                   ((self.bounds.size.height / 8) * 7),
                                   self.bounds.size.width  - frameOffset * 2,
                                   self.bounds.size.height / 8);

    UIButton* okButton = [UIButton buttonWithType:UIButtonTypeCustom];
    okButton.frame = bottomRect;
    okButton.backgroundColor = [UIColor clearColor];
    [okButton setTitle:@"OK" forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [okButton setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    line1Label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [okButton addTarget:self action:@selector(actionOK:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:okButton];
    
    return self;
}

- (void)dealloc {
    NSLog(@"OSWordDetailsView dealloc");
    
}

#pragma mark - Actions

- (void)actionOK:(UIButton*)sender {
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.6f];
    self.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
    self.alpha = 0;
    [UIView commitAnimations];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
}



@end
