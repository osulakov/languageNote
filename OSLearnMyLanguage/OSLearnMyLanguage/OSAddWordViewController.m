//
//  OSAddWordViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/6/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSAddWordViewController.h"
#import "OSDataManager.h"
#import "OSWordViewController.h"
#import "OSAlertController.h"
#import "OSWordArea+CoreDataClass.h"
#import "OSColorsAndAttributes.h"

@interface OSAddWordViewController ()

@end

@implementation OSAddWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    
    self.navigationController.navigationBar.topItem.title = @"Add New Word";
    self.nameTextField.font = [OSColorsAndAttributes getTextFont];
    self.translationTextField.font = [OSColorsAndAttributes getTextFont];
    self.areaTextField.font = [OSColorsAndAttributes getTextFont];
    self.areaTextField.textColor = [OSColorsAndAttributes getExtraDarkGreenColor];
    self.explanationTextView.font = [OSColorsAndAttributes getTextFont];
    self.contextTextView.font = [OSColorsAndAttributes getTextFont];
    
    self.areaTextField.inputView = [self createPicker];
    self.contextTextView.delegate = self;
    
}

- (NSManagedObjectContext*)managedObjectContext {
    if (!_managedObjectContext) {
        _managedObjectContext = [[OSDataManager sharedManager] managedObjectContext];
    }
    return _managedObjectContext;
}

#pragma mark - Actions

- (IBAction)saveWord:(UIButton*)sender {
    
    if (self.nameTextField.text.length == 0) {
        
        [self presentViewController:
         [OSAlertController alertActionWithMessage:@"Fill out textfield WORD first!"]
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

- (IBAction)actionCancel:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    return YES;
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if (textView.tag == 1) {
        
        NSString* string = self.nameTextField.text;
        NSString* text = textView.text;
        
        self.contextTextView.attributedText = [OSColorsAndAttributes highlightWord:string inText:text];
    }
    
}

@end
