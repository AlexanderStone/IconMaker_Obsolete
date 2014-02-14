//
//  PreferencesViewController.m
//  glamourAR
//
//  Created by Mahmood1 on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PreferencesViewController.h"
#import "TextFieldCell.h"
#import "SwitchCell.h"
#import "ImageViewCell.h"
#import "ConciseKit.h"
#import <QuartzCore/QuartzCore.h>

enum PreferenceTableViewCells {
    kDefaultCompanyNameRow,
    kEmailAddressRow,
    kWebViewHomePageRow,
    kWebViewControlRow,
    kLogoSelectRow,
    kLargeIconSaveRow,
    kPreferenceNumberOfRows
    };

enum TextFieldTags {
    kCompanyNameTag = 1,
    kEmailTag = 2,
    kWebViewTag = 3,
    kNumberOfTags
    };

@implementation PreferencesViewController




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
  
    
//    UIBarButtonItem* dismissControllerButton = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissController)];
//    self.navigationItem.leftBarButtonItem = dismissControllerButton;
    

    NSString* searchEnginePref = [[NSUserDefaults standardUserDefaults] stringForKey:@"searchEngine"];
    
    if(searchEnginePref ==nil ||searchEnginePref.length ==0){
        searchEnginePref = @"http://www.google.com";
        [[NSUserDefaults standardUserDefaults] setValue:searchEnginePref forKey:@"searchEngine"];
    }
    
       
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
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
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}



#pragma mark -
#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{

}


-(void)textFieldDidEndEditing:(UITextField *)textField
{
    
    switch (textField.tag) {
        case kCompanyNameTag:
        {
             [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"companyName"];
            break;
        }
        case kEmailTag:
        {
                [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"email"];
            break;
        }
        case kWebViewTag:
        {
             [[NSUserDefaults standardUserDefaults] setValue:textField.text forKey:@"searchEngine"];
            break;
        }
        default:
            break;
    }

}
-(void)textViewDidEndEditing:(UITextView *)textView
{
//    dreamEvent.dreamDescription = textView.text;
}




- (IBAction)searchEnginePrefChanged:(id)sender {
    UISegmentedControl* segmentedControl = sender;
    switch (segmentedControl.selectedSegmentIndex) {
        case 0:
        {
            [[NSUserDefaults standardUserDefaults] setValue: @"http://www.google.com" forKey:@"searchEngine"];
//            searchEngineField.text = @"http://www.google.com" ;
            break;
        }
        case 1:
        {
            [[NSUserDefaults standardUserDefaults] setValue: @"http://www.bing.com" forKey:@"searchEngine"];
//            searchEngineField.text = @"http://www.bing.com" ;
        }
        case 2:
        {
            [[NSUserDefaults standardUserDefaults] setValue: @"http://www.yahoo.com" forKey:@"searchEngine"];
//            searchEngineField.text = @"http://www.yahoo.com" ;
        }
        default:
            break;
    }
    [self.tableView reloadData];
    
}

- (IBAction)saveToCameraRollPrefChanged:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:((UISwitch*)sender).on forKey:@"saveToCamera"];
}



//160,317
- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // banner is invisible now and moved out of the screen on 50 px
        banner.alpha = 1;
//        banner.center = CGPointMake(160,25);
        [UIView commitAnimations];
        bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // banner is visible and we move it out of the screen, due to connection issue
        banner.alpha = 0;
//        banner.center = CGPointMake(160,-150);
        [UIView commitAnimations];
        bannerIsVisible = NO;
    }
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
    return kPreferenceNumberOfRows;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Save time by setting these preferences. They apply to all new icons.";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = nil;
    static NSString *companyCell = @"companyCell";
    static NSString *emailCell = @"emailCell";
    static NSString *homePageCell = @"homePageCell";
    static NSString *homePageControl = @"homePageControl";
    static NSString *logoCell = @"logoCell";
    static NSString *saveIconsCell = @"saveIconsCell";
    
    TextFieldCell* textFieldCell = nil;
    
    
    // Configure the cell...
    switch (indexPath.row) {
        case kDefaultCompanyNameRow:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:companyCell];
            textFieldCell = (TextFieldCell*)cell;
            textFieldCell.textField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"companyName"];
            break;
        }
        case kEmailAddressRow:
            cell = [tableView dequeueReusableCellWithIdentifier:emailCell];
            textFieldCell = (TextFieldCell*)cell;
            textFieldCell.textField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"email"];
            break;
        case kWebViewHomePageRow:
            cell = [tableView dequeueReusableCellWithIdentifier:homePageCell];
            textFieldCell = (TextFieldCell*)cell;
            textFieldCell.textField.text = [[NSUserDefaults standardUserDefaults] stringForKey:@"searchEngine"];
            
            break;
        case kWebViewControlRow:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:homePageControl];
            
            
            break;
        }   
            
        case kLogoSelectRow:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:logoCell];
            ImageViewCell* imageViewCell = (ImageViewCell*)cell;
            imageViewCell.imageViewCustom.layer.cornerRadius = imageViewCell.imageViewCustom.layer.bounds.size.height/2;
            imageViewCell.imageViewCustom.layer.masksToBounds = YES;
            NSString* defaultLogoPath = [[$ documentPath] stringByAppendingPathComponent:@"DefaultLogo.png"];
            if([[NSFileManager defaultManager]fileExistsAtPath:defaultLogoPath])
            {
                UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfFile:defaultLogoPath]];
                imageViewCell.imageViewCustom.image  = image;
            }else {
              imageViewCell.imageViewCustom.image = [UIImage imageNamed:@"Singularity-squared_114.png"];
            }
//            NSAssert(imageViewCell.imageViewCustom != nil,@"imageViewCustom is nil!");
            break;
        }
        case kLargeIconSaveRow:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:saveIconsCell];
            SwitchCell* switchCell = (SwitchCell*)cell;
            switchCell.toggleSwitch.on = [[NSUserDefaults standardUserDefaults] boolForKey:@"saveToCamera"];
           NSAssert(switchCell.toggleSwitch != nil,@"toggleSwitch is nil!");
            break;
        }
        default:
            break;
            
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == kLogoSelectRow)
    {
       UIImagePickerController* imagePicker =  [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        [self presentModalViewController:imagePicker animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (IBAction)saveLargeIconSwitchAction:(id)sender {
    [[NSUserDefaults standardUserDefaults] setBool:((UISwitch*)sender).on forKey:@"saveToCamera"];
}

- (IBAction)dismissController:(id)sender {
    
    [self.parentViewController dismissModalViewControllerAnimated:YES];
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo

{
     DLog(@"didFinishPickingImage");
   ImageViewCell* imageViewCell = (ImageViewCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:kLogoSelectRow inSection:0]];
    imageViewCell.imageViewCustom.image = image;
    
    NSString* destinationPath = [[$ documentPath] stringByAppendingPathComponent:@"DefaultLogo.png"];
    [UIImagePNGRepresentation(image) writeToFile:destinationPath atomically:YES];

    
    [self dismissModalViewControllerAnimated:YES];
    
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
}
@end
