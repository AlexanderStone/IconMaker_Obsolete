//
//  ApplicationTableViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "ApplicationTableViewController.h"
#import "AppStorePreviewViewController.h"
#import "SalesCopyViewController.h"
#import "GLAppDelegate.h"

enum AppTableViewSections
{
    kSectionPreview,
    kSectionSalesCopy,
    kSectionPromotionScreenshots,
    kSectionDocumentation,
    kSectionNumberOfSections
};

@interface ApplicationTableViewController ()

@end

@implementation ApplicationTableViewController
@synthesize appStorePreview;
@synthesize salesCopyController;
@synthesize appDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.allowsSelection = NO;
    
    
    self.appStorePreview = [[AppStorePreviewViewController alloc] initWithNibName:@"AppStorePreviewViewController" bundle:nil];
    self.appDelegate = (GLAppDelegate*)[[UIApplication sharedApplication] delegate];
    [self.appDelegate showSalesCopyLengthIndicator];
    
    self.salesCopyController = [[SalesCopyViewController alloc] initWithNibName:@"SalesCopyViewController" bundle:nil];
    [self.view addSubview:self.salesCopyController.view];
    [self.salesCopyController.view removeFromSuperview];
    self.salesCopyController.salesCopyTextField.delegate = self;
    [self.appDelegate updatedIndicatorWithLength:self.salesCopyController.salesCopyTextField.text.length];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.appDelegate hideSalesCopyLengthIndicator];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    
    static NSString *previewCellIdentifier = @"appStorePreview";
    static NSString *salesCopyCellIdentifier = @"salesCopyCell";
    static NSString *documentationCellIdentifier = @"documentationCell";
    static NSString *promotionScreenCellIdentifier = @"promotionCell";
    
    
    // Configure the cell...
    switch (indexPath.row) {
        case kSectionPreview:
            cell = [tableView dequeueReusableCellWithIdentifier:previewCellIdentifier];
            [cell addSubview:self.appStorePreview.view];
            
            break;
       
            
        case kSectionSalesCopy:
            cell = [tableView dequeueReusableCellWithIdentifier:salesCopyCellIdentifier];
            [cell addSubview:self.salesCopyController.salesCopyTextField];
//            self.salesCopyController.salesCopyTextField.center = cell.center;
            break;
            
        case kSectionDocumentation:
            cell = [tableView dequeueReusableCellWithIdentifier:documentationCellIdentifier];
            break;
        case kSectionPromotionScreenshots:
            cell = [tableView dequeueReusableCellWithIdentifier:promotionScreenCellIdentifier];
        default:
            cell = [tableView dequeueReusableCellWithIdentifier:documentationCellIdentifier];
            break;
    }
     
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case kSectionPreview:
            return 75;
            break;
            
        case kSectionSalesCopy:
        {
            int height = self.salesCopyController.salesCopyTextField.contentSize.height;
            NSLog(@"height: %i",height);
            NSLog(@"length: %i",self.salesCopyController.salesCopyTextField.text.length);
            return self.salesCopyController.salesCopyTextField.contentSize.height;
            break;
        }
        case kSectionDocumentation:
            return 106;

            break;
        case kSectionPromotionScreenshots:
            return 106;
            
            break;
        default:
            return 44;
            break;
    }
}


-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return nil;
    
//    // Configure the cell...
//    switch (section) {
//        case kSectionPreview:
//            return @"App Store Preview";
//            break;
//        
//            
//        case kSectionSalesCopy:
//            return @"Sales Copy";
//            break;
//            
//        case kSectionDocumentation:
//            return @"Documentation Files";
//            break;
//            
//        case kSectionPromotionScreenshots:
//            return @"Promotional Screenshots";
//        default:
//            
//            return nil;
//            break;
//    }

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self.appDelegate showSalesCopyLengthIndicator];
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView
{
    [self.appDelegate hideSalesCopyLengthIndicator];
}
-(void)textViewDidChange:(UITextView *)textView
{
    [self.appDelegate updatedIndicatorWithLength:self.salesCopyController.salesCopyTextField.text.length];

}

@end
