//
//  ViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/6/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSWordViewController.h"
#import "OSWordEntity+CoreDataClass.h"
#import "OSWordDetailsController.h"
#import "OSColorsAndAttributes.h"
#import "OSAddWordViewController.h"
#import "OSWordDetailsView.h"
#import "OSAuthViewController.h"

@interface OSWordViewController () <UITableViewDataSource, UITableViewDelegate>;

@property(strong, nonatomic) FIRAuthStateDidChangeListenerHandle handle;

@end

@implementation OSWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [OSColorsAndAttributes getViewBackgroundColor];
    
    NSDate *today = [NSDate date];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    dayComponent.day = -1;
    NSDate *yesterday = [theCalendar dateByAddingComponents:dayComponent toDate:today options:0];
    [self wordList:yesterday];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        OSAuthViewController* authVC =
        [storyboard instantiateViewControllerWithIdentifier:@"OSAuthViewController"];
        [self presentViewController:authVC animated:YES completion:nil];
    }
    
    if ([FIRAuth auth].currentUser) {
        NSLog(@"%@ is signed in", [[FIRAuth auth].currentUser email]);
    } else {
        NSLog(@"no User");
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    self.handle = [[FIRAuth auth]
    addAuthStateDidChangeListener:^(FIRAuth *_Nonnull auth, FIRUser *_Nullable user) {
      // ...
    }];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    [[FIRAuth auth] removeAuthStateDidChangeListener:_handle];
}

#pragma mark - Actions

- (IBAction)actionChangeSortingByDate:(UISegmentedControl*)sender {
    
    NSDate *today = [NSDate date];
    NSDateComponents *dayComponent = [[NSDateComponents alloc] init];
    NSCalendar *theCalendar = [NSCalendar currentCalendar];
    
    if (sender.selectedSegmentIndex == OSChangeSortingByDateDay) {
        dayComponent.day = -1;
        NSDate *yesterday = [theCalendar dateByAddingComponents:dayComponent toDate:today options:0];
        
        [self wordList:yesterday];
        
    } else if (sender.selectedSegmentIndex == OSChangeSortingByDateWeek) {
        dayComponent.day = -7;
        NSDate *weekAgo = [theCalendar dateByAddingComponents:dayComponent toDate:today options:0];
        
        [self wordList:weekAgo];
        
    } else if (sender.selectedSegmentIndex == OSChangeSortingByDateMonth) {
        dayComponent.month = -1;
        NSDate *monthAgo = [theCalendar dateByAddingComponents:dayComponent toDate:today options:0];
        
        [self wordList:monthAgo];
        
    } else {
        dayComponent.year = -10;
        NSDate *allTime = [theCalendar dateByAddingComponents:dayComponent toDate:today options:0];
        
        [self wordList:allTime];
        
    }
    
}

#pragma mark - Privat methods

- (void)wordList:(NSDate*)date {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"OSWordEntity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* wordNameDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"wordName" ascending:YES];
    [fetchRequest setSortDescriptors:@[wordNameDescriptor]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"wordCreatingDate > %@", date];
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController* aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:@"wordNameInitial"
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    [aFetchedResultsController performFetch:nil];
    self.fetchedResultsController = aFetchedResultsController;
    
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray* array = [NSMutableArray array];
    
    for (id <NSFetchedResultsSectionInfo> sectionInfo in [self.fetchedResultsController sections]) {
        [array addObject:[sectionInfo name]];
    }
    
    return array;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSManagedObjectContext* context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError* error = nil;
        if (![context save:&error]) {
            NSLog(@"Unresolved error %@ %@", error, [error userInfo]);
            abort();
        }
        
        [self.tableView reloadData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

- (void)configureCell:(UITableViewCell*)cell atIndexPath:(NSIndexPath*)indexPath {

    OSWordEntity* word = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString* string = [NSString stringWithFormat:@"%@", word.wordName];
    cell.textLabel.attributedText = [OSColorsAndAttributes getAttributedTitleStringFromString:string];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", word.wordTranslation];
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    OSWordEntity* word = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    double viewWidth = (self.view.bounds.size.width / 6) * 5;
    double viewHeight = self.view.bounds.size.height / 2;
    CGRect rect = CGRectMake(CGRectGetMidX(self.view.bounds) - (viewWidth / 2),
                             CGRectGetMidY(self.view.bounds) - (viewHeight / 2),
                             viewWidth, viewHeight);
    
     OSWordDetailsView* detailsView =
    [[OSWordDetailsView alloc] initWithFrame:rect andWord:word];
    detailsView.alpha = 0;
    
    detailsView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                    UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
                                    UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:detailsView];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1.0f];
    detailsView.alpha = 1.0;
    [UIView commitAnimations];
    
}

@end

