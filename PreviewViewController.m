//
//  PreviewViewController.m
//  glamourAR
//
//  Created by Mahmood1 on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreviewViewController.h"
#import "AppColors.h"
#import <QuartzCore/QuartzCore.h>

#import "IconFile.h"
#import "ConciseKit.h"
#import "IconFile+LocalFileManagement.h"
#import <RestKit/CoreData/CoreData.h>
#import "DropboxConfigAPI.h"

#import "AppStorePreviewViewController.h"
#import "AppStoreSearchViewController.h"
#import "IconPreviewViewController.h"
#import "TextFieldCell.h"
#import "PreferencesPreviewViewController.h"
#import "IconFile+LocalFileManagement.h"
#import "GLAppDelegate.h"

enum TableViewRows
{
    kDisplayNameCell,
    kAppStoreSearchResultCell,
    kAppStoreListingCell,
    kIconNameCell,
    kIconPreviewCell,
    kPreferencesCell,
    kPaddingCell1,
    kNumberOfTableViewRows
};

#define kCompanyNameTag 15

@interface PreviewViewController()
-(void)updateTextLabels:(NSString*)string;
-(void)saveImages:(id)sender;
-(void)backButtonAction;
-(NSString*)appStoreName;
-(NSString*)iconName;
@end

@implementation PreviewViewController
@synthesize previewTableView;

@synthesize image57,image72,image114,image144,image512;
@synthesize image29,image50,image58;

@synthesize hueValue,transparencyValue;
@synthesize interfaceLayoutJSON;

@synthesize iconFile;
@synthesize appStoreDisplayPreview;
@synthesize iconPreviewViewController;
@synthesize appStoreSearchPreview;
@synthesize presentedViewController;
@synthesize preferencesPreviewViewController;
@synthesize doneButton;

@synthesize cameraImage;
@synthesize logoImage;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    	// Do any additional setup after loading the view, typically from a nib.

    
    self.image58 = [AppColors imageByScalingAndCroppingImage:image114 ForSize:CGSizeMake(58,58)];
    self.image29 = [AppColors imageByScalingAndCroppingImage:image114 ForSize:CGSizeMake(29,29)];
    self.image50 = [AppColors imageByScalingAndCroppingImage:image114 ForSize:CGSizeMake(50,50)];

    //this was trying to fix PNG images not being saved properly
//    self.cameraImage = [AppColors imageByScalingAndCroppingImage:self.cameraImage ForSize:CGSizeMake(320,480)];
//    self.logoImage = [AppColors imageByScalingAndCroppingImage:self.cameraImage ForSize:CGSizeMake(160,160)];
    
    
    NSAssert(self.image512!=nil,@"image512 is nil");
    
    NSAssert(self.image57!=nil,@"image57 is nil");
    NSAssert(self.image114!=nil,@"image114 is nil");


    NSAssert(self.image144!=nil,@"image144 is nil");
    NSAssert(self.image72!=nil,@"image72 is nil");
    
    NSAssert(self.image29!=nil,@"image29 is nil");
    NSAssert(self.image58!=nil,@"image58 is nil");
    NSAssert(self.image50!=nil,@"image50 is nil");
    

    
    self.appStoreSearchPreview = [[AppStoreSearchViewController alloc] initWithNibName:@"AppStoreSearchViewController" bundle:nil];
    
    //this listing is shown when the users search for apps in the app store
    [self.view addSubview:self.appStoreSearchPreview.view];
    [self.appStoreSearchPreview.view removeFromSuperview];
    self.appStoreSearchPreview.icon114.image = self.image114;
    self.appStoreSearchPreview.companyName.text = self.iconFile.companyName;
    self.appStoreSearchPreview.companyName.tag = kCompanyNameTag;
     self.appStoreSearchPreview.companyName.delegate = self;
    self.appStoreSearchPreview.appStoreName.delegate = self;
    self.appStoreSearchPreview.ratingsCount.delegate = self;
    self.appStoreSearchPreview.appStoreName.text = self.iconFile.appStoreName;
    
    //this is the detailed view for the app store entry
    self.appStoreDisplayPreview = [[AppStorePreviewViewController alloc] initWithNibName:@"AppStorePreviewViewController" bundle:nil];
    [self.view addSubview:self.appStoreDisplayPreview.view];
    [self.appStoreDisplayPreview.view removeFromSuperview];
    [self.appStoreDisplayPreview.appIconButton setImage:self.image114 forState:UIControlStateNormal];
    self.appStoreDisplayPreview.appStoreName.text = self.iconFile.appStoreName;
    self.appStoreDisplayPreview.companyName.tag = kCompanyNameTag;
    self.appStoreDisplayPreview.companyName.text = self.iconFile.companyName;
    self.appStoreDisplayPreview.companyName.delegate = self;
    self.appStoreDisplayPreview.appStoreName.delegate = self;

    
    
    self.iconPreviewViewController = [[IconPreviewViewController alloc] initWithNibName:@"IconPreviewViewController" bundle:nil];
    [self.view addSubview:self.iconPreviewViewController.view];
    [self.iconPreviewViewController.view removeFromSuperview];
    self.iconPreviewViewController.icon57.image = self.image57;
    self.iconPreviewViewController.icon114.image = self.image114;
    self.iconPreviewViewController.icon72.image = self.image72;
    self.iconPreviewViewController.icon144.image = self.image144;
    
    self.preferencesPreviewViewController = [[PreferencesPreviewViewController alloc] initWithNibName:@"PreferencesPreviewViewController" bundle:nil];
    [self.view addSubview:self.preferencesPreviewViewController.view];
    [self.preferencesPreviewViewController.view removeFromSuperview];
    self.preferencesPreviewViewController.appName.text = iconFile.springBoardName;
    self.preferencesPreviewViewController.iconImageView.image = image58;
    
    [self updateTextLabels:iconFile.springBoardName];
    
    
    //clear local content first to avoid creating duplicate files
    [self.iconFile deleteLocalContent];
}

