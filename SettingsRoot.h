//
//  SettingsRoot.h
//  ServiceRecord
//
//  Created by Chris Hulbert on 22/11/11.
//  Copyright (c) 2011 Splinter Software. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CHDropboxSync;

@interface SettingsRoot : UIViewController<UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic,weak)id delegate;
@property (nonatomic,strong)CHDropboxSync* syncer;

- (IBAction)performSync:(id)sender;
-(void)dismissController:(id)sender;

@end
