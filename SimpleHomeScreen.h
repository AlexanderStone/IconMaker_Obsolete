//
//  SimpleHomeScreen.h
//  glamourAR
//
//  Created by Alexander Stone on 3/26/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>


@class AppStoreCell;
@interface SimpleHomeScreen : UIViewController<UITableViewDelegate,UITableViewDataSource,NSFetchedResultsControllerDelegate,UITextFieldDelegate, UIAlertViewDelegate, MFMailComposeViewControllerDelegate>
{
    AppStoreCell* appStoreCell;
}


- (IBAction)newIcon:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property(nonatomic,strong)NSFetchedResultsController* fetchedResultsController;
@property(nonatomic,strong)NSManagedObjectContext* managedObjectContext;

- (IBAction)actionButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIToolbar *shareToolbar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *shareButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonCopy;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *deleteButton;

- (IBAction)shareAction:(id)sender;
- (IBAction)copyAction:(id)sender;
- (IBAction)deleteAction:(id)sender;
- (IBAction)dropboxAction:(id)sender;

@end
