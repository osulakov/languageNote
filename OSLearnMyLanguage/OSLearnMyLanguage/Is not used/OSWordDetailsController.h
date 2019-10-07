//
//  OSWordDetails.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/21/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "OSDataManagerViewController.h"

@class OSWordEntity;

NS_ASSUME_NONNULL_BEGIN

@interface OSWordDetailsController : UITableViewController <UITextFieldDelegate, UIPickerViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (assign, nonatomic) BOOL isEditingMode;
@property (assign, nonatomic) BOOL isNewWord;
@property (strong, nonatomic) OSWordEntity* word;

@property (weak, nonatomic) IBOutlet UITextField* nameTextField;
@property (weak, nonatomic) IBOutlet UITextField* translationTextField;
@property (weak, nonatomic) IBOutlet UITextView* explanationTextView;
@property (weak, nonatomic) IBOutlet UITextView* contextTextView;
@property (weak, nonatomic) IBOutlet UITextField* areaTextField;

@end

NS_ASSUME_NONNULL_END
