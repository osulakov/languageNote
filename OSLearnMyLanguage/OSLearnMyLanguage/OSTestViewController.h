//
//  OSTestViewController.h
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/31/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OSTestViewController : UIViewController

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@property (strong, nonatomic) AVAudioPlayer* player;

@end

NS_ASSUME_NONNULL_END
