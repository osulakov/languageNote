//
//  OSAreaViewController.m
//  OSLearnMyLanguage
//
//  Created by Oleksandr Sulakov on 8/28/19.
//  Copyright © 2019 Oleksandr Sulakov. All rights reserved.
//

#import "OSCategoryViewController.h"
#import "OSWordEntity+CoreDataClass.h"
#import "OSWordViewController.h"
#import "OSWordArea+CoreDataClass.h"
#import "OSCategoryDetailsViewController.h"
#import "OSColorsAndAttributes.h"

@interface OSCategoryViewController ()

@end

@implementation OSCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [OSColorsAndAttributes getViewBackgroundColor];
    
    //self.title = @"Areas";
    
    [self wordList];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

#pragma mark - Privat methods

- (void)wordList {
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"OSWordArea" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:description];
    
    NSSortDescriptor* wordNameDescriptor =
    [[NSSortDescriptor alloc] initWithKey:@"areaName" ascending:YES];
    [fetchRequest setSortDescriptors:@[wordNameDescriptor]];
    
    NSFetchedResultsController* aFetchedResultsController =
    [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                        managedObjectContext:self.managedObjectContext
                                          sectionNameKeyPath:nil
                                                   cacheName:nil];
    aFetchedResultsController.delegate = self;
    [aFetchedResultsController performFetch:nil];
    self.fetchedResultsController = aFetchedResultsController;
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

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
    
    OSWordArea* wordArea = [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString* string = [NSString stringWithFormat:@"%@", wordArea.areaName];
    cell.textLabel.attributedText = [OSColorsAndAttributes getAttributedTitleStringFromString:string];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.backgroundColor = [OSColorsAndAttributes getCellColor];
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OSWordArea* area = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    OSCategoryDetailsViewController *controller =
    [storyboard instantiateViewControllerWithIdentifier:@"OSAreaDetailsViewController"];
    
    controller.areaName = area.areaName;
    
    [self.navigationController pushViewController:controller animated:YES];
    
}

@end
