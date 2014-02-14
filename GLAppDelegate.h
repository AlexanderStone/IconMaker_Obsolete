//
//  GLAppDelegate.h
//  glamourAR
//
//  Created by Mahmood1 on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CoreDataManager;
@class RKObjectManager;
@class LengthWidgetViewController;
@class CHDropboxSync;
@class SyncController;
@class FullScreenProgressViewController;

@interface GLAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic)SyncController* syncController; 

@property(nonatomic,strong)LengthWidgetViewController* salesCopyLengthIndicator;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property(nonatomic,strong)RKObjectManager* rkCoreDataManager;

@property(strong,nonatomic)UIView* userIdentifierView;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

-(void)interfaceWithColorFromPreferences;

-(void)initializeRestKit;

-(void)updatedIndicatorWithLength:(int)length;
-(void)showSalesCopyLengthIndicator;
-(void)hideSalesCopyLengthIndicator;

-(void)showFullScreenProgress;
-(void)hideFullScreenProgress;

@property(nonatomic,strong)CHDropboxSync* syncer;
@property(nonatomic,strong)FullScreenProgressViewController* fullScreenProgressViewController;
@end
