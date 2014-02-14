////
////  RKCoreDataExample.m
////  RKCatalog
////
////  Created by Blake Watters on 4/21/11.
////  Copyright 2011 Two Toasters. All rights reserved.
////
//
//#import <RestKit/CoreData/CoreData.h>
//#import "DropboxSyncExample.h"
//#import <RestKit/ObjectMapping/RKObjectSerializer.h>
//#import "JSONKit.h"
//
//
//#import "AppUser.h"
//#import "BleedEvent.h"
//#import "BleedImage.h"
//#import "AppUserWrapper.h"
//
//#import "SettingsRoot.h"
//#import "ConciseKit.h"
//#import "DropboxSDK.h"
//#import "RKCatalogAppDelegate.h"
//#import "CHDropboxSync.h"
//#import "AppUserSubclass.h"
//#import "UserDetailViewController.h"
//
//#import "AppUser+LocalFileManagement.h"
//#import "RandomNameGenerator.h"
//
//@interface DropboxSyncExample()
//
//-(void)setupTestUserObject;
//-(void)convertTestUserToJSON;
//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
//-(void)insertNewDemoObject:(id)sender;
//
//-(void)setupObjectSerializationMapping;
//-(void)deleteLocalContentForAppUser:(AppUser*)appUser;
//- (NSString *)createUUID;
//@end
//
//@interface Article : NSManagedObject {
//}
//
//@property (nonatomic, retain) NSNumber* articleID;
//@property (nonatomic, retain) NSString* title;
//@property (nonatomic, retain) NSString* body;
//
//@end
//
//@implementation Article
//
//@dynamic articleID;
//@dynamic title;
//@dynamic body;
//
//@end
//
//////////////////////////////////////////////////////////////////////////////////////////////////
//#pragma mark -
//
//@implementation DropboxSyncExample
//@synthesize doSyncActionButton;
//@synthesize tableView;
//@synthesize fetchedResultsController = __fetchedResultsController;
//@synthesize dateFormatter;
//
//-(void)awakeFromNib
//{
//    RKObjectManager* manager = [RKObjectManager objectManagerWithBaseURL:@"https://api-content.dropbox.com/1"];
//    manager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:@"RKCoreDataExample.sqlite"];
//    [RKObjectManager setSharedManager:manager];
//    
//    [self setupManagedObjectMapping];
//    [self setupObjectSerializationMapping];
//    
//    //register a JSON parser to parse HTTP JSON responses with text/plain MIME type
//    Class<RKParser> parser = [[RKParserRegistry sharedRegistry] parserClassForMIMEType:@"application/json"]; 
//    [[RKParserRegistry sharedRegistry] setParserClass:parser forMIMEType:@"text/plain"]; 
//    self.dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy MMM dd HH-mm-ss"];  
//
//}
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//                
//        //enable debug logging
////        RKLogConfigureByName("RestKit", RKLogLevelWarning); 
////        RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
////        RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);
//    }
//    
//    return self;
//}
//
//-(void)viewDidLoad
//{
//    [super viewDidLoad];
//    
//    UIBarButtonItem* addNewEntityButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewDemoObject:)];
//    self.navigationItem.rightBarButtonItem =addNewEntityButton;
//    [addNewEntityButton release];
//    
//    if([[DBSession sharedSession] isLinked])
//    {
//        self.doSyncActionButton.enabled = YES;
//    }
//}
//
//- (void)dealloc {
//    [_articles release];
//    [tableView release];
//    [doSyncActionButton release];
//    [self.dateFormatter release];
//    [super dealloc];
//}
//
//
//- (NSFetchRequest*)fetchRequestForSelectedSegment {
//    NSFetchRequest* fetchRequest = [AppUser fetchRequest];
//    NSPredicate* predicate = nil;
//    
//    int fetchRequestType = 0;
//    switch (fetchRequestType) {
//        // All objects
//        case 0:
//            // An empty fetch request will return all objects
//            // Duplicates the functionality of [Article allObjects]
//            break;
//        
//        // Sorted
//        case 1:;
//            NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"firstName" ascending:NO];
//            [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
//            break;
//        
//        // By Predicate
//        case 2:
//            // Duplicates functionality of calling [Article objectsWithPredicate:predicate];
//            predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[c] %@", @"2"];
//            [fetchRequest setPredicate:predicate];
//            break;
//        
//        // By ID
//        case 3:
//            // Duplicates functionality of [Article findByAttribute:@"articleID" withValue:[NSNumber numberWithInt:3]];
//            predicate = [NSPredicate predicateWithFormat:@"%K = %d", @"articleID", 3];
//            [fetchRequest setPredicate:predicate];
//            break;
//            
//        default:            
//            break;
//    }
//    
//    
//    
//    return fetchRequest;
//}
//
//
//// Customize the number of sections in the table view.
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    int count =  [[self.fetchedResultsController sections] count];
//    return count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
//    int count = [sectionInfo numberOfObjects];
//    return count;
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell* cell = [tableView_ dequeueReusableCellWithIdentifier:@"userCell"];
//    if (nil == cell) {
//        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"userCell"] autorelease];
//    }
//    
//     [self configureCell:cell atIndexPath:indexPath];
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    {
//        // Delete the managed object for the given index path
//        NSManagedObjectContext *context = [[[RKObjectManager sharedManager] objectStore] managedObjectContext];
//        
//        //        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
//        NSAssert(self.fetchedResultsController!=nil,@"trying to delete from a nil fetched results controller");
//        NSAssert(context!=nil,@"trying to delete from a nil context");
//        
//       
//        
//        AppUser* managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
//     
//        [context deleteObject:managedObject];
//        
//        // Save the context.
//        NSError* error = nil;
//        if (![context save:&error]) {
//            /*
//             Replace this implementation with code to handle the error appropriately.
//             
//             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//             */
//            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
//        }
//       
//    }
//    
//}
//
//
//
//
//
//-(void)setupTestUserObject
//{
//    AppUserWrapper* wrapper = [AppUserWrapper object];
//    
//    appUser = [AppUser object];
//    wrapper.appUser  = appUser;
//    
//    
//    appUser.firstName = [RandomNameGenerator randomFirstName];
//    appUser.lastName = [RandomNameGenerator randomLastName];
//    appUser.userID = [self createUUID];
//    wrapper.userID = appUser.userID;
//    //generate some random events and assign one of the random images to it as a picture. Each picture is a separate file to test sync speeds, even though some pictures would look the same. 
//    for (int i = 0; i < (arc4random()%5)+1; i++){
//        BleedEvent* bleedEvent = [BleedEvent object];
//        bleedEvent.severity = [NSNumber numberWithInt:i];
//        bleedEvent.bleedReason = @"Accident";
//        //up to 5 years since epoch
//        bleedEvent.createDate = [NSDate dateWithTimeInterval:arc4random()%(365*5*86400) sinceDate:[NSDate dateWithTimeIntervalSinceReferenceDate:0]];
//        for(int j = 10;j<(11+arc4random()%4);j++)
//        {
//            //photos must have distinct dates to identify files
//            NSDate* photoDate = [NSDate dateWithTimeInterval:60*(i*j)+arc4random()%100 sinceDate:bleedEvent.createDate ];
//            
//            BleedImage*  bleedImage = [BleedImage object];
//            bleedImage.createDate = photoDate;
//            bleedImage.localFilePath = [NSString stringWithFormat:@"%@_%@_%@.jpg",
//                                        appUser.firstName,
//                                        appUser.lastName,
//                                        [self.dateFormatter stringFromDate:photoDate]];
//            //random year
//            
//            //copy the sample image over
//            NSString* demoImagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:[NSString stringWithFormat:@"hemophilia%i.jpg",arc4random()%5+1]];
//            NSError* err =nil;
//            NSString* destinationPath = [[appUser dataFolderPath] stringByAppendingPathComponent:bleedImage.localFilePath ];
//           
//           BOOL success =  [[NSFileManager defaultManager] copyItemAtPath:demoImagePath toPath:destinationPath error:&err];
//           
//            if(!success)
//            {
//                NSLog(@"failed to copy sample image to : %@",destinationPath);
//            }
//           
//            [bleedEvent addBleedEventImagesObject:bleedImage];
//        }
//        
//        [appUser addBleedEventsObject:bleedEvent];
//        
//    }
//    NSError* error = nil;
//    [[AppUser managedObjectContext] save:&error];
//    [[AppUserWrapper managedObjectContext] save:&error];
//    
//    if(error!=nil)
//    {
//        NSLog(@"ERROR: %@",[error localizedDescription]);
//    }
//    
//    NSAssert(appUser.bleedEvents.count>0,@"Failed to add bleed events");
//    BleedEvent* bleedEvent = [appUser.bleedEvents anyObject];
//    NSAssert(bleedEvent.bleedEventImages.count>0,@"Failed to add bleed event images");
//    
////    NSLog(@"app user: %@",[appUser description]);
//    
//}
//
//-(void)convertTestUserToJSON
//{
//    [appUser generateLocalJSONData]; 
//}
//
//-(void)linkSyncAction
//{
//}
//
//- (void)viewDidUnload {
//    [self setTableView:nil];
////    [self setDoSyncAction:nil];
//    [super viewDidUnload];
//}
//
//
//
//- (IBAction)doLoginLogout:(id)sender {
//    NSLog(@"Link/Sync action");
//    
//    SettingsRoot* settingsRoot = [[SettingsRoot alloc] initWithNibName:@"SettingsRoot" bundle:nil];
//    UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:settingsRoot];
//    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:settingsRoot action:@selector(dismissController:)];
//    settingsRoot.navigationItem.leftBarButtonItem = barButtonItem;
//    settingsRoot.delegate = self;
//    
//    [barButtonItem release];
//    
//    [self presentModalViewController:navController animated:YES];
//    [settingsRoot release];
//    [navController release];
//
//}
//- (IBAction)doSyncAction:(id)sender {
//    
//    RKCatalogAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
//    appDelegate.dropboxSyncer.dropboxSyncDelegate = self;
//    appDelegate.dropboxSyncer.delegate = nil;
//    [appDelegate.dropboxSyncer doSync];
//    
//}
//
//#pragma mark -
//#pragma mark CHDropboxSync delegate
//-(void)downloadedFileAtPath:(NSString *)path
//{
//    NSError* error = nil;
//    NSString* fileContents = [NSString stringWithContentsOfFile:path usedEncoding:nil error:&error];
//    
//    if(error)
//    {
//        NSLog(@"Error reading downloaded file at path: %@", path);
//    }else {
//        NSLog(@"Downloaded file with contents: %@",fileContents);
//    }
//}
//#pragma mark -
//#pragma mark NSFetchedResultsController methods
//
//- (NSFetchedResultsController *)fetchedResultsController
//{
//    if (__fetchedResultsController != nil) {
//        return __fetchedResultsController;
//    }
//    
//    // Set up the fetched results controller.
//    // Create the fetch request for the entity.
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    // Edit the entity name as appropriate.
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"AppUser" inManagedObjectContext:[AppUser managedObjectContext]];
//    [fetchRequest setEntity:entity];
//    
//    // Set the batch size to a suitable number.
//    [fetchRequest setFetchBatchSize:20];
//    
//    
//    
//    // The first sort key must match the section name key path key if present, otherwise the initial dataset would be messed up: rows in incorrect sections
//    
//    NSString* firstSortKey = @"firstName";
//    NSSortDescriptor *userTypeSortDescriptor = [[NSSortDescriptor alloc] initWithKey:firstSortKey ascending:YES];
//    NSString* lastSortKey = @"lastName";
//    NSSortDescriptor *lastNameSortDescriptor = [[NSSortDescriptor alloc] initWithKey:lastSortKey ascending:YES];
//    NSArray *sortDescriptors = [NSArray arrayWithObjects:userTypeSortDescriptor,lastNameSortDescriptor, nil];
//    
//    [fetchRequest setSortDescriptors:sortDescriptors];
//    
//    // Edit the section name key path and cache name if appropriate.
//    // nil for section name key path means "no sections".
//    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[AppUser managedObjectContext] sectionNameKeyPath:nil cacheName:@"Users"];
//    self.fetchedResultsController = aFetchedResultsController;
//    aFetchedResultsController.delegate = self;
//    
////    [aFetchedResultsController release];
//    [sortDescriptors release];
//    [fetchRequest release];
//    
//	NSError *error = nil;
//	if (![__fetchedResultsController performFetch:&error]) {
//	    /*
//	     Replace this implementation with code to handle the error appropriately.
//         
//	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
//	     */
//	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//        //	    abort();
//	}
//    
//    
//    return __fetchedResultsController;
//}    
//
//
//- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView beginUpdates];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
//{
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//    
//    
//}
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath
//{
////    UITableView *tableView = self.tableView;
////     
//    AppUser* managedObject = anObject;
//    switch(type) {
//        case NSFetchedResultsChangeInsert:
//            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationNone];
////             [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
//            //             [self configureCell:[tableView cellForRowAtIndexPath:newIndexPath] atIndexPath:newIndexPath];
//            break;
//            
//        case NSFetchedResultsChangeDelete:
//            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
//            
//            break;
//            
//        case NSFetchedResultsChangeUpdate:
//            [self configureCell:[self.tableView cellForRowAtIndexPath:newIndexPath] atIndexPath:newIndexPath];
//            
//            [managedObject updateLocalImages];
//            break;
//            
//        case NSFetchedResultsChangeMove:
//            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
//            break;
//    }
//}
//- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
//{
//    [self.tableView endUpdates];
//    
//    
//    //    self.dataManager.appDelegate.interfaceNeedsUpdating = YES;
//    
//}
//
//- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
//{
//    AppUser* user = [self.fetchedResultsController objectAtIndexPath:indexPath];
//    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",user.firstName, user.lastName];
//    
//    int imageCount = 0;
//    for(BleedEvent* bleedEvent in user.bleedEvents)
//    {
//        imageCount += bleedEvent.bleedEventImages.count;
//    }
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i bleed events, %i images",user.bleedEvents.count,imageCount];
//    
//
//}
//
//-(void)setupManagedObjectMapping
//{
//    RKObjectManager *objectManager = [RKObjectManager sharedManager ] ;
//    
//    // Setup our object mappings    
//    /*!
//     Mapping by entity. Here we are configuring a mapping by targetting a Core Data entity with a specific
//     name. This allows us to map back Twitter user objects directly onto NSManagedObject instances --
//     there is no backing model class!
//     */
//    //********************************    
//    RKManagedObjectMapping* bleedImageMapping = [RKManagedObjectMapping mappingForEntityWithName:@"BleedImage"];
//    bleedImageMapping.primaryKeyAttribute = @"imageID";
//    [bleedImageMapping mapKeyPathsToAttributes:@"createDate", @"createDate",@"localFilePath",@"localFilePath",nil];
//    [objectManager.mappingProvider addObjectMapping:bleedImageMapping];
////    [objectManager.mappingProvider setSerializationMapping:[bleedImageMapping inverseMapping] forClass:[BleedImage class]];
//    //********************************    
//    
//    RKManagedObjectMapping* bleedEventMapping = [RKManagedObjectMapping mappingForEntityWithName:@"BleedEvent"];
//    bleedEventMapping.primaryKeyAttribute = @"bleedID";
//    [bleedEventMapping mapKeyPathsToAttributes:@"createDate", @"createDate",@"severity",@"severity",@"bleedReason",@"bleedReason",nil];
//    [bleedEventMapping mapRelationship:@"bleedEventImages" withMapping:bleedImageMapping];
//    [objectManager.mappingProvider addObjectMapping:bleedEventMapping];
////    [objectManager.mappingProvider setSerializationMapping:[bleedEventMapping inverseMapping] forClass:[BleedEvent class]];
//    
//    // Setup our object mappings    
//    /*!
//     Mapping by entity. Here we are configuring a mapping by targetting a Core Data entity with a specific
//     name. This allows us to map back Twitter user objects directly onto NSManagedObject instances --
//     there is no backing model class!
//     */
//    //******************************** 
//    //setup App user mapping
//    RKManagedObjectMapping* userMapping = [RKManagedObjectMapping mappingForClass:[AppUser class]];
//    userMapping.primaryKeyAttribute = @"userID";
////    keyPath and attribute names. must be even
//    [userMapping mapKeyPathsToAttributes:@"firstName",@"firstName",@"userID",@"userID", @"lastName",@"lastName",@"localDataFilepath",@"localDataFilepath",nil];
//    [userMapping mapRelationship:@"bleedEvents" withMapping:bleedEventMapping];
//    
//    //not sure if this is necessary
////    [bleedEventMapping mapRelationship:@"user" withMapping:userMapping];
//
//    [objectManager.mappingProvider addObjectMapping:userMapping];
//   [objectManager.mappingProvider setSerializationMapping:[userMapping inverseMapping] forClass:[AppUser class]];
//    
////    // Update date format so that we can parse Twitter dates properly
////	// Wed Sep 29 15:31:08 +0000 2010
////	[statusMapping.dateFormatStrings addObject:@"E MMM d HH:mm:ss Z y"];
//    
//    //these are used for export
//    [objectManager.mappingProvider setMapping:bleedEventMapping forKeyPath:@"bleedEvents"];
//    [objectManager.mappingProvider setMapping:bleedImageMapping forKeyPath:@"bleedEventImages"];
//    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@"appUser"];
//    
//    //******************************** 
//    //setup App user wrapper mapping - this puts appUser as a top level object within a JSON, causing the JSONParser to try to extract that object. 
//    RKManagedObjectMapping* userWrapperMapping = [RKManagedObjectMapping mappingForClass:[AppUserWrapper class]];
//    userWrapperMapping.primaryKeyAttribute = @"userID";
//    //    keyPath and attribute names. must be even
//    [userWrapperMapping mapKeyPathsToAttributes:@"userID",@"userID",nil];
//    [userWrapperMapping mapRelationship:@"appUser" withMapping:userMapping];
//    
//    [objectManager.mappingProvider addObjectMapping:userWrapperMapping];
//    [objectManager.mappingProvider setSerializationMapping:[userWrapperMapping inverseMapping] forClass:[AppUserWrapper class]];
//    
//    
//}
//
//-(void)setupObjectSerializationMapping{}
////{
////    RKObjectManager *objectManager = [RKObjectManager sharedManager ] ;
////    RKObjectMapping *mapping = [RKObjectMapping mappingForClass:[Article class]];
////    
////    [mapping mapAttributes:@"articleID", @"title", @"body", nil];
////    
////    //********************************    
////    
////    RKObjectMapping *imageMapping = [RKObjectMapping mappingForClass:[BleedImage class]];
////    
////    [imageMapping mapAttributes:@"createDate", @"localFilePath", nil];
////    [objectManager.mappingProvider addObjectMapping:imageMapping];
////    [objectManager.mappingProvider setSerializationMapping:[imageMapping inverseMapping] forClass:[BleedImage class]];
////    [objectManager.mappingProvider setMapping:imageMapping forKeyPath:@"bleedEventImages"];
////    
////    //********************************    
////    
////    RKObjectMapping *eventMapping = [RKObjectMapping mappingForClass:[BleedEvent class]];
////    
////    [eventMapping mapAttributes:@"createDate", @"severity",@"bleedReason", nil];
////    [eventMapping mapRelationship:@"bleedEventImages" withMapping:imageMapping];
////    
////    [objectManager.mappingProvider addObjectMapping:eventMapping];
////    [objectManager.mappingProvider setSerializationMapping:[eventMapping inverseMapping] forClass:[BleedEvent class]];
////    [objectManager.mappingProvider setMapping:eventMapping forKeyPath:@"bleedEvents"];
////    
////    //******************************** 
////    //setup App user mapping
////    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[AppUserSubclass class]];
////    
////    [userMapping mapAttributes:@"userID",@"firstName", @"lastName",@"localDataFilepath", nil];
////    [userMapping mapRelationship:@"bleedEvents" withMapping:eventMapping];
////    [objectManager.mappingProvider addObjectMapping:userMapping];
////    [objectManager.mappingProvider setSerializationMapping:[userMapping inverseMapping] forClass:[AppUserSubclass class]];
////    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@"appUser"];
////    
////    //******************************** 
////    //setup App user wrapper mapping
////    RKObjectMapping *userWrapperMapping = [RKObjectMapping mappingForClass:[AppUserWrapper class]];
////    
////   
////    [userWrapperMapping mapRelationship:@"appUser" withMapping:userMapping];
////    [objectManager.mappingProvider addObjectMapping:userWrapperMapping];
////    [objectManager.mappingProvider setSerializationMapping:[userWrapperMapping inverseMapping] forClass:[AppUserWrapper class]];
////    [objectManager.mappingProvider setMapping:userWrapperMapping forKeyPath:@"appUserWrapper"];
////    
////
////}
//
//-(void)syncComplete:(id)sender{
////    self.fetchedResultsController = nil;
////    [self.tableView reloadData];
//    
//    NSLog(@"retrieved objects: %i",self.fetchedResultsController.fetchedObjects.count);
//}
//
//#pragma mark-
//#pragma mark Object Insertion
//-(void)insertNewDemoObject:(id)sender
//{
//    
//    
//        [self setupTestUserObject];
//        [self convertTestUserToJSON];
//    
//}
//
//-(void)deleteLocalContentForAppUser:(AppUser*)appUser_
//{
//    [appUser_ deleteLocalImages];
//    [appUser_ deleteLocalContent];    
// 
//}
//
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if([segue.identifier isEqualToString:@"userDetails"])
//    {
//        NSIndexPath* selectedIndexPath =  self.tableView.indexPathForSelectedRow ;
//        
//       AppUser* selectedUser = [self.fetchedResultsController objectAtIndexPath:selectedIndexPath];
//        
//        
//        for(BleedEvent* bleedEvent in selectedUser.bleedEvents)
//        {
//            NSAssert([bleedEvent.user isEqual:selectedUser],@"bleed event user is not set!");
//        }
//        
//        NSLog(@"Bleed events: %i",selectedUser.bleedEvents.count);
//        [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
//        [segue.destinationViewController setAppUser:selectedUser];
//        
//    }
//}
//
//- (NSString *)createUUID
//{
//    // Create universally unique identifier (object)
//    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
//    
//    // Get the string representation of CFUUID object.
//    NSString *uuidStr = [(NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject) autorelease];
//    
//    // If needed, here is how to get a representation in bytes, returned as a structure
//    // typedef struct {
//    //   UInt8 byte0;
//    //   UInt8 byte1;
//    //   ...
//    //   UInt8 byte15;
//    // } CFUUIDBytes;
////    CFUUIDBytes bytes = CFUUIDGetUUIDBytes(uuidObject);
//    
//    CFRelease(uuidObject);
//    
//    return uuidStr;
//}
//
//@end
