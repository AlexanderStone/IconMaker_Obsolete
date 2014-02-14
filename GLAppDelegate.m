//
//  GLAppDelegate.m
//  glamourAR
//
//  Created by Mahmood1 on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GLAppDelegate.h"
#import "Appirater.h"
#import "LengthWidgetViewController.h"

#import "DBSession.h"
#import "DropboxConfigAPI.h"
#import "CHDropboxSync.h"
#import "SyncController.h"
#import "FullScreenProgressViewController.h"

NSString* gRKCatalogBaseURL = nil;


@interface GLAppDelegate ()

-(void)initializeRestKit;
    
@end

@implementation GLAppDelegate

@synthesize window = _window;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;

@synthesize userIdentifierView;
@synthesize rkCoreDataManager;
@synthesize salesCopyLengthIndicator;
@synthesize syncer = __syncer;
@synthesize syncController;
@synthesize fullScreenProgressViewController = __fullScreenProgressViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
   
    
    gRKCatalogBaseURL = @"http://rkcatalog.heroku.com";
    [self initializeRestKit];
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor lightGrayColor]];
    [[UIToolbar appearance] setBarTintColor:[UIColor lightGrayColor ]];
    

    // Override point for customization after application launch.
     
    DBSession* dbSession = [[DBSession alloc] initWithAppKey:kDropboxAppKey appSecret:kDropboxAppSecret root:kDBRootAppFolder];
    [DBSession setSharedSession:dbSession];
    
    [Appirater appLaunched:YES];

    return YES;
}
		
-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"App linked successfully!");
            [CHDropboxSync forgetStatus];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"Linked" object:nil];
            // At this point you can start making API calls
        }
        return YES;
    }
    // Add whatever other url handling code your app requires here
    return NO;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    [Appirater appEnteredForeground:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    
   
    [rkCoreDataManager.objectStore save];
    NSError *error = nil;
    [rkCoreDataManager.objectStore.managedObjectContext save:&error];
    
    if(error!=nil)
    {
        NSLog(@"error saving context: %@", [error localizedDescription]);
    }
}

- (void)saveContext
{
    //    NSError *error = nil;
    //    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    //    if (managedObjectContext != nil) {
    //        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
    //             // Replace this implementation with code to handle the error appropriately.
    //             // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
    //            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    //            abort();
    //        } 
    //    }
    
    [rkCoreDataManager.objectStore save];
}

- (NSManagedObjectContext *)managedObjectContext
{
    //    if (__managedObjectContext != nil) {
    //        return __managedObjectContext;
    //    }
    //    
    //    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    //    if (coordinator != nil) {
    //        __managedObjectContext = [[NSManagedObjectContext alloc] init];
    //        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    //    }
    //    return __managedObjectContext;
    
    return [rkCoreDataManager.objectStore managedObjectContext];
}

- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil) {
        return __managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return __managedObjectModel;
}

- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(void)initializeRestKit
{
    // Initialize RestKit
    
    rkCoreDataManager = [RKObjectManager objectManagerWithBaseURL:@"http://twitter.com"];
    [RKObjectManager setSharedManager:rkCoreDataManager];
    NSAssert([RKObjectManager sharedManager]!=nil,@"shared object manager is nil!");
    
    
    // Enable automatic network activity indicator management
    [RKRequestQueue sharedQueue].showsNetworkActivityIndicatorWhenBusy = YES;
    
    // Initialize object store
    //#ifdef RESTKIT_GENERATE_SEED_DB
    //    NSString *seedDatabaseName = nil;
    //    NSString *databaseName = RKDefaultSeedDatabaseFileName;
    //#else
    //    NSString *seedDatabaseName = RKDefaultSeedDatabaseFileName;
    //    NSString *databaseName = @"TrackerFactoryCoreData.sqlite";
    //#endif
    
    NSString *databaseName = @"IconMaker.sqlite";
    
    //    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:databaseName usingSeedDatabaseName:seedDatabaseName managedObjectModel:nil delegate:self];
    rkCoreDataManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:databaseName usingSeedDatabaseName:nil managedObjectModel:nil delegate:self];
    //    objectManager.objectStore = [RKManagedObjectStore objectStoreWithStoreFilename:databaseName usingSeedDatabaseName:nil managedObjectModel:[self managedObjectModel] delegate:self];
    
    
    //    // Setup our object mappings    
    //    /*!
    //     Mapping by entity. Here we are configuring a mapping by targetting a Core Data entity with a specific
    //     name. This allows us to map back Twitter user objects directly onto NSManagedObject instances --
    //     there is no backing model class!
    //     */
    //    RKManagedObjectMapping* userMapping = [RKManagedObjectMapping mappingForEntityWithName:@"RKTUser"];
    //    userMapping.primaryKeyAttribute = @"userID";
    //    [userMapping mapKeyPath:@"id" toAttribute:@"userID"];
    //    [userMapping mapKeyPath:@"screen_name" toAttribute:@"screenName"];
    //    [userMapping mapAttributes:@"name", nil];
    //    
    //    /*!
    //     Map to a target object class -- just as you would for a non-persistent class. The entity is resolved
    //     for you using the Active Record pattern where the class name corresponds to the entity name within Core Data.
    //     Twitter status objects will be mapped onto RKTStatus instances.
    //     */
    //    RKManagedObjectMapping* statusMapping = [RKManagedObjectMapping mappingForClass:[RKTStatus class]];
    //    statusMapping.primaryKeyAttribute = @"statusID";
    //    [statusMapping mapKeyPathsToAttributes:@"id", @"statusID",
    //     @"created_at", @"createdAt",
    //     @"text", @"text",
    //     @"url", @"urlString",
    //     @"in_reply_to_screen_name", @"inReplyToScreenName",
    //     @"favorited", @"isFavorited", 
    //     nil];
    //    [statusMapping mapRelationship:@"user" withMapping:userMapping];
    //    
    //    // Update date format so that we can parse Twitter dates properly
    //	// Wed Sep 29 15:31:08 +0000 2010
    //	[statusMapping.dateFormatStrings addObject:@"E MMM d HH:mm:ss Z y"];
    //    
    //    // Register our mappings with the provider
    //    [objectManager.mappingProvider setMapping:userMapping forKeyPath:@"user"];
    //    [objectManager.mappingProvider setMapping:statusMapping forKeyPath:@"status"];
    
    // Uncomment this to use XML, comment it to use JSON
    //  objectManager.acceptMIMEType = RKMIMETypeXML;
    //  [objectManager.mappingProvider setMapping:statusMapping forKeyPath:@"statuses.status"];
    
    // Database seeding is configured as a copied target of the main application. There are only two differences
    // between the main application target and the 'Generate Seed Database' target:
    //  1) RESTKIT_GENERATE_SEED_DB is defined in the 'Preprocessor Macros' section of the build setting for the target
    //      This is what triggers the conditional compilation to cause the seed database to be built
    //  2) Source JSON files are added to the 'Generate Seed Database' target to be copied into the bundle. This is required
    //      so that the object seeder can find the files when run in the simulator.
    //#ifdef RESTKIT_GENERATE_SEED_DB
    //    RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelInfo);
    //    RKLogConfigureByName("RestKit/CoreData", RKLogLevelTrace);
    //    RKManagedObjectSeeder* seeder = [RKManagedObjectSeeder objectSeederWithObjectManager:objectManager];
    //    
    //    // Seed the database with instances of RKTStatus from a snapshot of the RestKit Twitter timeline
    //    [seeder seedObjectsFromFile:@"restkit.json" withObjectMapping:statusMapping];
    //    
    //    // Seed the database with RKTUser objects. The class will be inferred via element registration
    //    [seeder seedObjectsFromFiles:@"users.json", nil];
    //    
    //    // Finalize the seeding operation and output a helpful informational message
    //    [seeder finalizeSeedingAndExit];
    //    
    //    // NOTE: If all of your mapped objects use keyPath -> objectMapping registration, you can perform seeding in one line of code:
    //    // [RKManagedObjectSeeder generateSeedDatabaseWithObjectManager:objectManager fromFiles:@"users.json", nil];
    //#endif
    
    // Create Window and View Controllers
    //	RKTwitterViewController* viewController = [[[RKTwitterViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    //	UINavigationController* controller = [[UINavigationController alloc] initWithRootViewController:viewController];
    //	UIWindow* window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    //    [window addSubview:controller.view];
    //    [window makeKeyAndVisible];
    //    
    //    return YES;
}

-(void)showFullScreenProgress
{
    if(__fullScreenProgressViewController==nil)
    {
        self.fullScreenProgressViewController = [[FullScreenProgressViewController alloc] initWithNibName:@"FullScreenProgressViewController" bundle:nil];
    }
    
    [self.window addSubview:__fullScreenProgressViewController.view ];
    __fullScreenProgressViewController.view.alpha = 1;
}

-(void)hideFullScreenProgress
{
    [self.fullScreenProgressViewController.view removeFromSuperview];
    self.fullScreenProgressViewController = nil;
}

-(void)showSalesCopyLengthIndicator
{
    if(self.salesCopyLengthIndicator == nil)
    {
        self.salesCopyLengthIndicator = [[LengthWidgetViewController alloc] initWithNibName:@"LengthWidgetViewController" bundle:nil];
        
        [self.window addSubview:self.salesCopyLengthIndicator.view];
        self.salesCopyLengthIndicator.view.center = CGPointMake(self.salesCopyLengthIndicator.view.frame.size.width/2, 100);

    }
    
    [UIView animateWithDuration:0.3 animations:^{
          self.salesCopyLengthIndicator.view.alpha = 1;
    } ];
  
}
-(void)hideSalesCopyLengthIndicator
{
    [UIView animateWithDuration:0.3 animations:^{
        self.salesCopyLengthIndicator.view.alpha = 0;
    } ];
    
}
-(void)updatedIndicatorWithLength:(int)length
{
    [self.salesCopyLengthIndicator updateLength:length];
}


#pragma mark -
-(CHDropboxSync*)syncer
{
    if(__syncer !=nil)
    {
        return __syncer;
    }

self.syncer = [[CHDropboxSync alloc] init];
self.syncController = [[SyncController alloc] init];
__syncer.dropboxSyncDelegate = syncController;

return __syncer;

}
#pragma mark -


@end
