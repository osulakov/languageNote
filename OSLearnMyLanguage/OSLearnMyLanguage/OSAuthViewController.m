//
//  OSAuthViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 10/22/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSAuthViewController.h"
#import "OSAlertController.h"

@interface OSAuthViewController ()

@end

@implementation OSAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createNewAccountMode = NO;
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (IBAction)cancelAuthAction:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createNewAccountAction:(UIButton*)sender {
    self.createNewAccountMode = YES;
    
    self.signInLabel.text = @"Create New Account";
    [self.orWordLabel removeFromSuperview];
    [self.createNewAccountButton removeFromSuperview];
}

- (IBAction)okAction:(UIButton*)sender {
    
    if (self.emailTextField.text && self.passwordTextField.text) {
        
        if (self.createNewAccountMode) {
            
            [[FIRAuth auth] createUserWithEmail:self.emailTextField.text
                                       password:self.passwordTextField.text
                                     completion:^(FIRAuthDataResult * _Nullable authResult,
                                                  NSError * _Nullable error) {
                NSLog(@"%@ created", authResult.user.email);
                
                [[FIRAuth auth].currentUser sendEmailVerificationWithCompletion:^(NSError *_Nullable error) {
                  // ...
                }];
            }];
            
        } else {
            
            [[FIRAuth auth] signInWithEmail:self.emailTextField.text
                                   password:self.passwordTextField.text
                                 completion:^(FIRAuthDataResult * _Nullable authResult,
                                              NSError * _Nullable error) {
                NSLog(@"%@ logged in", authResult.user.email);
            }];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } else {
        [OSAlertController alertActionWithMessage:@"Enter your email and password"];
    }
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
