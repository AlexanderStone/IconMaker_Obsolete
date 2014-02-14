//
//  PulseViewController.m
//  Pulse
//
//  Created by Bushra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "AppColors.h"

@implementation TableViewController
@synthesize tableView;
@synthesize tableViewCell;


@synthesize iconsArray;

@synthesize arrays;
@synthesize horizontalTableDelegate;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    iconsArray = [[NSMutableArray alloc] initWithCapacity:5]; 
    

    arrays = [[NSArray alloc] initWithObjects:iconsArray, nil];

    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    TableViewCell *cell = (TableViewCell*)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil];
        
        CGAffineTransform rotateTable = CGAffineTransformMakeRotation(-M_PI_2);
        tableViewCell.horizontalTableView.transform = rotateTable;
        tableViewCell.horizontalTableView.frame = CGRectMake(0, 0, tableViewCell.horizontalTableView.frame.size.width, tableViewCell.horizontalTableView.frame.size.height);
//        tableViewCell.horizontalTableView.frame = CGRectMake(0, 0,57,57);
        
        tableViewCell.contentArray = [arrays objectAtIndex:indexPath.section];
        
        tableViewCell.horizontalTableView.delegate = horizontalTableDelegate;
        
        tableViewCell.horizontalTableView.allowsSelection = YES;
		cell = tableViewCell;
		//self.tableViewCell = nil;
        
	}
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}



- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
   }


- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

-(void)setupForContent:(int)contentType
{
    switch (contentType) {
        case kContentTypeFrames:
            for(int i = -1; i< 28;i++)
            {
                NSString* frameName = [AppColors frameNameWithTag:i];
                if(frameName!=nil)
                {
                    [iconsArray addObject:frameName];
                }
            }
            break;
        case kContentTypeGloss:
            for(int i = 0; i< 16;i++)
            {
                [iconsArray addObject:[AppColors glossEffectWithTag:i]];
            }
            break;
        case kContentTypePostcards:
            for(int i = 1; i< 10;i++)
            {
                [iconsArray addObject:[AppColors postcardFrameWithTag:i]];
            }
            break;
        default:
            break;
    }
  
    
}

@end
