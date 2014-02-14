//
//  PulseViewController.h
//  Pulse
//
//  Created by Bushra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableViewCell;

enum PulseContentType
{
    kContentTypeFrames,
    kContentTypeGloss,
    kContentTypePostcards,
    kContentTypeNumberOfItems
    
};

@interface TableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    UITableView *tableView;
    TableViewCell *tableViewCell;
    
}

@property(nonatomic,strong) id<UITableViewDelegate>horizontalTableDelegate;

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet TableViewCell *tableViewCell;

@property (nonatomic, retain) NSArray *titlesArray;
@property (nonatomic, retain) NSMutableArray *iconsArray;


@property (nonatomic, retain) NSArray *arrays;

-(void)setupForContent:(int)contentType;

@end