- (void)viewDidUnload
{
        
    [self setPreviewTableView:nil];
    [self setDoneButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    GLAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate hideFullScreenProgress];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    
    [[RKObjectManager sharedManager].objectStore save];
    
    NSError *error = nil;
    [[RKObjectManager sharedManager].objectStore.managedObjectContext save:&error];
    
    if(error!=nil)
    {
        NSLog(@"error saving context: %@", [error localizedDescription]);
    }
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation == UIInterfaceOrientationPortrait);
    } else {
        return YES;
    }
//    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *fullString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    switch (textField.tag) {
        case kDisplayNameCell:
            self.appStoreDisplayPreview.appStoreName.text = fullString;
            self.appStoreSearchPreview.appStoreName.text = fullString;
            break;
            
        case kIconNameCell:
            
            [self updateTextLabels:fullString];
            
            break;
        default:
            break;
    }

    
       
    return YES;
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
 
    switch (textField.tag) {
        case kDisplayNameCell:
            
            break;
            
        case kIconNameCell:
            
//            [self.previewTableView scrollRectToVisible:CGRectMake(0, 360, 1, 1) animated:YES];
            //scroll up so the user can see changes in real time
            [self.previewTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:kIconNameCell inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        default:
            break;
    }
    return  YES;
}

-(BOOL) textFieldShouldReturn:(UITextField*) textField {
    [textField resignFirstResponder]; 

    
    switch (textField.tag) {
        case kDisplayNameCell:
             
            break;
            
        case kIconNameCell:
             
            break;
        default:
            break;
    }

    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case kDisplayNameCell:
            //update app store name
            iconFile.appStoreName = textField.text;
            
            self.appStoreDisplayPreview.appStoreName.text = textField.text;
            self.appStoreSearchPreview.appStoreName.text = textField.text;
            break;
            
        case kIconNameCell:
        {
             iconFile.springBoardName = textField.text;
            [self updateTextLabels:textField.text];
            
            
            //check for special characters +? and inform the user that the user needs to set the app's name in the project 
            NSMutableCharacterSet* alphaNumericWithWhiteSpace = [NSCharacterSet alphanumericCharacterSet];
            [alphaNumericWithWhiteSpace formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
            NSCharacterSet* allButAlphaNumeric = [alphaNumericWithWhiteSpace invertedSet];
            
            NSRange range = [textField.text rangeOfCharacterFromSet:allButAlphaNumeric];
            if(range.location != NSNotFound)
            {
                //has punctuation
                NSString* title = [NSString stringWithFormat:@"Special Characters: %@", [textField.text substringWithRange:range]];
                NSString* message = @"To submit an app with your name, set its name in\nxCode Project> Targets> Info> \"Bundle display name\" insted of renaming the target";
                
                [[[UIAlertView alloc] initWithTitle:title message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil]  show];
                
            }
        }
            break;
        default:
            break;
    }
    
    if(textField.tag == kCompanyNameTag)
    {
        self.appStoreDisplayPreview.companyName.text = textField.text;
        self.appStoreSearchPreview.companyName.text = textField.text;
        self.iconFile.companyName = textField.text;
    }
       
    
}




#pragma mark -
#pragma mark EMAIL IMAGE

