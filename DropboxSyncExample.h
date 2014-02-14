//
//  RKCoreDataExample.h
//  RKCatalog
//
//  Created by Blake Watters on 4/21/11.
//  Copyright 2011 Two Toasters. All rights reserved.
//

#import "RKCatalog.h"
#import "CHDropboxSync.h"

@class AppUser;
@interface DropboxSyncExample : UIViewController<UITableViewDelegate, UITableViewDataSource,CHDropboxSyncDelegate,UIAlertViewDelegate,NSFetchedResultsControllerDelegate> {
    NSArray* _articles;
    AppUser* appUser;
}

@property (retain,nonatomic)NSDateFormatter* dateFormatter;
@property (retain, nonatomic) IBOutlet UITableView *tableView;
@property (retain, nonatomic) NSFetchedResultsController* fetchedResultsController;

- (IBAction)doLoginLogout:(id)sender;
@property (retain, nonatomic) IBOutlet UIBarButtonItem *doSyncActionButton;
- (IBAction)doSyncAction:(id)sender;

-(void) setupObjectMapping;
-(void)syncComplete:(id)sender; 
@end
