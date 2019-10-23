//
//  OSSettingsTableViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 10/23/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSSettingsTableViewController.h"
#import "OSAuthViewController.h"
#import "OSColorsAndAttributes.h"

@interface OSSettingsTableViewController ()

@end

@implementation OSSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    if ([FIRAuth auth].currentUser) {
        [self.createNewAccountButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.userEmailLabel.text = [[FIRAuth auth].currentUser email];
    } else {
        [self.logoutButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    
}

#pragma mark - Actions

- (IBAction)createNewAccountAction:(UIButton*)sender {
    if (![FIRAuth auth].currentUser) {
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OSAuthViewController* authVC =
        [storyboard instantiateViewControllerWithIdentifier:@"OSAuthViewController"];
        [self presentViewController:authVC animated:YES completion:nil];
    }
}

- (IBAction)logoutAction:(UIButton*)sender {
    if ([FIRAuth auth].currentUser) {
        // LOG OUT
            NSError *signOutError;
            BOOL status = [[FIRAuth auth] signOut:&signOutError];
            if (!status) {
              NSLog(@"Error signing out: %@", signOutError);
              return;
            }
        
        [self.logoutButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.createNewAccountButton setTitleColor:[OSColorsAndAttributes getDarkGreenColor]
                                          forState:UIControlStateNormal];
        
        self.userEmailLabel.text = @"";
    }
}


@end