-(void)displayComposerSheet
{
    MFMailComposeViewController *picker = [MFMailComposeViewController alloc];
    picker = [picker init];
        
    picker.mailComposeDelegate = self;
    
    NSLog(@"DEVICE MODEL: %@",[[UIDevice currentDevice] model]);
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;

    // ATTACHING A SCREENSHOT
    
    NSString* dirtyString = [self.iconFile cleanName];
    NSData *myData = UIImagePNGRepresentation(image512);
    
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"app_store_512x512.png"]];     
    

        myData = UIImagePNGRepresentation(image114);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"iPhone_retina_114x114.png"]];    

    

        myData = UIImagePNGRepresentation(image57);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPhone_57x57.png"]];    
    
        myData = UIImagePNGRepresentation(image144);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPad_retina_144x144.png"]];    

    

        myData = UIImagePNGRepresentation(image72);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPad_72x72.png"]];    

    

        myData = UIImagePNGRepresentation(image29);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPhone_preferences_29x29.png"]];    


        myData = UIImagePNGRepresentation(image58);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPhone_preferences_retina_58x58.png"]];    


        myData = UIImagePNGRepresentation(image50);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPad_preferences_50x50.png"]];    

   
    
    
    CGSize iPhoneRetinaIconSize = self.view.frame.size;
    //    CGSize iPhoneRetinaIconSize = CGSizeMake(57,57);
    
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(iPhoneRetinaIconSize, NO, [UIScreen mainScreen].scale);
    
    else
        UIGraphicsBeginImageContext(iPhoneRetinaIconSize);
    

    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    ////    UIImage *screenshot = [ScreenCapture UIViewToImage:self.view];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        
    UIGraphicsEndImageContext();

    myData = UIImagePNGRepresentation(screenshot);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"Preview%@",@"_iPhone.png"]];    
    
    //attach the interface file
    myData = [interfaceLayoutJSON dataUsingEncoding:NSUTF8StringEncoding];
    [picker addAttachmentData:myData mimeType:@"text/plain" fileName:[NSString stringWithFormat:@"%@%@",[self.iconFile cleanName],@"_interface.json"]];  
    
    NSString* filename = [NSString stringWithFormat:@"%@ iPhone App Maker Icons %@",[self.iconFile cleanName], [dateFormatter stringFromDate:[NSDate date]] ];
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
    NSString *emailBody = [NSString stringWithFormat:@"Attached are iOS icons for %@\n512x512 - for App store submission\n114x114 is iPhone with retina display \n57x57 is iPhone 3GS and below \n144x144 is iPadHD \n72x72 is iPad1 and iPad2 \n preferences icons are included: 58x58 is iPhone preferences retina display, 29x29 iPhone3GS preferences, 50x50 iPad and iPad2 preferences\nGradient shadow transparency: %.2f \nborder hue: %.2f",    
                           [self.iconFile cleanName],
                           transparencyValue,
                           hueValue                          
                           ];
    [picker setMessageBody:emailBody isHTML:NO];
    [self.navigationController presentModalViewController:picker animated:YES];
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}

