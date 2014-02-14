//
//  SimpleHomeScreen.m
//  glamourAR
//
//  Created by Alexander Stone on 3/26/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "SimpleHomeScreen.h"
#import "IconFile.h"
#import "AppStoreCell.h"
#import "GLFirstViewController.h"
#import "iToast.h"
#import "HelpOverlay.h"
#import "IconFileTextField.h"
#import "IconFile+LocalFileManagement.h"
#import "IconImageLocalFile.h"
#import "ConciseKit.h"

enum TextFieldTags
{
    kTextFieldCompanyName = 1,
    kTextFieldAppName,
    kTextFieldRatings,
    kNumberOfTextFields
};

@interface SimpleHomeScreen ()

-(void)enableDisableShareButtons;
-(void)displayComposerSheetWithFilePathList:(NSMutableArray*)filepathList;
@end

@implementation SimpleHomeScreen
@synthesize tableView;
@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext;
@synthesize shareToolbar;
@synthesize shareButton;
@synthesize buttonCopy;

@synthesize deleteButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.managedObjectContext =[IconFile managedObjectContext];
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    self.tableView.allowsSelection = YES;
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [self setShareToolbar:nil];
    [self setShareButton:nil];
    [self setDeleteButton:nil];
    [self setButtonCopy:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)viewWillAppear:(BOOL)animated
{
     bool mandatory =  ![[NSUserDefaults standardUserDefaults]boolForKey: @"initialHelpDone"];
    
    

    if(mandatory)
    {
        [self performSegueWithIdentifier:@"iconMakerHelp" sender:self];
    }else if( self.fetchedResultsController.fetchedObjects.count == 0){
         [self performSegueWithIdentifier:@"editIcon" sender:self];
    }
    
    [self.tableView reloadData];
    
    self.navigationController.navigationBar.translucent = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    int count = [[self.fetchedResultsController sections] count];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    int count = [sectionInfo numberOfObjects];
    return count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"appStoreCell";
    
    AppStoreCell *cell = [tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];


    if(cell == nil)
    {
        cell = [[AppStoreCell alloc]init ];
//        [[NSBundle mainBundle] loadNibNamed:@"AppStoreCell" owner:self options:nil];
//        
//        cell = appStoreCell;
      
    }

    [self configureCell:cell atIndexPath:indexPath];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0 || indexPath.row%2 == 0) {
//        UIColor *altCellColor = [UIColor colorWithWhite:0.5 alpha:0.1];
//        cell.backgroundColor = altCellColor;
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        IconFile* icon =[self.fetchedResultsController objectAtIndexPath:indexPath];

        
        
        [[IconFile managedObjectContext] deleteObject:icon];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//            abort();
        }
   
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self enableDisableShareButtons];
}
- (void)tableView:(UITableView *)tableView_ didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if(  self.tableView.editing)
  {
      //do nothing while selecting
      [self enableDisableShareButtons];
      return;
  }
    
//    iToast* toast =[iToast makeText:@"Loading Content..."];
//    [toast show];

    [self performSegueWithIdentifier:@"editIcon" sender:self];
    [tableView_ deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - Fetched results controller



- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil) {
        return __fetchedResultsController;
    }
    

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    fetchRequest.predicate = predicate;
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"IconFile" inManagedObjectContext:[IconFile managedObjectContext]];
    [fetchRequest setEntity:entity];
    [fetchRequest setFetchBatchSize:20];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createDate" ascending:NO];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error]) {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            
           
            
            break;
            
        case NSFetchedResultsChangeDelete:
        {
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
          
            
            //remove the item from the parent channel, causing it's video count to be updated
            
            break;
        }
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
         
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

