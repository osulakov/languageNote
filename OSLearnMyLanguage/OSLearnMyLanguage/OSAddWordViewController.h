//
//  OSAddWordViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/6/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OSWordEntity+CoreDataClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface OSAddWordViewController : UITableViewController <UIPickerViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;

@property (assign, nonatomic) BOOL isEditingMode;
@property (assign, nonatomic) BOOL isNewWord;
@property (strong, nonatomic) OSWordEntity* word;

@property (weak, nonatomic) IBOutlet UITextField* nameTextField;
@property (weak, nonatomic) IBOutlet UITextField* translationTextField;
@property (weak, nonatomic) IBOutlet UITextView* explanationTextView;
@property (weak, nonatomic) IBOutlet UITextView* contextTextView;
@property (weak, nonatomic) IBOutlet UITextField* areaTextField;

- (IBAction)saveWord:(UIButton*)sender;
- (IBAction)actionCancel:(UIButton*)sender;


@end

NS_ASSUME_NONNULL_END
