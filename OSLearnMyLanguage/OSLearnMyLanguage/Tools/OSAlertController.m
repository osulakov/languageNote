//
//  OSAlertController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/21/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSAlertController.h"

@interface OSAlertController ()

@end

@implementation OSAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
}

+ (UIAlertController*)alertActionWithMessage:(NSString*)message {
    
    UIAlertController* alertController =
    [UIAlertController alertControllerWithTitle:message
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addAction:
     [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleCancel handler:nil]];
    
    return alertController;
    
}

@end