- (void)configureCell:(AppStoreCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    
//    NSAssert(cell !=nil,@"cell is nil");
    
    IconFile *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString* title = managedObject.appStoreName;//managedObject.timeStamp description];
    if(title == nil)title = managedObject.springBoardName;
    if(title == nil)title =@"App Icon";
    
    cell.appStoreNameTextField.text = title;
    
    //remember which object the cell refers to
    cell.appStoreNameTextField.iconFile = managedObject;
    cell.companyNameTextField.iconFile = managedObject;
    cell.ratingTextField.iconFile = managedObject;
    
    cell.appStoreNameTextField.delegate = self;
    cell.companyNameTextField.delegate = self;
    cell.ratingTextField.delegate = self;
    
    cell.companyNameTextField.text = managedObject.companyName;

    
    cell.imageView.image = [managedObject displayImage];
    
//    cell.subtitle.text = managedObject.subtitle;
//    [cell.imageView setImageWithURL:[NSURL URLWithString:managedObject.thumbnail] placeholderImage:[UIImage imageNamed:@"placeholder.jpeg"]];
//    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{

    if([segue.identifier isEqualToString:@"editIcon"])
    {
              
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        IconFile *selectedObject = [self. fetchedResultsController objectAtIndexPath:indexPath];
        UINavigationController* nav = segue.destinationViewController;
        GLFirstViewController* iconMaker = (GLFirstViewController*)nav.topViewController;
        [iconMaker setIconFile:selectedObject];

    }else  if([segue.identifier isEqualToString:@"iconMakerHelp"])
    {
        NSMutableArray* instructionImages = [[NSMutableArray alloc] initWithCapacity:7];
        
        
        for(int i = 1; i<6;i++)
        {
            [instructionImages addObject:[NSString stringWithFormat:@"photo %i.PNG",i]];  
        }
        
        [segue.destinationViewController setInstructionImages:instructionImages];
        
        bool mandatory =  ![[NSUserDefaults standardUserDefaults]boolForKey: @"initialHelpDone"];
        [segue.destinationViewController setMandatoryView:mandatory];
    }
}

- (IBAction)newIcon:(id)sender {

}


#pragma mark -
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(IconFileTextField *)textField
{

    switch (textField.tag) {
        case kTextFieldCompanyName:
            textField.iconFile.companyName = textField.text;
            break;
        case kTextFieldAppName:
            textField.iconFile.appStoreName = textField.text;

            break;
        case kTextFieldRatings:
//            textField.iconFile.companyName = textField.text;
            
        
            break;
            
        default:
            
            break;
    }
    
    [textField resignFirstResponder];
    [[textField.iconFile managedObjectContext] save:nil];
    return YES;
}
#pragma mark -
#pragma mark ShareToolbar actions

-(void)enableDisableShareButtons
{
    int count =  [self.tableView indexPathsForSelectedRows].count;
    
    self.shareButton.enabled  = count > 0 ?YES:NO;
    self.buttonCopy.enabled   = count > 0 ?YES:NO;
    self.deleteButton.enabled = count > 0 ?YES:NO;
}

-(void)hideShareToolbar
{
    [UIView animateWithDuration:0.3 animations:^{
        self.shareToolbar.alpha = 0;
        self.tableView.editing = NO;
        self.tableView.allowsMultipleSelectionDuringEditing = NO;
    }];
}

- (IBAction)shareAction:(id)sender {
    
    NSArray* rowsToShare = [self.tableView indexPathsForSelectedRows];
    IconFile* iconFile = nil;
    NSArray* imageFilesForIcon = nil;
    NSMutableArray* allRequestedImages = [[NSMutableArray alloc] initWithCapacity:rowsToShare.count*8];
    NSString* pngFile = @"png";
    
    for(NSIndexPath* indexPath in rowsToShare)
    {
        // Delete the managed object for the given index path
        iconFile =[self.fetchedResultsController objectAtIndexPath:indexPath];
        
        imageFilesForIcon = [iconFile imageFilepaths];
       
        for(NSString* filepath in imageFilesForIcon)
        {
            DLog(@"Received filepath: %@",filepath);
            if([[filepath pathExtension]isEqualToString:pngFile])
            {
                [allRequestedImages addObject:filepath];
            }
        }
    }
    
    [self displayComposerSheetWithFilePathList:allRequestedImages];
    
    
    [self hideShareToolbar];
}

- (IBAction)copyAction:(id)sender {
    [self hideShareToolbar];
}

