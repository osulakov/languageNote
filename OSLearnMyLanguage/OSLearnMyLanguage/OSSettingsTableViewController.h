//
//  OSSettingsTableViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 10/23/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Firebase.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSSettingsTableViewController : UITableViewController

@property (strong, nonatomic) IBOutlet UIButton* createNewAccountButton;
@property (strong, nonatomic) IBOutlet UIButton* logoutButton;
@property (strong, nonatomic) IBOutlet UILabel* userEmailLabel;

- (IBAction)createNewAccountAction:(UIButton*)sender;
- (IBAction)logoutAction:(UIButton*)sender;

@end

NS_ASSUME_NONNULL_END
