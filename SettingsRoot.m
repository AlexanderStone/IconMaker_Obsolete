//
//  SettingsRoot.m
//  ServiceRecord
//
//  Created by Chris Hulbert on 22/11/11.
//  Copyright (c) 2011 Splinter Software. All rights reserved.
//

#import "SettingsRoot.h"
#import "DropboxSDK.h"
//#import "Exporter.h"
#import "CHDropboxSync.h"
#import "ConciseKit.h"
#import "GLAppDelegate.h"
#import "DropboxConfigAPI.h"
#import "ButtonCell.h"
#import "AppGraphics.h"
#import <QuartzCore/QuartzCore.h>

enum DropboxSection {
    kSectionPrepare,
    kSectionSync,
//    kSectionLogic,
    kNumberOfSections
    
    };

enum PrepareRows
{
    kRowGetDrobox,
    kRowLinkAccount,
    kNumberOfPrepareRows
};

enum SyncRows
{
    kRowSync,
    kNumberOfSyncRows
};

enum LogicRows
{
//    kFileSizeRow,
    kHelpRow,
    kNumberOfLogicRows
};

static UIBackgroundTaskIdentifier taskIdentifier;
enum AlertViews {
    kAlertViewLogOut = 1,
    kAlertViewSync = 2
    };

@interface SettingsRoot()
-(void)doSyncInBackground:(id)sender;
-(void)backgroundSyncWifiCheck;

@end

@implementation SettingsRoot
@synthesize tableView;
@synthesize delegate;
@synthesize syncer;

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
//    [super dealloc];
}

-(void)awakeFromNib
{
    [super awakeFromNib];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linked:) name:@"Linked" object:nil];
    
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
//    [self.view addSubview:self.progressViewController.view];
    
    GLAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    self.syncer = appDelegate.syncer;
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
   
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return  kNumberOfSections;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    switch (section) {
        case kSectionPrepare:
            return kNumberOfPrepareRows;
            break;
        case  kSectionSync:
            return kNumberOfSyncRows;
            break;
            
            break;
//        case kSectionLogic:
//            return kNumberOfLogicRows;
//            break;
            
        default:
            return 0;
            break;
    }
    
   
}

-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    
    switch (section) {
        case kSectionPrepare:
            return @"Prepare for File Synchronization";
            break;
        case  kSectionSync:
            return @"";
            break;
            
            break;
//        case kSectionLogic:
//            return @"Deleting files from the app deletes them from dropbox on next sync. Deleting from dropbox deletes from the device on next sync.";
//            break;
            
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    static NSString *buttonCellIdentifier = @"buttonCell";
   
    UITableViewCell *cell = nil;    
    // Configure the cell...
    cell.textLabel.text=nil;
    cell.detailTextLabel.text = nil;
    cell.accessoryView = nil;
    
    switch (indexPath.section) {
        case kSectionPrepare:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
            }

            
            switch (indexPath.row) {
                    
                case kRowGetDrobox:
                    
                    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"dbapi-1://"]]) {
                        cell.textLabel.text = @"Dropbox";
                        cell.detailTextLabel.text = @"Installed";
                    } else {
                        NSLog(@"Facebook is not installed.");
                        cell.textLabel.text = @"Get Dropbox";
                        cell.detailTextLabel.text = @"(Required to login)";
                    }
                    
                    break;
                case kRowLinkAccount:
                    cell.textLabel.text = @"Account";
                    if ([[DBSession sharedSession] isLinked]) {
                        cell.detailTextLabel.text = @"Linked";
                    } else {
                        cell.detailTextLabel.text = @"Authorization required";
                    }        
                    break;

                    
                default:
                    break;
            };
            break;
        }
        case  kSectionSync:
        {
            switch (indexPath.row) {
                    
                case kRowSync:
                {
                    cell = [tableView dequeueReusableCellWithIdentifier:buttonCellIdentifier];
//                    cell.textLabel.text = @"Synchronize now";
                    ButtonCell* buttonCell = (ButtonCell*)cell;
                    
                    
                    buttonCell.button.layer.cornerRadius = 8;
                    buttonCell.button.layer.masksToBounds = YES;
                     buttonCell.button.layer.borderColor = [[UIColor blackColor] CGColor];
                     buttonCell.button.layer.borderWidth = 1;
//                    UIColor* topColor =[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:0.6];
//                    UIColor* bottomColor =[UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:1];
//                    [AppGraphics addLinearGradientToView: buttonCell.button TopColor:topColor BottomColor:bottomColor];
                    
                    break;
                }
                default:
                    break;
            }
            
            
            break;
        }