- (IBAction)deleteAction:(id)sender {
    
    NSArray* rowsToDelete = [self.tableView indexPathsForSelectedRows];
     NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSManagedObject* iconToDelete = nil;
    
    for(NSIndexPath* indexPath in rowsToDelete)
    {
        // Delete the managed object for the given index path
         iconToDelete =[self.fetchedResultsController objectAtIndexPath:indexPath];
         [[iconToDelete managedObjectContext] deleteObject:iconToDelete];
    }

    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. 
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //            abort();
    }
    
    [self hideShareToolbar];
}



- (IBAction)actionButtonAction:(id)sender {
   
    if(self.shareToolbar.alpha !=1)
    {
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    self.tableView.editing = YES;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.shareToolbar.alpha = 1;
    }];
    }else {
        [self hideShareToolbar];
    }
    
}
#pragma mark -
#pragma mark DROPBOX
- (IBAction)dropboxAction:(id)sender {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"✭✭ Premium Feature ✭✭" message:@"Sync with dropbox is available to premium users only. With Dropbox Sync you will have access to all your icons from anywhere!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Go Premium!",nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == (alertView.firstOtherButtonIndex))
    {
        [self performSegueWithIdentifier:@"dropboxSync" sender:self];

    }
     
}


#pragma mark -
#pragma mark EMAIL IMAGE

-(void)displayComposerSheetWithFilePathList:(NSMutableArray*)filepathList
{
    MFMailComposeViewController *picker = [MFMailComposeViewController alloc];
    picker = [picker init];
      
    picker.mailComposeDelegate = self;
//    
//    NSLog(@"DEVICE MODEL: %@",[[UIDevice currentDevice] model]);
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    
    // ATTACHING A SCREENSHOT
    NSData* imageData =nil;
    for(NSString* filepath in filepathList)
    {
//        DLog(@"filepath: %@",filepath);
//        DLog(@"file exists: %@",[[NSFileManager defaultManager] fileExistsAtPath:filepath]?@"YES":@"NO");
        imageData = [NSData dataWithContentsOfFile:filepath];
        [picker addAttachmentData:imageData mimeType:@"image/png" fileName: [filepath lastPathComponent]];    
    }
    

    
    NSString* filename = [NSString stringWithFormat:@"iPhone App Maker Icons %@", [dateFormatter stringFromDate:[NSDate date]] ];
    [picker setSubject:filename];
    NSArray *toRecipients = nil;
    // Set up recipients
    NSString* email= [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    if(email!=nil){
        toRecipients = [NSArray arrayWithObject:email]; 
    }else{
        toRecipients = [NSArray arrayWithObject:@""];
    }
    
    
    [picker setToRecipients:toRecipients];
    // [picker setCcRecipients:ccRecipients];   
    // [picker setBccRecipients:bccRecipients];
    
    
    // Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@"Attached are iOS icons for your apps\n512x512 - for App store submission\n114x114 is iPhone with retina display \n57x57 is iPhone 3GS and below \n144x144 is iPadHD \n72x72 is iPad1 and iPad2 \n preferences icons are included: 58x58 is iPhone preferences retina display, 29x29 iPhone3GS preferences, 50x50 iPad and iPad2 preferences\nSimply drag and drop your icons into your xCode project >Target>Summary tab (xCode 4.x)"];
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:picker animated:YES];
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
    [self.tabBarController.tabBar setHidden:NO]; 
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            //            NSLog(@"Result: canceled");
            break;
        case MFMailComposeResultSaved:
            //            NSLog(@"Result: saved");
        { 
            //            [dataManager cleanupCSVFiles];
            break;
        }
        case MFMailComposeResultSent:
            //            NSLog(@"Result: sent");
        {
            //            [dataManager cleanupCSVFiles];
            break;
        }
        case MFMailComposeResultFailed:
            //            NSLog(@"Result: failed");
            break;
        default:
            //            NSLog(@"Result: not sent");
            break;
    }
    
    [self dismissModalViewControllerAnimated:YES];
}



#pragma mark -
@end
