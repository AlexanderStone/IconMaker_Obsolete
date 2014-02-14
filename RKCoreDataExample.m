//
//  RKCoreDataExample.m
//  RKCatalog
//
//  Created by Blake Watters on 4/21/11.
//  Copyright 2011 Two Toasters. All rights reserved.
//


#import <RestKit/CoreData/CoreData.h>
#import "RKCoreDataExample.h"

#import "IconFile.h"

@interface Article : NSManagedObject {
}

@property (nonatomic, retain) NSNumber* articleID;
@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* body;

@end

@implementation Article

@dynamic articleID;
@dynamic title;
@dynamic body;

@end

////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -

@implementation RKCoreDataExample

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        RKObjectManager* manager = [RKObjectManager objectManagerWithBaseURL:@"http://restkit.org"];
//        manager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"TrackerFactoryCoreData.sqlite"];
////         manager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"RKCoreDataExample.sqlite"];
//        [RKObjectManager setSharedManager:manager];
        
        
//        NSAssert([RKObjectManager sharedManager]!=nil,@"shared object manager is nil!");
//        NSAssert([RKObjectManager sharedManager].objectStore!=nil,@"shared object manager objectStore is nil!");
//        NSAssert([RKObjectManager sharedManager].objectStore.managedObjectModel!=nil,@"managedObjectModel is nil!");
        
        NSLog(@"class: %@ ",[Article class]);
        
        NSLog(@"class description %@",[[Article class] description]);
        
        
        NSLog(@"Number of users: %i ",[IconFile count:nil]);
                
        
        
        // Create some starter objects if the database is empty
        if ([IconFile count:nil] == 0) {
            for (int i = 1; i <= 5; i++) {
                IconFile* article = [IconFile object];
                article.createDate = [NSDate date];
                article.springBoardName = [NSString stringWithFormat:@"icon: %i",i];
//                article.articleID = [NSNumber numberWithInt:i];
//                article.title = [NSString stringWithFormat:@"Article %d", i];
//                article.body = @"This is the body";
                
                // Persist the object store
                [[RKObjectManager sharedManager].objectStore save];
            }
        }
        
        NSArray* items = [NSArray arrayWithObjects:@"All", @"Sorted", @"By Predicate", @"By ID", nil];
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
        _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        _segmentedControl.momentary = NO;
        [_segmentedControl addTarget:self action:@selector(updateTableView) forControlEvents:UIControlEventValueChanged];
        _segmentedControl.selectedSegmentIndex = 0;
    }
    
    return self;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {    
    return _segmentedControl;
}

- (NSFetchRequest*)fetchRequestForSelectedSegment {
    NSFetchRequest* fetchRequest = [IconFile fetchRequest];
    NSPredicate* predicate = nil;
    
    switch (_segmentedControl.selectedSegmentIndex) {
        // All objects
        case 0:
            // An empty fetch request will return all objects
            // Duplicates the functionality of [Article allObjects]
            break;
        
        // Sorted
        case 1:
        {
            NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
            [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
            break;
        }
        // By Predicate
        case 2:
        {
            // Duplicates functionality of calling [Article objectsWithPredicate:predicate];
            predicate = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", @"1"];
            [fetchRequest setPredicate:predicate];
            break;
        }
        // By ID
        case 3:
        {   // Duplicates functionality of [Article findByAttribute:@"articleID" withValue:[NSNumber numberWithInt:3]];
            predicate = [NSPredicate predicateWithFormat:@"%K = %d", @"articleID", 3];
            [fetchRequest setPredicate:predicate];
            break;
        }   
        default:            
            break;
    }
    
    return fetchRequest;
}

- (void)updateTableView {
      NSFetchRequest* fetchRequest = [self fetchRequestForSelectedSegment];
    _articles = [IconFile objectsWithFetchRequest:fetchRequest] ;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_articles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ArticleCell"];
    }
    
    IconFile* article = [_articles objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"article name: %@", article.springBoardName];
//    cell.detailTextLabel.text = article.body;
    
    return cell;
}

@end
