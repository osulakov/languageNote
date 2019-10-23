//
//  OSAuthViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 10/22/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSAuthViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel* signInLabel;
@property (strong, nonatomic) IBOutlet UILabel* orWordLabel;
@property (strong, nonatomic) IBOutlet UIButton* createNewAccountButton;
@property (assign, nonatomic) BOOL createNewAccountMode;
@property (strong, nonatomic) IBOutlet UITextField* emailTextField;
@property (strong, nonatomic) IBOutlet UITextField* passwordTextField;

- (IBAction)cancelAuthAction:(UIButton*)sender;
- (IBAction)createNewAccountAction:(UIButton*)sender;
- (IBAction)okAction:(UIButton*)sender;

@end

NS_ASSUME_NONNULL_END