//        case kSectionLogic:
//        {
//            cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//            if (cell == nil) {
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
//            }
//
//            switch (indexPath.row) {
////                case kFileSizeRow:
////                    cell.textLabel.text = @"Filesize: 24mb";
////                    break;    
//                case kHelpRow:
//                    cell.textLabel.text = @"Sync Readme (pretty please)";
//                    break;
//                default:
//                    break;
//            }
//            break;
//        }
        default:
            
            break;
    }


    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    switch (section) {
        case kSectionPrepare:
            return 215;
            break;
        case kSectionSync:
            return 1;
            break;
            
        default:
            return 1;
            break;
    }
}
-(NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if(section == kSectionPrepare)
    {
        return @"Sync lets you retrieve icons or continue work from another app linked to the same Dropbox.\n Deleting files from the one app deletes them from Dropbox on next sync.\n Deleting files from Dropbox deletes them on all linked devices on next sync.\nThere's no merging changes. Latest modified file is always preferred.\n Sync again on errors. ";
    }else {
        return @"";
    }
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView_ didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
                   }
        if (indexPath.row==1) {
       
#warning todo - check if this background task is dependent on the settings root being active controller (check delegate callbacks)
            //causes the user to be able to do other stuff while the sync is going on
//             [self performSelectorInBackground:@selector(backgroundSync:) withObject:nil]; 
//             [self performSelectorInBackground:@selector(backgroundSyncWifiCheck) withObject:nil]; 
//            [self backgroundSyncWifiCheck];
            
            [self backgroundSync:self];
        }
    }
    
    
    
    
    
    switch (indexPath.section) {
        case kSectionPrepare:
        {
            switch (indexPath.row) {
                    
                case kRowGetDrobox:
                    
                                       
                    break;
                case kRowLinkAccount:
                    if (![[DBSession sharedSession] isLinked]) {
                        [[DBSession sharedSession] link];
                    } else {
                        UIAlertView* logOutAlert =  [[UIAlertView alloc] initWithTitle:@"Log out" 
                                                                               message:@"Are you sure you wish to unlink your Dropbox account?" 
                                                                              delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Unlink", nil];
                        logOutAlert.tag = kAlertViewLogOut;
                        [logOutAlert show];
                    }

                    break;
                    
                    
                default:
                    break;
            };
            break;
        }
        case  kSectionSync:
        {
            switch (indexPath.row) {
                    //perform the sync!
                case kRowSync:
                    [self backgroundSync:self];
                    break;
                default:
                    break;
            }
            
            
            
        }
//        case kSectionLogic:
//        {
//            switch (indexPath.row) {
//                    
//                case kHelpRow:
//                    
//                    break;
//                default:
//                    break;
//            }
//        }
        default:
            
            break;
    }

    
    [tableView_ deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Syncer



#pragma mark - Linked notification

- (void)linked:(NSNotification*)n {
    [self.tableView reloadData];
}


-(void)backgroundSyncWifiCheck
{
    // First up, ask for confirmation
    BOOL wifi = [DropboxConfigAPI isReachableByWifi];
    NSString* message = wifi ? @"Synchronize with Dropbox?" :
    @"Are you sure you wish to synchronize with Dropbox? You're not on wifi - this will cause a lot of your data usage.";
   UIAlertView* syncAlert =  [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Sync", nil];
    syncAlert.tag = kAlertViewSync;
    [syncAlert show];

}

- (void)backgroundSync:(id)sender
{
    
    NSAssert(self.syncer !=nil,@"syncer is not set!");
    
    if(isSynchronizing)
    {
        DLog(@"Already synchronizing!");
        return;
    }
    
    
//    NSLog(@"%@",NSStringFromSelector(_cmd));
//    
//    __block UIBackgroundTaskIdentifier taskIdentifier;
//    taskIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
//        NSLog(@"Background task ran out of time and was terminated.");
//        [[UIApplication sharedApplication] endBackgroundTask: taskIdentifier];
//        taskIdentifier = UIBackgroundTaskInvalid;
//    }];
//    NSLog(@"taskIdentifier: %d",taskIdentifier);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        
//        if ([[DBSession sharedSession] isLinked])
//        {
//    
//            [self.syncer doSync];
//
//        }
//    });
    
    if ([[DBSession sharedSession] isLinked])
    {
        
        [self.syncer doSync];
        
    }

}

#pragma mark - 
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    if(alertView.tag == kAlertViewLogOut)
    {
        if ( buttonIndex == alertView.firstOtherButtonIndex) {
            [[DBSession sharedSession] unlinkAll];
            [self.tableView reloadData];
            return;
        }
        
    }
    if(alertView.tag == kAlertViewSync)
    {
        if(buttonIndex == alertView.firstOtherButtonIndex)
        {
            [self backgroundSync:alertView]; 
        }else {
            //do nothing
        }
    }
    
}

#pragma mark -

- (IBAction)performSync:(id)sender {
    if ([[DBSession sharedSession] isLinked])
    {
        [self backgroundSync:nil];
    }else {
        NSString* message = 
        @"Please allow the app to access your dropbox using the account action above.";
        UIAlertView* authorizationAlert =  [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [authorizationAlert show];

    }
    
}

-(void)dismissController:(id)sender
{
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