- (IBAction)emailPhotos:(id)sender {
    [self displayComposerSheet];
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
    
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

-(void)updateTextLabels:(NSString*)string
{
    self.iconPreviewViewController.appName57.text = string;
    self.iconPreviewViewController.appName114.text = string;
    self.iconPreviewViewController.appName72.text = string;
    self.iconPreviewViewController.appName144.text = string;
    self.preferencesPreviewViewController.appName.text = string;

}



-(void)saveImages:(id)sender
{
      
    
    
    [self.iconFile saveLocalImage:image512 name:[self.iconFile iconImageWithType:kIconType512] isPNG: YES];
    
    [self.iconFile saveLocalImage:image114 name:[self.iconFile iconImageWithType:kIconType114] isPNG: YES];
    [self.iconFile saveLocalImage:image57 name:[self.iconFile iconImageWithType:kIconType57] isPNG: YES];

    [self.iconFile saveLocalImage:image144 name:[self.iconFile iconImageWithType:kIconType144] isPNG: YES];
    [self.iconFile saveLocalImage:image72 name:[self.iconFile iconImageWithType:kIconType72] isPNG: YES];
    
    
    [self.iconFile saveLocalImage:image58 name:[self.iconFile iconImageWithType:kIconType58] isPNG: YES];
    [self.iconFile saveLocalImage:image29 name:[self.iconFile iconImageWithType:kIconType29] isPNG: YES];
    [self.iconFile saveLocalImage:image50 name:[self.iconFile iconImageWithType:kIconType50] isPNG: YES];

#warning trying to create a PNG image from a logo the second time fails!
    [self.iconFile saveLocalImage:logoImage name:[self.iconFile iconImageWithType:kLogoType] isPNG: NO];
    
    [self.iconFile saveLocalImage:cameraImage name:[self.iconFile iconImageWithType:kCameraType] isPNG:NO];
    

    
    [[IconFile managedObjectContext] save:nil];
    NSLog(@"local images: %i",self.iconFile.localImages.count);
    //wait for images to be saved before allowing the user to return.

}


-(void)saveData:(id)sender
{
    NSString* newIconsFolder = [kLocalDataFolder stringByAppendingPathComponent: [self appStoreName] ];
    [self.iconFile moveLocalContentToLocalFolder:newIconsFolder];
    self.iconFile.localImageFolder = newIconsFolder;
    [self saveImages:self];
    
    [IconFile setupCoreDataObjectMapping];
    
    [self.iconFile generateLocalJSONData];
    [[self.iconFile managedObjectContext] save:nil];
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)backButtonAction:(id)sender
{
    GLAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate showFullScreenProgress];

    [self performSelector:@selector(saveData:) withObject:self afterDelay:1];
    
}
#pragma mark tableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return kNumberOfTableViewRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    static NSString *displayNameCell = @"displayNameCell";
    static NSString *appStoreSearchResultCell = @"appStoreSearchResultCell";
    static NSString *appStoreListingCell = @"appStoreListingCell";
    static NSString *iconNameCell = @"iconNameCell";
    static NSString *iconPreviewCell = @"iconPreviewCell";
    static NSString *preferencesCell = @"preferencesCell";
        static NSString *paddingCell = @"paddingCell";
    
    
    
    // Configure the cell...
    switch (indexPath.row) {
        case kDisplayNameCell:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:displayNameCell];
            TextFieldCell* displayName = (TextFieldCell*)cell;
            displayName.textField.text = self.iconFile.appStoreName;
            displayName.textField.tag = kDisplayNameCell;
            break;
        }
        case kAppStoreSearchResultCell:
            cell = [tableView dequeueReusableCellWithIdentifier:appStoreSearchResultCell];
            for(UIView* v in cell.subviews)
            {
                [v removeFromSuperview];
            }
            [cell addSubview:self.appStoreSearchPreview.view];
            break;
        case kAppStoreListingCell:
            cell = [tableView dequeueReusableCellWithIdentifier:appStoreListingCell];
            for(UIView* v in cell.subviews)
            {
                [v removeFromSuperview];
            }
            [cell addSubview:self.appStoreDisplayPreview.view];
            
            break;
        case kIconNameCell:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:iconNameCell];
            TextFieldCell* iconName = (TextFieldCell*)cell;
            iconName.textField.text = self.iconFile.springBoardName;  
            iconName.textField.tag = kIconNameCell;
            iconName.textField.center = CGPointMake( iconName.textField.center.x,  iconName.textField.center.y+12);
            
            break;
        }   
            
        case kIconPreviewCell:
            cell = [tableView dequeueReusableCellWithIdentifier:iconPreviewCell];
            for(UIView* v in cell.subviews)
            {
                [v removeFromSuperview];
            }
            [cell addSubview:self.iconPreviewViewController.view];   
            self.iconPreviewViewController.view.center = cell.center;
            
            break;
        case kPreferencesCell:
            cell = [tableView dequeueReusableCellWithIdentifier:preferencesCell];
            [cell addSubview:self.preferencesPreviewViewController.view];
            break;
            //fall through, all padding cells are the same
        case kPaddingCell1:
            cell = [tableView dequeueReusableCellWithIdentifier:paddingCell];
            
            break;
            
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case kDisplayNameCell:
            return 44;
            break;
        case kAppStoreSearchResultCell:
            return 72;
            
            break;
        case kAppStoreListingCell:
             return 84;
            
            break;
        case kIconNameCell:
            return 44;
            break;
        case kIconPreviewCell:
            return 120;
            
            break;
        case kPreferencesCell:
            return 44;
            
            break;
        case kPaddingCell1:

            return 240;
            
            break;

            
    }
    return 44;
}

#pragma mark -
#pragma mark UITableView datasource

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -
#pragma mark convenience methods


-(NSString*)cleanAndTrimTableViewCellAtIndex:(int)index
{
    TextFieldCell* cell = (TextFieldCell*)[self.previewTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow: index inSection:0]];
    NSString* stringToTrim = cell.textField.text;
    
    
    NSMutableCharacterSet* alphaNumericWithWhiteSpace = [NSCharacterSet alphanumericCharacterSet];
    [alphaNumericWithWhiteSpace formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    NSCharacterSet* allButAlphaNumeric = [alphaNumericWithWhiteSpace invertedSet];
    
    stringToTrim = [stringToTrim stringByTrimmingCharactersInSet:allButAlphaNumeric];
    return stringToTrim;
}

-(NSString*)iconName
{
    return [self cleanAndTrimTableViewCellAtIndex:kIconNameCell];
}

-(NSString*)appStoreName
{
    
    return [self cleanAndTrimTableViewCellAtIndex:kDisplayNameCell];
}

@end
