//
//  OSWordDetails.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/21/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSWordDetailsController.h"
#import "OSWordEntity+CoreDataClass.h"
#import "OSWordArea+CoreDataClass.h"
#import "OSAlertController.h"
#import "OSDataManager.h"
#import "OSColorsAndAttributes.h"

@implementation OSWordDetailsController 

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.nameTextField.font = [OSColorsAndAttributes getTextFont];
    self.nameTextField.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    self.nameTextField.text         = self.word.wordName;
    
    self.translationTextField.font = [OSColorsAndAttributes getTextFont];
    self.translationTextField.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    self.translationTextField.text  = self.word.wordTranslation;
    
    self.areaTextField.font = [OSColorsAndAttributes getTextFont];
    self.areaTextField.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    self.areaTextField.text         = self.word.area.areaName;
    
    self.explanationTextView.font = [OSColorsAndAttributes getTextFont];
    self.explanationTextView.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    self.explanationTextView.text   = self.word.wordExplanation;
    
    NSString* string = self.nameTextField.text;
    NSString* text = self.word.wordContext;
    
    self.contextTextView.attributedText = [OSColorsAndAttributes highlightWord:string inText:text];
    
    self.contextTextView.delegate = self;
    
    self.areaTextField.inputView = [self createPicker];
    
    if (self.isEditingMode) {
        UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                       target:self
                                       action:@selector(actionEditWord:)];
        editButton.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = editButton;
    } else {
        UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                       target:self
                                       action:@selector(actionEditWord:)];
        editButton.tintColor = [UIColor whiteColor];
        self.navigationItem.rightBarButtonItem = editButton;
    }
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
}

- (NSManagedObjectContext*)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[OSDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

#pragma mark - Actions

- (void)actionEditWord:(UIBarButtonItem*)sender {
    
    BOOL swith = self.isEditingMode;
    self.isEditingMode = !swith;
    
    UIBarButtonSystemItem item = UIBarButtonSystemItemEdit;
    
    if (self.isEditingMode) {
        item = UIBarButtonSystemItemDone;
    } else {
        
        if (!self.isNewWord) {
            
            [self.word setValue:self.nameTextField.text forKey:@"wordName"];
            [self.word setValue:self.translationTextField.text forKey:@"wordTranslation"];
            [self.word setValue:self.explanationTextView.text forKey:@"wordExplanation"];
            [self.word setValue:self.contextTextView.text forKey:@"wordContext"];
            
            [self.managedObjectContext save:nil];
            
            [self presentViewController:
             [OSAlertController alertActionWithMessage:@"Word data has been changed"]
                               animated:YES
                             completion:nil];
            
        } else {
            
            [self saveWord];
            
        }
        
    }
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:item
                                   target:self action:@selector(actionEditWord:)];
    [self.navigationItem setRightBarButtonItem:editButton animated:YES];
    
}

- (void)saveWord {
    
    if (self.nameTextField.text.length == 0) {
        
        [self presentViewController:
         [OSAlertController alertActionWithMessage:@"Fill out text field Name first!"]
                           animated:YES
                         completion:nil];
        
    } else {
        
        [[OSDataManager sharedManager] createWordWithName:self.nameTextField.text
                                              translation:self.translationTextField.text
                                                     area:self.areaTextField.text
                                              explanation:self.explanationTextView.text
                                                  context:self.contextTextView.text];
        
        
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

#pragma mark - Privat methods

- (UIView *)createPicker {
    
    UIView *pickerView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 200)];
    pickerView.backgroundColor = [UIColor whiteColor];
    
    UIPickerView *picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 10, pickerView.frame.size.width, 150)];
    picker.delegate = self;
    [pickerView addSubview:picker];
    
    return pickerView;
}

- (NSArray*)getAreaList {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"OSWordArea"
                inManagedObjectContext:self.managedObjectContext];
    [request setEntity:description];
    
    NSError* error = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    return resultArray;
    
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [[self getAreaList] count] + 1;
    
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (row == 0) {
        return @"---";
    } else {
        
        NSArray* array = [self getAreaList];
        OSWordArea* wordArea = [array objectAtIndex:row - 1];
        
        NSString* title = wordArea.areaName;
        
        return title;
        
    }
    
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (row > 0) {
        
        NSArray* array = [self getAreaList];
        OSWordArea* wordArea = [array objectAtIndex:row - 1];
        
        self.areaTextField.text = wordArea.areaName;
    }
    
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (self.isEditingMode) {
        return YES;
    }
    
    return NO;
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.tag == 1) {
        
        NSString* string = self.nameTextField.text;
        NSString* text = textView.text;
        
        self.contextTextView.attributedText = [OSColorsAndAttributes highlightWord:string inText:text];
    }
    
}


@end
