//
//  OSAuthViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 10/22/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSAuthViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel* signIn;
@property (strong, nonatomic) IBOutlet UILabel* orWord;
@property (strong, nonatomic) IBOutlet UIButton* createNewAccountButton;
@property (assign, nonatomic) BOOL createNewAccountMode;

- (IBAction)cancelAuthAction:(UIButton*)sender;
- (IBAction)createNewAccountAction:(UIButton*)sender;
- (IBAction)okAction:(UIButton*)sender;

@end

NS_ASSUME_NONNULL_END
