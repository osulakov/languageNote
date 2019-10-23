//
//  OSAuthViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 10/22/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSAuthViewController.h"

@interface OSAuthViewController ()

@end

@implementation OSAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.createNewAccountMode = NO;
}

- (IBAction)cancelAuthAction:(UIButton*)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)createNewAccountAction:(UIButton*)sender {
    self.createNewAccountMode = YES;
}

- (IBAction)okAction:(UIButton*)sender {
    
    if (self.createNewAccountMode) {
        NSLog(@"New user is created");
    } else {
        NSLog(@"User logged in");
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
