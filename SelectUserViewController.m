////
////  SelectUserViewController.m
////  TrackerFactoryNew
////
////  Created by Alexander Stone on 2/22/12.
////  Copyright (c) 2012 Pfizer. All rights reserved.
////
//
//#import "SelectUserViewController.h"
//#import "CoreDataManager.h"
//#import "TrackerUser.h"
//#import "UserPersonalDetails.h"
//
//#import <CoreImage/CoreImage.h>
//#import "AppColorsAndGraphics.h"
//
//#import <RestKit/RestKit.h>
//#import "RKRequestQueueExample.h"
//#import "NSString+MD5.h"
//
//#define kGravatarWebsite @"http://www.gravatar.com/avatar/"
//
//
//@interface SelectUserViewController ()
//
//-(void)setupButtons:(BOOL)animated;
//- (void)sendRequestForTrackerUserGravatar:(CoreDataButton*)coreDataButton;
//-(void)initRestKitClient;
//-(void)doTestFilter;
//
//-(UIImage*)doHueAdjustFilterWithBaseImageName:(NSString*)baseImageName hueAdjust:(CGFloat)hueAdjust;
//
//@end
//
//@implementation SelectUserViewController
//@synthesize hueAdjustSlider;
//@synthesize addUserButton;
//@synthesize userButtons;
//@synthesize caduceusImageView;
//
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
////- (void)loadView
////{
////    // If you create your views manually, you MUST override this method and use it to create your views.
////    // If you use Interface Builder to create your views, then you must NOT override this method.
////}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//	[self initRestKitClient];
//    [self interfaceWithColorFromPreferences];
//    
//    
//    //register to receive core data callbacks .
//  
//   
//    
//    //sort buttons in pre-determined tag order, this only needs to be done once
//    self.userButtons = [self.userButtons sortedArrayUsingComparator:^NSComparisonResult(id button1, id button2) {
//        if ([button1 tag] < [button2 tag]) return NSOrderedAscending;
//        else if ([button1 tag] > [button2 tag]) return NSOrderedDescending;
//        else return NSOrderedSame;
//    }];
//    
//}
//
//- (void)viewDidUnload
//{
//    //clear the queue
//    [[RKRequestQueue sharedQueue] cancelRequestsWithDelegate:self];
//    
//    [self setUserButtons:nil];
//    [self setAddUserButton:nil];
//    [self setCaduceusImageView:nil];
//    [self setHueAdjustSlider:nil];
//    [super viewDidUnload];
//    // Release any retained subviews of the main view.
//}
//
//-(void)viewWillAppear:(BOOL)animated
//{  self.fetchedResultsController =  self.coreDataManager.trackerUsersFetchedResultsController;
//    self.fetchedResultsController.delegate = self;
//    [self setupButtons:NO];
//    
//    
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
//    return (interfaceOrientation == UIInterfaceOrientationPortrait);
//}
//
//- (IBAction)userSelectedAction:(id)sender {
//    
//  
//    
//    //cause the fetched results controller to reset with the active user
//    self.coreDataManager.activeTrackerUser = (TrackerUser*)((CoreDataButton*)sender).managedObject;
//    [NSFetchedResultsController deleteCacheWithName: self.coreDataManager.bleedEventsFetchedResultsController.cacheName];
//     [NSFetchedResultsController deleteCacheWithName: self.coreDataManager.infusionEventFetchedResultsController.cacheName];
//    
//    //reset the core data controllers, causing them to be re-initialized with the selected user's data
//    self.coreDataManager.bleedEventsFetchedResultsController = nil;
//    self.coreDataManager.infusionEventFetchedResultsController = nil;
//   
//}
//
//- (IBAction)addUserAction:(id)sender {
//    
//    [self.coreDataManager insertAndReturnNewTrackerUser];
//}
//
//- (IBAction)emergencyHelpAction:(id)sender {
//}
//
//#pragma mark - 
//#pragma mark Core data customization
//
//- (NSFetchedResultsController *)fetchedResultsController
//{
//    
//    return self.coreDataManager.trackerUsersFetchedResultsController;
//    return nil;
//    
//}  
//
//
//
////sort users by id, for display purposes
//-(NSArray*)sortedUserArray
//{
//    //create a backup of the array before sorting to avoid messing up the order
//    NSArray* trackerUsers = [NSArray arrayWithArray:[self.coreDataManager.trackerUsersFetchedResultsController fetchedObjects]];
//        //sort users by id, for display purposes
//    NSArray* sortedUsers = [trackerUsers sortedArrayUsingComparator:^NSComparisonResult(id user1, id user2) {
//        if ([user1 user_id].intValue < [user2 user_id].intValue) return NSOrderedAscending;
//        else if ([user1 user_id].intValue > [user2 user_id].intValue) return NSOrderedDescending;
//        else return NSOrderedSame;
//    }];
//
//    return sortedUsers ;
//}
//
//-(void)setupButtonsHelper
//{
//    TrackerUser* trackerUser = nil;       
//    CoreDataButton* userButton = nil;        
//    NSArray* sortedUsers = [self sortedUserArray];   
//    
//    //first hide buttons
//    for(CoreDataButton* dataButton in userButtons)
//    {
//        dataButton.alpha =  0;
//    }
//
//    //special case, all users deleted, move add button to position #1
//    if(sortedUsers.count == 0)
//    {
//        UIButton* buttonForPosition = [userButtons objectAtIndex:0];
//        addUserButton.center = buttonForPosition.center;
//        addUserButton.alpha = 1;
//    }
//    
//    //then fade in active buttons
//    for(int i = 0; i<sortedUsers.count;i++)
//    {
//        trackerUser = [sortedUsers objectAtIndex:i];
//        
//        if(i<userButtons.count)
//        {
//            userButton = [userButtons objectAtIndex:i];
//            userButton.alpha = 1;
//            userButton.managedObject = trackerUser;
//            UserPersonalDetails* personalData = trackerUser.personalData;
//            NSString* firstName = personalData.first_name;
//            [userButton setTitle: firstName forState:UIControlStateNormal];
////            int userType = trackerUser.user_type.intValue;
////            [userButton setBackgroundImage:[UIImage imageNamed:(userType)?@"button_round_deep_purple.png":@"button_round_deep_blue.png"] forState:UIControlStateNormal];
//                       
//           
//            
//            if(trackerUser.personalData.image_local_file_location)
//            {
//                 [userButton setImage:[UIImage imageWithContentsOfFile:trackerUser.personalData.image_local_file_location] forState:UIControlStateNormal];
//                
//            }else {
////                 [userButton setImage:[UIImage imageNamed:(userType)?@"boy4.jpg":@"boy2.jpg"] forState:UIControlStateNormal];
//                 [self sendRequestForTrackerUserGravatar:userButton];
//            }
//            userButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
//           CGPoint center =  userButton.imageView.center;
//            userButton.imageView.frame = CGRectMake(0,0,25,25);
//            userButton.imageView.center = center;
//            
//        }
//        //keep adding the add button to the end.
//        //special case when full user capacity has been reached - hide the button
//        if(i+1 <userButtons.count && sortedUsers.count<6)
//        {
//            UIButton* buttonForPosition = [userButtons objectAtIndex:(i+1)];
//            addUserButton.center = buttonForPosition.center;
//            addUserButton.alpha = 1;
//        }else{
//            //if no space left, hide the button
//            addUserButton.alpha = 0;
//        }
//    }
//}
//
//
//-(void)setupButtons:(BOOL)animated
//{
//    [self hueChanged:nil];
//    
//    if(animated)
//    {
//    
//    [UIView animateWithDuration:1.6 animations:^{
//              [self setupButtonsHelper];
//    } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:0.8 animations:^{
//         
//          
//            
//        }];//end inner animation
//        
//    } ];
//    
//    }else{
//       
//        [self setupButtonsHelper];
//    }
//
//}
//
//#pragma mark -
//#pragma mark NSFetchedResultsControllerDelegate protocol
//
////these methods are required for new managed objects inserted to be visible after insertion
//- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
//       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
//      newIndexPath:(NSIndexPath *)newIndexPath
//{
////    NSLog(@"Changed object");
//    [self setupButtons:YES];
//}
//
//- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
//           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
//{
//    NSLog(@"Changed section");
//}
//
//-(void)doHueAdjustFilter
//{
//    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:@"caduceus-medicine-symbol-640.jpg"]];
//    CIFilter * controlsFilter = [CIFilter filterWithName:@"CIHueAdjust"];
//    [controlsFilter setValue:inputImage forKey:kCIInputImageKey];
//    //    [controlsFilter setValue:[NSNumber numberWithFloat: -2.0f] forKey:@"inputEV"];
//    [controlsFilter setValue:[NSNumber numberWithFloat:-0.9] forKey:@"inputAngle"];
//    
//    NSLog(@"%@",controlsFilter.attributes);
//    CIImage *displayImage = controlsFilter.outputImage;
//    UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
//    
//    CIContext *context = [CIContext contextWithOptions:nil];
//    if (displayImage == nil || finalImage == nil) {
//        // We did not get output image. Let's display the original image itself.
//        caduceusImageView.image = [UIImage imageNamed:@"caduceus-medicine-symbol-640.jpg"];
//    }else {
//        // We got output image. Display it.
//        caduceusImageView.image = [UIImage imageWithCGImage:[context createCGImage:displayImage fromRect:displayImage.extent]];
//    }
//    
//    
//
//
//}
//
//
//
//-(UIImage*)doHueAdjustFilterWithBaseImageName:(NSString*)baseImageName hueAdjust:(CGFloat)hueAdjust
//{
//    
//    CIImage *inputImage = [[CIImage alloc] initWithImage:[UIImage imageNamed:baseImageName]];
//    CIFilter * controlsFilter = [CIFilter filterWithName:@"CIHueAdjust"];
//    [controlsFilter setValue:inputImage forKey:kCIInputImageKey];
//    //    [controlsFilter setValue:[NSNumber numberWithFloat: -2.0f] forKey:@"inputEV"];
//    [controlsFilter setValue:[NSNumber numberWithFloat:hueAdjust] forKey:@"inputAngle"];
//    
//    NSLog(@"%@",controlsFilter.attributes);
//    CIImage *displayImage = controlsFilter.outputImage;
//    UIImage *finalImage = [UIImage imageWithCIImage:displayImage];
//    
//    CIContext *context = [CIContext contextWithOptions:nil];
//    if (displayImage == nil || finalImage == nil) {
//        // We did not get output image. Let's display the original image itself.
//       return  [UIImage imageNamed:baseImageName];
//    }else {
//        // We got output image. Display it.
//        return  [UIImage imageWithCGImage:[context createCGImage:displayImage fromRect:displayImage.extent]];
//    }
//
//    
//}
//
//-(void)doTestFilter
//{
//    
//    
//    
//   
//    
//    
//    
////    CIImage* inputImage = [CIImage imageWithCGImage:[[UIImage imageNamed:@"caduceus-medicine-symbol-640.jpg"]CGImage]];
////    
////    CIFilter *myFilter;
////    NSDictionary *myFilterAttributes;
////    myFilter = [CIFilter filterWithName:@"CIKaleidoscope"];
////    [myFilter setDefaults];
////    
////    myFilterAttributes = [myFilter attributes];
////    [myFilterAttributes setValue:inputImage forKey:@"inputImage"];
//////    [myFilterAttributes setValue:[NSNumber numberWithFloat:0.9] forKey:@"inputAngle"];
////    
////    //adjusts alpha to 0.5
//////    1 0 0 0
//////    0 1 0 0
//////    0 0 1 0
//////    0 0 0 0.5
//////    0 0 0 0
////    
////
////
////    CIContext *context = [CIContext contextWithOptions:nil];
////     CIImage *outputImage = [myFilter valueForKey:@"outputImage"];
////    
//////    [outputImage drawAtPoint:NSZeroPoint fromRect:NSRectFromCGRect([outputImage extent]) operation:NSCompositeCopy fraction:1.0];
////    
////      CIImage *ciimage = [myFilter outputImage];
////    CGImageRef cgimg = [context createCGImage:ciimage fromRect:[ciimage extent]];
////    UIImage *uimage = [UIImage imageWithCGImage:cgimg scale:1.0f orientation:UIImageOrientationUp];
////    [caduceusImageView setImage:uimage];
////    CGImageRelease(cgimg);
//
//}
//-(void)interfaceWithColorFromPreferences
//{
//    
////    [self doHueAdjustFilter]; 
//   
////    caduceusImageView.image = image;
//}
//
//- (IBAction)hueChanged:(id)sender {
//    
//   UIImage* adjustedImage = [self doHueAdjustFilterWithBaseImageName:@"caduceus-medicine-symbol-640.jpg" hueAdjust:hueAdjustSlider.value];
//    self.caduceusImageView.image = adjustedImage;
//    
//    UIImage* adjustedButton1 = [self doHueAdjustFilterWithBaseImageName:@"button_round_deep_blue.png" hueAdjust:hueAdjustSlider.value];
//    
//    UIImage* adjustedButton2 = [self doHueAdjustFilterWithBaseImageName:@"button_round_deep_blue.png" hueAdjust:hueAdjustSlider.value];
//    for(CoreDataButton* dataButton in userButtons)
//    {
//       TrackerUser* user = (TrackerUser*)((CoreDataButton*)dataButton).managedObject;
//        if(user.user_type.intValue ==0)
//        {
//            [dataButton setBackgroundImage:adjustedButton1 forState:UIControlStateNormal];
//        }else{
//            [dataButton setBackgroundImage:adjustedButton2 forState:UIControlStateNormal];
//        }
//    }
//    
//    
//}
//
//
//-(void)initRestKitClient
//{
//    RKClient* client = [RKClient clientWithBaseURL:kGravatarWebsite];
//    [RKClient setSharedClient:client];
//    
//    [RKRequestQueue sharedQueue].delegate = self;
//    [RKRequestQueue sharedQueue].showsNetworkActivityIndicatorWhenBusy = YES;
//    
//    // Ask RestKit to spin the network activity indicator for us
//}
//
//-(NSString*)gravatarMD5HashWithUserID:(int)userID
//{
//    
//    NSString *hashedUserID = [[NSString stringWithFormat:@"%i", userID] MD5];
//    //    NSString *gravatarURLString = [NSString stringWithFormat:@"%@?d=identicon", hashedUserID];
//    return hashedUserID;
//}
//
//- (void)sendRequestForTrackerUserGravatar:(CoreDataButton*)coreDataButton {
//    /**
//     * Ask RKClient to load us some data. This causes an RKRequest object to be created
//     * transparently pushed onto the RKRequestQueue sharedQueue instance
//     */
//   
//    //single request for a resource, includes a dictionary of parameters to be appended to the URL
//    NSMutableDictionary* paramsDictionary = [[NSMutableDictionary alloc] init];
//    [paramsDictionary setValue:@"identicon" forKey:@"d"];
//    
//    
//
//    TrackerUser* trackerUser = (TrackerUser*)coreDataButton.managedObject;
//
//    RKRequest* request = [[RKClient sharedClient] get:[self gravatarMD5HashWithUserID: trackerUser.user_id.intValue] queryParams:paramsDictionary delegate:self];
//    request.delegate = self;
//    request.userData = coreDataButton;
////    request.cachePolicy = RKRequestCachePolicyEnabled;
//    
//    
//    
//    
////    NSString* md5Hash = [self gravatarMD5HashWithUserID:trackerUser.user_id.intValue];
////    NSString* urlString = [NSString stringWithFormat:@"%@%@?d=identicon",kGravatarWebsite,md5Hash];
////    RKRequest* request = [[RKRequest alloc] initWithURL:[NSURL URLWithString:urlString] delegate:self];
////    request.userData = coreDataButton;
////    request.delegate = self;   
////    request.cachePolicy = RKRequestCachePolicyEnabled;
//////    [[RKRequestQueue sharedQueue] addRequest:request];
////    
////    [request prepareURLRequest];
////    [request send];
//    
//    }
//-(void)processResponse:(RKResponse*)response
//{
//    NSLog(@"%@", response.body);
//    NSLog(@"content type: %@",response.contentType);
//    if([response.contentType isEqualToString:@"image/png"])
//    {
//        UIImage* image = [UIImage imageWithData:response.body];
//        CoreDataButton* dataButton = response.request.userData;
//        [dataButton setImage:image forState:UIControlStateNormal];
//        
//        NSString* filepath  = [CoreDataManager saveImage:image ToFolder:self.coreDataManager.userAvatarFolderPath];
//        
//        if(filepath)
//        {
//            TrackerUser* user = (TrackerUser*)((CoreDataButton*)dataButton).managedObject;
//            user.personalData.image_local_file_location = filepath;
//        }
//        
//    }
//    
//    
//}
//
////request callback
//- (void)didFinishLoad:(RKResponse*)response
//{
//    [self processResponse:response];
//}
//#pragma mark -
//#pragma mark RKRequestQueue delegate
//
//-(void)requestQueue:(RKRequestQueue *)queue didLoadResponse:(RKResponse *)response
//{
//    [self processResponse:response];
//}
//
//- (void)requestQueue:(RKRequestQueue *)queue didSendRequest:(RKRequest *)request {
//    NSLog(@"%@",[NSString stringWithFormat:@"RKRequestQueue %@ sharedQueue is current loading %d of %d requests", 
//                         queue, [queue loadingCount], [queue count]]);
//}
//
//- (void)requestQueueDidBeginLoading:(RKRequestQueue *)queue {
//    NSLog(@"%@",[NSString stringWithFormat:@"Queue %@ Began Loading...", queue]);
//}
//
//- (void)requestQueueDidFinishLoading:(RKRequestQueue *)queue {
//    NSLog(@"%@", [NSString stringWithFormat:@"Queue %@ Finished Loading...", queue]);
//}
//
//
//@end
