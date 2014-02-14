//
//  KeywordCountTableViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/22/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeywordCountTableViewController : UITableViewController<UITextViewDelegate>

- (IBAction)dismissController:(id)sender;
- (IBAction)save:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *keywordsTextView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *keywordsLengthLabel;
@property (weak, nonatomic) IBOutlet UIView *keywordsContainer;
@property (weak, nonatomic) IBOutlet UIView *keywordsLengthContainer;

@property(nonatomic,strong)NSArray* keywordsArray;

@property(nonatomic,strong)NSString* salesCopy;

@end
