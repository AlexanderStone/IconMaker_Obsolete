//
//  CHDropboxSync.h
//
//  Created by Chris Hulbert on 11/12/11.
//  Copyright (c) 2011 Splinter Software. All rights reserved.
//  MIT license - no warranties!

#import <Foundation/Foundation.h>
#import "DropboxSDK.h"
#import <RestKit/RestKit.h>

@class SyncTask;
@class BackgroundProgressViewController;

static UIBackgroundTaskIdentifier taskIdentifier;
static BOOL isSynchronizing;

@protocol CHDropboxSyncDelegate <NSObject>

-(void)syncStarted;
-(void)syncCancelled;
-(void)syncComplete;
-(void)syncError:(NSString*)errorMessage;



-(void)downloadedFileAtPath:(NSString*)path;
-(void)deserializeFileAtPath:(NSString*)path;
-(void)deletedFileAtPath:(NSString*) path;
-(BackgroundProgressViewController*)backgroundProgressViewController;
-(void)showBackgroundProgress;
-(void)hideBackgroundProgress;

@end

@class BackgroundProgressViewController;

@interface CHDropboxSync : NSObject<DBRestClientDelegate, UIAlertViewDelegate>

@property(nonatomic,retain)BackgroundProgressViewController* backgroundProgressViewController;
@property(nonatomic,retain)id<CHDropboxSyncDelegate> dropboxSyncDelegate;

- (void)doSync;
+ (void)forgetStatus;
- (NSDictionary*)dataStructureFromManagedObject:(NSManagedObject*)managedObject;
- (NSArray*)dataStructuresFromManagedObjects:(NSArray*)managedObjects;
- (NSString*)jsonStructureFromManagedObjects:(NSArray*)managedObjects;
- (NSManagedObject*)managedObjectFromStructure:(NSDictionary*)structureDictionary withManagedObjectContext:(NSManagedObjectContext*)moc;
- (NSArray*)managedObjectsFromJSONStructure:(NSString*)json withManagedObjectContext:(NSManagedObjectContext*)moc
;



@end
