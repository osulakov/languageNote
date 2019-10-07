//
//  OSAreaDetailsViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/29/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSCategoryDetailsViewController.h"
#import "OSWordEntity+CoreDataClass.h"
#import "OSWordDetailsController.h"
#import "OSColorsAndAttributes.h"

@interface OSCategoryDetailsViewController ()

@end

@implementation OSCategoryDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [OSColorsAndAttributes getViewBackgroundColor];
    
    [self wordList:self.areaName];
    
}

#pragma mark - Privat methods

- (void)wordList:(NSString*)areaName {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"OSWordEntity" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* wordNameDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"wordName" ascending:YES];
    [fetchRequest setSortDescriptors:@[wordNameDescriptor]];
    
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"area.areaName == %@", areaName];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [OSColorsAndAttributes getCellColor];
    
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OSWordEntity* word = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OSWordDetailsController *controller =
    [storyboard instantiateViewControllerWithIdentifier:@"OSWordDetailsController"];
    
    controller.word = word;
    
    [self.navigationController pushViewController:controller animated:YES];
}




@end
