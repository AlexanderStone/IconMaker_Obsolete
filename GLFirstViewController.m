//
//  GLFirstViewController.m
//  glamourAR
//
//  Created by Mahmood1 on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "GLFirstViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ColorSpaceUtilities.h"
#import "AppColors.h"
#import "GLAppDelegate.h"
#import "ScreenCapture.h"
#import <ImageIO/ImageIO.h>
#import "Appirater.h"
#import "TableViewController.h"
#import "TableViewCell.h"
#import "PreviewViewController.h"
#import "HelpOverlay.h"

#import "IconFile.h"
#import "IconFile+LocalFileManagement.h"
#import "Label.h"
#import "GMGridView.h"

#import "JSONKit.h"


#import "AttributedView.h"
#import "AttributedImageView.h"
#import "AttributedWebView.h"
#import "AttributedTextField.h"
#import "AttributedTextView.h"
#import "ContainerScrollView.h"
#import "DragAndDropLabel.h"

#import "ScalableLayer.h"
#import "UIImageExtensions.h"
#import "AppGraphics.h"
#import "DragAndDropLabel.h"
#import "iPhoneModel.h"
#import "ShadowLabel.h"

#import "DropboxConfigAPI.h"
#import "ConciseKit.h"
#import "UIColor-HSVAdditions.h"

#define NUMBER_OF_ITEMS (IS_IPAD? 19: 7)
#define NUMBER_OF_VISIBLE_ITEMS 7
#define ITEM_SPACING 120
#define INCLUDE_PLACEHOLDERS YES



BOOL isPad() {
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

@interface GLFirstViewController () 
-(void)resetLayerOrder;

@end


@implementation GLFirstViewController
@synthesize selectImageLabel;
@synthesize ornamentView;
@synthesize resetButton;
@synthesize gradientBackground;
@synthesize gradientControl;
@synthesize topControlPanel;
@synthesize controlPanel;
@synthesize gradientViewController;

@synthesize bottomControlPanel;
@synthesize frameColorLabel;
@synthesize alphaChannelLabel;
@synthesize fontPickerView = __fontPickerView;
@synthesize clearFontButton;
@synthesize fontAlignmentButton;
@synthesize fontColorButton;
@synthesize changeFontButton;
@synthesize fontSizeButton;
@synthesize activeControl;
@synthesize glossControl;

@synthesize genericControl;
@synthesize photoControl;
@synthesize fontControl;
@synthesize frameControl;
@synthesize logoView;
@synthesize maskPanel;
@synthesize layersPanel;
@synthesize toolPanel;
@synthesize iconFrame256;
@synthesize iPadHDIcon;
@synthesize iPadIcon;
@synthesize placeholderIcon256;
@synthesize placeholderIcon144;
@synthesize placeholderIcon114;
@synthesize placeholderImageViews;
@synthesize appStoreEntryPanel;
@synthesize springBoardIconpanel;
@synthesize iconPanel;
@synthesize iconsForDisplay;
@synthesize appTypeLabel;
@synthesize iconView;
@synthesize glossEffects;
@synthesize frames;
@synthesize buttonLabels;
@synthesize cameraPanel;
@synthesize selectionSlider;
@synthesize appStoreListingIcon;
@synthesize iPhoneHomeScreenIcon1;
@synthesize iPhoneHomeScreenLabel1;
@synthesize springBoardTextField;
@synthesize companyNameLabel;
@synthesize productNameAppStoreLabel;
@synthesize homeScreenLabel1;
@synthesize homeScreenLabel2;
@synthesize homeScreenLabel3;
@synthesize homeScreenLabel4;
@synthesize glossEffect;
@synthesize glossSwitch;
@synthesize modeButton2;
@synthesize cameraModeButton2;
@synthesize startStopButton2;
@synthesize screenshotButton2;
@synthesize arScreenshotButton2;
@synthesize selectImageButton;
@synthesize facebookButton;
@synthesize helpButton;
@synthesize loadingButton;
@synthesize preferencesButton;
@synthesize transparencyLabel;
@synthesize hueLabel;
@synthesize activityIndicator;
@synthesize rotationRecognizer;
@synthesize startStopButton;
@synthesize timerArrow;
@synthesize saveCompositeButton;

@synthesize modeButton;
@synthesize screenshotButton;
@synthesize cameraModeButton;
@synthesize backButton;
@synthesize forwardButton;
@synthesize containerView;
@synthesize hueSlider;
@synthesize scrollView;
@synthesize pinchGestureRecognizer;
@synthesize arOverlayView;
@synthesize webView;
@synthesize transparencySlider;

@synthesize stillImage;
@synthesize stillImageOutput;

@synthesize frameName;
@synthesize imagePicker;
@synthesize tableView;
@synthesize frameTableView;
@synthesize tapGestureRecognizer;
@synthesize iconTypeTextField;
@synthesize longPressGestureRecognizer;

@synthesize draggingIconLabel;
@synthesize rotatingIconLabel;
@synthesize interfaceLayoutDictionary;
@synthesize iconFile;
@synthesize carouselController;
@synthesize layersController;
@synthesize editableViewLayers;
@synthesize scrollVIewCenter;
@synthesize activeView;

@synthesize selectedCell;
@synthesize effectButton;
@synthesize glossScroller;
@synthesize webViewControl;
@synthesize enableDisableWebViewSwitch;
@synthesize fontNames;
@synthesize qrGenerator = __qrGenerator;

@synthesize dateFormatter;
@synthesize frameBoundary;
@synthesize rotateButton;
@synthesize reflectButton;
@synthesize doTrashIconOnClose;

//@synthesize sampleBuffer;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self showReorderLayerAlert];
	// Do any additional setup after loading the view, typically from a nib.
    
//    NSURL* url =  [NSURL URLWithString:@"http://www.youtube.com/watch?v=U7dOBeyr5bk"];
    
    
    
    NSString* defaultLogoPath = [[$ documentPath] stringByAppendingPathComponent:@"DefaultLogo.png"];
    if([[NSFileManager defaultManager]fileExistsAtPath:defaultLogoPath])
    {
        UIImage* image = [UIImage imageWithData:[NSData dataWithContentsOfFile:defaultLogoPath]];
        self.logoView.image  = image;
    }else {
        self.logoView.image = [UIImage imageNamed:@"Singularity-squared_114.png"];
    }
   

       
    self.dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    
    self.fontNames =[self generateFontNames];
    previewButton = self.navigationItem.rightBarButtonItem;
    
    self.scrollView.contentSize = CGSizeMake( 1800,1800);
    [scrollView setContentOffset: scrollVIewCenter.center animated: YES];
    
    changeFontButton.title = iconTypeTextField.font.fontName;
    fontSizeButton.title = [NSString stringWithFormat:@".0f",iconTypeTextField.font.pointSize];
    
    textAlignment=iconTypeTextField.textAlignment;
    
    editableViewLayers =[[NSMutableArray alloc] initWithCapacity:10];

    
    //add objects here in reverse order, so the latest one ends up on top
    

    //add objects in the order they will be visible, top to bottom
    
    self.gradientViewController = [[GradientViewController alloc] initWithNibName:@"GradientViewController" bundle:nil];
    self.gradientViewController.parentContainerController = self;
    
    //add and remove view, causing the nib to load
    [self.view addSubview:gradientViewController.view];
    [gradientViewController.view removeFromSuperview] ;
    
    
    self.gradientControl= self.gradientViewController.gradientControl;
    self.gradientControl.alpha = 0;
    [self.bottomControlPanel addSubview:self.gradientControl];

    NSMutableArray* tempSetupArray =[self setupLayers];

  
    activeControl = photoControl;

    
    ContainerScrollView* tempScrollView = nil;
    
    AttributedView* attributedView  = nil;
     
    CGRect scrollViewFrame = scrollView.frame;
    

    CGPoint contentOffset;
    //add objects to the view in reverse order, so the first object is on top
    for(int i = tempSetupArray.count-1;i>=0;i--)
    {
        UIView* dummyForZooming = [[UIView alloc]initWithFrame:CGRectMake(0,0,1800,1800)];
        attributedView = [tempSetupArray objectAtIndex:i];
        
        contentOffset = CGPointMake(900- attributedView.center.x+scrollView.frame.origin.x,900- attributedView.center.y+scrollView.frame.origin.y );
//        contentOffset = CGPointMake(900- attributedView.center.x,900- attributedView.center.y );
        tempScrollView = [[ContainerScrollView alloc] initWithFrame:scrollViewFrame];
        //safely re-add weak reference

        [attributedView removeFromSuperview];
        [tempScrollView addSubview:dummyForZooming];
        [dummyForZooming addSubview:attributedView];
//        [tempScrollView addSubview:attributedView];
        
        tempScrollView.dummyZoomView = dummyForZooming;
        
        //add scrollview
        [self.view insertSubview:tempScrollView belowSubview:layersPanel];
        
       
        //leave the frame unmovable
        
        tempScrollView.contentSize = scrollView.contentSize;
        tempScrollView.contentOffset = contentOffset;
        attributedView.center = scrollVIewCenter.center;
        
       
        attributedView.center = scrollVIewCenter.frame.origin;
        
        dummyForZooming.center = scrollVIewCenter.frame.origin;
        
         tempScrollView.userInteractionEnabled = [attributedView isEqual:arOverlayView]?YES:NO;
        if([attributedView isEqual:arOverlayView])
        {
            if(iconFile ==nil)
            {
                //remember that the first active view is camera
                activeView = tempScrollView;
            }
        }
//        {
//            tempScrollView.contentSize = scrollView.contentSize;
//            tempScrollView.contentOffset = contentOffset;
//            attributedView.center = scrollVIewCenter.center;
//            dummyForZooming.center = scrollVIewCenter.center;
//            //remember that the selected view is camera
//            
//            
//        }else{
//            //activate the camera as first view
//            activeView = tempScrollView;
//        }
        
        [tempScrollView.pinchGestureRecognizer requireGestureRecognizerToFail:rotationRecognizer];
        tempScrollView.pinchGestureRecognizer.delegate = self;
        
        
        NSLog(@"attributed center: x:%.0f, y:%.0f",attributedView.center.x,attributedView.center.y);
        NSLog(@"content size: w:%.0f, h:%.0f",tempScrollView.contentSize.width,tempScrollView.contentSize .height);

        [editableViewLayers addObject:tempScrollView];
        tempScrollView.attributedView = attributedView;
        tempScrollView.maximumZoomScale = 4.0;
        tempScrollView.minimumZoomScale = 0.25;
//        
        tempScrollView.delegate = self;
        
    }
    
////reverse the array to align layer order with display order
    NSMutableArray *tmp = [[NSMutableArray alloc] init];
    
    for(int x=[editableViewLayers count] - 1;x>=0; x--){
        [tmp addObject:[editableViewLayers objectAtIndex:x]];
    }
    self.editableViewLayers = tmp;
    
    
    //prepare layer attributes
   for(ContainerScrollView* container in self.editableViewLayers)
   {
       if(container.attributedView.attributes ==nil)
       {
           container.attributedView.attributes =[[NSMutableDictionary alloc] initWithCapacity:6];
       }
   }

    [self setupAttributesForLayers];
    [self setupDefaultLayerParameters];//for reset purposes
    
    [self setupGradient];
    [self setupBordersAndGradients];
    
    self.imagePicker = [[UIImagePickerController alloc] init];
	self.imagePicker.delegate = self;	
    
    useFrontCamera = NO;
    
    [self loadInitialFrame];
   
   self.iPhoneHomeScreenLabel1.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    
    
//    self.scrollView.contentSize = CGSizeMake( arOverlayView.frame.size.width*3, arOverlayView.frame.size.height*3);
//    self.scrollView.contentSize = CGSizeMake( 4096,4096);
  
    
    
//    self.scrollView.maximumZoomScale = 4.0;
//    self.scrollView.minimumZoomScale = 0.25;
    
//    self.scrollView.contentOffset = arOverlayView.frame.origin;
    
    NSString* searchEnginePref = nil;
    searchEnginePref = [[NSUserDefaults standardUserDefaults] stringForKey:@"searchEngine"];
    
    if(searchEnginePref ==nil ||searchEnginePref.length ==0){
        

        searchEnginePref = (!isPad())?@"http://www.google.com":@"http://www.bing.com";
        [[NSUserDefaults standardUserDefaults] setValue:searchEnginePref forKey:@"searchEngine"];
        
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"saveToCamera"];
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"sendEmail"];
        [[NSUserDefaults standardUserDefaults] setValue:@"Your  Company Name" forKey:@"companyName"];
    }
    
    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:searchEnginePref]]];
    
     [arOverlayView setTransform:CGAffineTransformScale([arOverlayView transform], (CGFloat)0.667, (CGFloat)0.667)];
//    [webView setTransform:CGAffineTransformScale([webView transform], (CGFloat)0.667, (CGFloat)0.667)];
    

    webView.center = arOverlayView.center;
    [self.view addGestureRecognizer:rotationRecognizer];
    
    //init labels
    transparencyLabel.text = [NSString stringWithFormat:@"%.2f",transparencySlider.value];
     hueLabel.text = [NSString stringWithFormat:@"%.2f",hueSlider.value];

    
    pulseScroller = [[TableViewController alloc] initWithNibName:@"PulseViewController" bundle:nil];
    pulseScroller.tableView = self.frameTableView;
    [self setupFrameContent];
    
    frameTableView.delegate = pulseScroller;
    frameTableView.dataSource = pulseScroller;
    pulseScroller.horizontalTableDelegate = self;
    
    [frameTableView reloadData];
    
    //gloss effects
    glossScroller = [[TableViewController alloc] initWithNibName:@"PulseViewController" bundle:nil];
    glossScroller.tableView = self.glossControl;
     [glossScroller setupForContent:kContentTypeGloss];
    
    glossControl.delegate = glossScroller;
    glossControl.dataSource = glossScroller;
    glossScroller.horizontalTableDelegate = self;
    
    [glossControl reloadData];
    

    [self scanForCameraDevices];
    
    
//    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapFrom:)];
//    [self.view addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.cancelsTouchesInView = NO;
    tapGestureRecognizer.numberOfTapsRequired = 1;
    
    //create rounded corners for icon previews
    for(UIImageView* v in iconsForDisplay)
    {
        [v.layer setCornerRadius:9.0f];
        [v.layer setMasksToBounds:YES];
    }
    
    [iconView.layer setCornerRadius:45.0];
    [iconView.layer setMasksToBounds:YES];
    
    [iPadHDIcon.layer setCornerRadius:11.0];
    [iPadHDIcon.layer setMasksToBounds:YES];
    
    
    [placeholderIcon256.layer setCornerRadius:45];
    [placeholderIcon256.layer setMasksToBounds:YES];

    [placeholderIcon144.layer setCornerRadius:13];
    [placeholderIcon144.layer setMasksToBounds:YES];

    [placeholderIcon114.layer setCornerRadius:11];
    [placeholderIcon114.layer setMasksToBounds:YES];


    
    currentViewSource = VIEWSOURCE_UIIMAGEVIEW ;
    
 
    
   
//    
//    corner radius for the 512x512 = 90 (iTunesArtwork)
//        corner radius for the 114x114 = 18 (iPhone/iPod touch (Retina))
//            corner radius for the 72x72 = 11 (iPad)
//                corner radius for the 57x57 = 9 (iPhone/iPod touch)
//    

    //Finish view loading. This sets up the data source for the grid view and must be done before gridview setup
    if(self.iconFile == nil)
    {
        self.doTrashIconOnClose = YES;//if the user closes the app, delete this icon
        iconFile = [IconFile object];
        iconFile.labels = [Label object];
        iconFile.appStoreName = @"App Store Name";
        iconFile.springBoardName = @"Icon Name";
        iconFile.companyName = [[NSUserDefaults standardUserDefaults] valueForKey:@"companyName"];
        iconFile.localImageFolder = [kLocalDataFolder stringByAppendingPathComponent:iconFile.springBoardName];
        iconFile.uuid=[IconFile createUUID];

    }else
    {
        [self interfaceWithIconFile:iconFile];
    }
     iconFile.createDate = [NSDate date];
    [self resetLayerOrder];
    //position the transparency slider
    
    
    layersController = [[Demo2ViewController alloc] init];
    [self.view addSubview:layersController.view];
    [layersController.view removeFromSuperview];
    
    [self.view addSubview:layersController.gridView1];
    layersController.gridView1.center = layersPanel.center;
    layersController.gridView1.showsVerticalScrollIndicator= NO;
     layersController.gridView1.showsHorizontalScrollIndicator= NO;
    
    layersController.gridView1.actionDelegate = self;
    layersController.gridView1.sortingDelegate = self;
    layersController.gridView1.dataSource = self;
    //reset active view
    [self GMGridView:layersController.gridView1 didTapOnItemAtIndex:[self.editableViewLayers indexOfObject:activeView]];

    
    self.gradientViewController.topColor = gradientBackground.topGradientColor ;
    self.gradientViewController.bottomColor = gradientBackground.bottomGradientColor;
    self.gradientViewController.activeGradientView = gradientBackground;
    [self.gradientViewController setupGradient];
    
    //resetting hue changes the frame's position
    [self hueChanged:self.hueSlider];
    [self transparencyChanged:nil];
    
    bool isReflected =  self.iconFrame256.scalableLayer.isReflected.boolValue;
    float internalRotation = self.iconFrame256.scalableLayer.internalRotation.floatValue;
    float reflectionParameter = isReflected?-1.0:1.0;
    self.iconFrame256.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(internalRotation),reflectionParameter, 1.0);
    
    
    //fix the navbar hovering over view issue
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [self setTransparencySlider:nil];
    [self setArOverlayView:nil];
    [self setPinchGestureRecognizer:nil];
    [self setScrollView:nil];
    [self setContainerView:nil];
    [self setHueSlider:nil];
    [self setBackButton:nil];
    [self setForwardButton:nil];
    [self setModeButton:nil];
    [self setScreenshotButton:nil];
    [self setCameraModeButton:nil];
    [self setStartStopButton:nil];
    [self setTimerArrow:nil];
    [self setSaveCompositeButton:nil];
    [self setHelpButton:nil];
    [self setFacebookButton:nil];
    [self setPreferencesButton:nil];
    [self setTransparencyLabel:nil];
    [self setHueLabel:nil];
    [self setActivityIndicator:nil];
    [self setRotationRecognizer:nil];
    [self setToolPanel:nil];
    [self setModeButton2:nil];
    [self setCameraModeButton2:nil];
    [self setStartStopButton2:nil];
    [self setScreenshotButton2:nil];
    [self setArScreenshotButton2:nil];
    [self setButtonLabels:nil];
    [self setCameraPanel:nil];
    [self setSelectionSlider:nil];
    [self setAppStoreListingIcon:nil];
    [self setIPhoneHomeScreenIcon1:nil];
    [self setIPhoneHomeScreenLabel1:nil];
    [self setCompanyNameLabel:nil];
    [self setProductNameAppStoreLabel:nil];
    [self setHomeScreenLabel1:nil];
    [self setHomeScreenLabel2:nil];
    [self setGlossEffect:nil];
    [self setGlossSwitch:nil];
    [self setGlossEffects:nil];
    [self setSpringBoardTextField:nil];
    [self setFrames:nil];
    [self setAppTypeLabel:nil];
    [self setIconView:nil];
    [self setAppStoreEntryPanel:nil];
    [self setSpringBoardIconpanel:nil];
    [self setIconPanel:nil];
    [self setHomeScreenLabel3:nil];
    [self setHomeScreenLabel4:nil];
    [self setIconsForDisplay:nil];
    [self setTableView:nil];
    [self setFrameTableView:nil];
    [self setTapGestureRecognizer:nil];
    [self setIconTypeTextField:nil];
    [self setLongPressGestureRecognizer:nil];
    [self setIconFrame256:nil];
    [self setIPadHDIcon:nil];
    [self setIPadIcon:nil];
    [self setPlaceholderIcon256:nil];
    [self setPlaceholderIcon144:nil];
    [self setPlaceholderImageViews:nil];
    [self setPlaceholderIcon114:nil];
    [self setLayersPanel:nil];
    [self setLogoView:nil];
    [self setScrollVIewCenter:nil];
    [self setEffectButton:nil];
    [self setPhotoControl:nil];
    [self setFrameControl:nil];
    [self setFontControl:nil];
    [self setGenericControl:nil];
    [self setGlossControl:nil];
    [self setWebViewControl:nil];
 
    [self setEnableDisableWebViewSwitch:nil];
    [self setChangeFontButton:nil];
    [self setFontSizeButton:nil];
    [self setFontColorButton:nil];
    [self setFontAlignmentButton:nil];
    [self setClearFontButton:nil];
    [self setFontPickerView:nil];
    [self setGradientBackground:nil];
    [self setGradientControl:nil];
    [self setBottomControlPanel:nil];
    [self setFrameColorLabel:nil];
    [self setAlphaChannelLabel:nil];
    [self setResetButton:nil];
    [self setOrnamentView:nil];
    [self setFrameBoundary:nil];
    [self setSelectImageButton:nil];
    [self setSelectImageLabel:nil];
    [self setTopControlPanel:nil];
    [self setControlPanel:nil];
    [self setLoadingButton:nil];
    [self setToolPanel:nil];
    [self setMaskPanel:nil];
    [self setRotateButton:nil];
    [self setReflectButton:nil];
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
    
    DLog(@"Frame control: x%.0f y%.0f",self.frameControl.center.x,self.frameControl.center.y );
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:animated];
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
//    self.scrollView.zoomScale = 1;
//     self.scrollView.contentOffset = arOverlayView.frame.origin;
//    // Return YES for supported orientations
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        
//        if(interfaceOrientation == UIInterfaceOrientationLandscapeRight)
//        {
////           for(CALayer* layer in  arOverlayView.layer.sublayers) 
////           {
////               layer.transform = CATransform3DMakeRotation(90, 1,0, 0);
////           }
//        }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft)
//        {
////            for(CALayer* layer in  arOverlayView.layer.sublayers) 
////            {
////                layer.transform = CATransform3DMakeRotation(-90, 1,0, 0);
////            }
//        }else{
////            for(CALayer* layer in  arOverlayView.layer.sublayers) 
////            {
////                layer.transform = CATransform3DIdentity;
////            } 
//        } 
//        
//        
//        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
//    } else {
//        return YES;
//    }
    
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
    
}

- (IBAction)transparencyChanged:(id)sender {
    
    activeView.attributedView.alpha = transparencySlider.value;
    
     transparencyLabel.text = [NSString stringWithFormat:@"%.2f",transparencySlider.value];
}


- (void)addStillImageOutput
{
    [self setStillImageOutput:[[AVCaptureStillImageOutput alloc] init]];
    
    NSDictionary *outputSettings = [[NSDictionary alloc] initWithObjectsAndKeys:AVVideoCodecJPEG,AVVideoCodecKey,nil];
    [[self stillImageOutput] setOutputSettings:outputSettings];
    
    AVCaptureConnection *videoConnection = nil;
    for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
                videoConnection = connection;
                break;
            }
        }
        if (videoConnection) {
            break;
        }
    }
    
    [captureSession addOutput:[self stillImageOutput]];
}


- (IBAction)buttonAction:(id)sender {
    
    UIButton* button = nil;
    
    if(running)
    {
        running = NO;
        [captureSession stopRunning];
        [animationTimer invalidate];
        
      
        [startStopButton setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
        [startStopButton2 setImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
        
        
        
        //        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
        [self.tabBarController.tabBar setHidden:NO];
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
        //clear sublayers
        
        for (CALayer* layer in arOverlayView.layer.sublayers)
        {
            [layer removeFromSuperlayer];
        }
//        [arOverlayView setImage:nil];
        
    }else{
        running = YES;
        //        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
        [self.tabBarController.tabBar setHidden:YES]; 
        
        
        [startStopButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
         [startStopButton2 setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
        [ UIView animateWithDuration:0.8 animations:^{
            
//            modeButton.center = CGPointMake(modeButton.center.x, modeButton.center.y+50);
//            screenshotButton.center = CGPointMake(screenshotButton.center.x, screenshotButton.center.y+50);
//            cameraModeButton.center = CGPointMake(cameraModeButton.center.x, cameraModeButton.center.y+50);
//            startStopButton.center = CGPointMake(startStopButton.center.x, startStopButton.center.y+50);
//            //           arOverlayView.alpha = 0;
            
        } ];
        
        [self activateCameraFeed];
        
    }
}


//- (IBAction)buttonAction:(id)sender {
//    
//    UIButton* button = nil;
//    if([sender isKindOfClass:[UIButton class]])
//    {
//        button = sender;
//    }
//    
//    if(running)
//    {
//        running = NO;
//        [captureSession stopRunning];
//        [animationTimer invalidate];
//        
//        if(button)
//        {
//            [button setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
//        }
//        
//        
//        //        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
//        [self.tabBarController.tabBar setHidden:NO];
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        //clear sublayers
//        
//        for (CALayer* layer in arOverlayView.layer.sublayers)
//        {
//            [layer removeFromSuperlayer];
//        }
//        
//    }else{
//        running = YES;
//        //        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        [self.tabBarController.tabBar setHidden:YES]; 
//        
//        if(button)
//        {
//            [button setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
//        }
//        captureSession = [[AVCaptureSession alloc] init];
//        AVCaptureDevice *audioCaptureDevice = nil;
//        
//        //           AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        
//        NSArray *videoDevices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
//        
//        for (AVCaptureDevice *device in videoDevices) {
//            
//            if(useFrontCamera){
//                if (device.position == AVCaptureDevicePositionFront) {
//                    //FRONT-FACING CAMERA EXISTS
//                    audioCaptureDevice = device;
//                    break;
//                }
//            }else{
//                if (device.position == AVCaptureDevicePositionBack) {
//                    //Rear-FACING CAMERA EXISTS
//                    audioCaptureDevice = device;
//                    break;
//                }
//            }
//            
//        }
//        
//        //           AVCaptureDevice *audioCaptureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//        
//        NSError *error = nil;
//        AVCaptureDeviceInput *audioInput = [AVCaptureDeviceInput deviceInputWithDevice:audioCaptureDevice error:&error];
//        
//        
//        
//        if (audioInput) {
//            [captureSession addInput:audioInput];
//        }
//        else {
//            // Handle the failure.
//        }
//        
//        [self addStillImageOutput];
//        
//        previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
//        
//        
//        
//        UIView *aView = arOverlayView;
//        previewLayer.frame =CGRectMake(0,0, arOverlayView.frame.size.width,arOverlayView.frame.size.height); // Assume you want the preview layer to fill the view.
//        
//        [aView.layer addSublayer:previewLayer];
//        [captureSession startRunning];
//        
//    }
//}

- (IBAction)handlePinch:(id)sender {
    
   
//    switch (rotationGestureRecognizer.state) {
//        case  UIGestureRecognizerStateBegan:
//            NSLog(@"UIGestureRecognizerStateBegan");
//            return;
//            break;
//        case  UIGestureRecognizerStateChanged:
//            NSLog(@"UIGestureRecognizerStateChanged");
//            return;
//            break;
//            
//        case  UIGestureRecognizerStateRecognized:
//            NSLog(@"UIGestureRecognizerStateRecognized");
//            return;
//            break;
//        case  UIGestureRecognizerStateFailed:
//            NSLog(@"UIGestureRecognizerStateFailed");
//            
//            break;
//        default:
//            
//            break;
//    }
   
    if(pinchGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        
        activeView.frame = CGRectMake(activeView.frame.origin.x, activeView.frame.origin.y, activeView.frame.size.width*pinchGestureRecognizer.scale, activeView.frame.size.height*pinchGestureRecognizer.scale);    
    }
    

}


-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView_
{
    
    if([scrollView_ isKindOfClass:[ContainerScrollView class]])
    {
        ContainerScrollView* containerScrollView = (ContainerScrollView*)scrollView_;
        
        return containerScrollView.dummyZoomView;
    }
    
    return self.containerView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView_{
    
    DLog(@"zoom: %.2f",scrollView_.zoomScale);
    
   
//    if(scrollView.zoomScale<1.0)
//    {
//        CGRect f = self.tableView.frame;
//        
//        self.tableView.frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, 700);
//    }else{
//        CGRect f = self.tableView.frame;
//        
//        self.tableView.frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, 350);
//    }
//    
}


- (IBAction)enableDisableOverlayInteraction:(id)sender {
    
 
    
    UIView* temp = nil;
    CGRect overlayFrame = self.arOverlayView.frame;
    CGRect webviewFrame = self.webView.frame;
    
    webView.userInteractionEnabled = !webView.userInteractionEnabled;
    
    //overlay view will be on top
    if(!webView.userInteractionEnabled)
    {
        temp = arOverlayView;
        [arOverlayView removeFromSuperview];
        [containerView insertSubview:temp aboveSubview:self.webView];
        temp.frame = overlayFrame;
        
//        self.webView.userInteractionEnabled = NO;
        
       [ UIView animateWithDuration:0.8 animations:^{
           
           selectionSlider.center = CGPointMake(selectionSlider.center.x+50, selectionSlider.center.y);
           
               [modeButton setImage:[UIImage imageNamed:@"world"] forState:UIControlStateNormal];
               [modeButton2 setImage:[UIImage imageNamed:@"world"] forState:UIControlStateNormal];
           cameraModeButton.alpha = 1;
           toolPanel.alpha = 0;
           backButton.alpha = 0;
           forwardButton.alpha = 0;
           facebookButton.alpha = 0;
           helpButton.alpha = 0;
           preferencesButton.alpha = 0;
           webView.alpha = 0;
         self.navigationItem.title = @"Source: Camera";
//           arOverlayView.alpha = 0;
           
        } ];
        
       
        
        
    }else{
        //scroll view is below
        temp = webView;
        [webView removeFromSuperview];
        [self.containerView insertSubview:temp aboveSubview:self.arOverlayView];
        temp.frame = webviewFrame;
            
        
//        self.webView.userInteractionEnabled = YES;
        
        [ UIView animateWithDuration:0.8 animations:^{
            
                [modeButton setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
                [modeButton2 setImage:[UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
            
            selectionSlider.center = CGPointMake(selectionSlider.center.x-50, selectionSlider.center.y);
            
            cameraModeButton.alpha = 0;
            toolPanel.alpha = 1;
            backButton.alpha = 1;
            forwardButton.alpha = 1;
            facebookButton.alpha = 1;
            helpButton.alpha = 1;
            preferencesButton.alpha = 1;
            webView.alpha = 1;
           self.navigationItem.title = @"Source: Web";
//            arOverlayView.alpha = transparencySlider.value;
            
            
        } ];
        
        
    }
    
}

- (IBAction)switchCameraMode:(id)sender {
    

    
    useFrontCamera = !useFrontCamera;
    
    {
        
        [self swapCameras];
        
    }
//    if([sender isKindOfClass:[UIButton class]])
//    {
//        UIButton* button = sender;
//        
//        if(useFrontCamera)
//        {
//        [button setImage:[ UIImage imageNamed:@"monitor"] forState:UIControlStateNormal];
//        }else{
//            [button setImage:[ UIImage imageNamed:@"camera"] forState:UIControlStateNormal];
//
//        }
//    }
    
//    if(running)
//    {
//        [self buttonAction:nil];
//        [self buttonAction:nil];
//    }
//    
    
}
- (IBAction)hueChanged:(id)sender {

//    if([activeView.attributedView isKindOfClass:[AttributedImageView class]])
//    {
//        AttributedImageView* attributedImageView = (AttributedImageView*)self.activeView.attributedView;
//        
//        UIImage* image = [AppColors doHueAdjustFilterWithBaseImage:attributedImageView.image hueAdjust:hueSlider.value];
//        attributedImageView.image = image;
//    }
//    
//    
//    //    UIImage* image = [AppColors doStarshineFilterWithBaseImageName:self.frameName inputCount:10];
//    //    UIImage* image = [AppColors doRadialGradientFilter:self.frameName];
////    
////    DLog(@"hue shift: %@",self.frameName);
////    //    UIImage* image = [AppColors doHueAdjustFilterWithBaseImageName:self.frameName hueAdjust:hueSlider.value];
////    
////    for(UIImageView* v in frames)
////    {
////        v.image = image;
////    }
//    hueLabel.text = [NSString stringWithFormat:@"%.2f",hueSlider.value];
    
//
    UIImage* image = [AppColors doHueAdjustFilterWithBaseImageName:self.frameName hueAdjust:hueSlider.value];
    
//    UIImage* image = [AppColors doStarshineFilterWithBaseImageName:self.frameName inputCount:10];
//    UIImage* image = [AppColors doRadialGradientFilter:self.frameName];
    
    DLog(@"hue shift: %@",self.frameName);
//    UIImage* image = [AppColors doHueAdjustFilterWithBaseImageName:self.frameName hueAdjust:hueSlider.value];
    
    for(UIImageView* v in frames)
    {
        v.image = image;
    }
     hueLabel.text = [NSString stringWithFormat:@"%.2f",hueSlider.value];
    
    //restore the frame's reflection and rotation once a new image is loaded!
    
    
}

#pragma mark -
#pragma mark Saving Image
-(void)saveOverlayInBackground:(id)sender
{
//    UIGraphicsBeginImageContext(arOverlayView.frame.size);
//    UIGraphicsBeginImageContext(scrollView.frame.size);
    UIGraphicsBeginImageContext(CGSizeMake(480, 640));
    [arOverlayView.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    
    //    [appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"saveToCamera"])
    {
        UIImageWriteToSavedPhotosAlbum(screenshot, self, 
                                       @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"sendEmail"])
    {
        [self emailImage:screenshot];
    }
    [self hideButtons:NO];
    
}

- (IBAction)saveOverlay:(id)sender {
   
//    timerArrow.center = screenshotButton.center;
//    timerArrow.alpha = 1;
    
    [self hideButtons:YES];
    
    [self performSelectorInBackground:@selector(saveOverlayInBackground:) withObject:nil];
    
    
//    [ UIView animateWithDuration:2 delay:0 options:UIViewAnimationCurveLinear animations:^{
//        timerArrow.transform = CGAffineTransformMakeRotation(M_PI/2);
//    } completion:^(BOOL finished) {
//         timerArrow.alpha = 0; 
//        [self performSelectorInBackground:@selector(saveOverlayInBackground:) withObject:nil];
//       
//        timerArrow.transform = CGAffineTransformIdentity;
//    }];
//    
       
    NSLog(@"saveOverlay");
//    GLAppDelegate* appDelegate =     [UIApplication sharedApplication].delegate;
 
  
    
//    AVCaptureConnection* connection = [imageOutput.connections objectAtIndex:0] ;
//    [  imageOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
//    //        TestAudioFo
//       NSAssert(imageDataSampleBuffer !=nil,@"image data is nil!");
    //    
//        UIImage* overlay = [self imageFromSampleBuffer:imageDataSampleBuffer];
//        UIImage* screenshotComposite = [ScreenCapture UIViewToImage:alphaView withOverlayImage:overlay];
//    //    
//        UIImageWriteToSavedPhotosAlbum(overlay, self, 
//    //                                   @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    } ];

    
}

#define kcontainerOriginX @"containerOriginX"
#define kcontainerOriginY @"containerOriginY"
#define kcontainerSizeWidth @"containerSizeWidth"
#define kcontainerSizeHeight @"containerSizeHeight"
#define kFrameName @"frameName"
#define kglossEffect @"glossEffect"
#define kframeHueShift @"frameHueShift"
#define kwebViewOnTop @"webViewOnTop"

#define kscrollViewOffsetX @"scrollViewOffsetX"
#define kscrollViewOffsetY @"scrollViewOffsetY"
#define kzoomScale @"zoomScale"
#define kwebViewAddress @"webViewAddress"

#define klabelText @"labelText"
#define klabelCenterX @"labelCenterX"
#define klabelCenterY @"labelCenterY"

#define kimageData @"imageData"



-(void)interfaceWithDictionary:(NSMutableDictionary*)dictionary
{
//    [activityIndicator startAnimating];
//    self.view.userInteractionEnabled = NO;
//    
//    NSNumber* x = nil;
//    NSNumber* y = nil;
//    NSNumber* width = nil;
//    NSNumber* height = nil;
//
//    //restore view, not sure if this is necessary
//    x = [dictionary objectForKey:kcontainerOriginX];
//    y = [dictionary objectForKey:kcontainerOriginY];
//    width = [dictionary objectForKey:kcontainerSizeWidth];
//    height = [dictionary objectForKey:kcontainerSizeHeight];
//    containerView.frame = CGRectMake(x.floatValue,y.floatValue, width.floatValue,height.floatValue);
//
//    //restore the view's position within scrollview
//    NSNumber* offsetX = [dictionary objectForKey:kscrollViewOffsetX];
//    NSNumber* offsetY = [dictionary objectForKey:kscrollViewOffsetY];
//    self.scrollView.contentOffset = CGPointMake(offsetX.floatValue, offsetY.floatValue);
//
//    //restore the view's size through zoom property
//    NSNumber* zoomScale = [dictionary objectForKey:kzoomScale];
//    self.scrollView.zoomScale = zoomScale.floatValue;
//    
//    
//    //simply recall the frame name, do not re-set it yet
//    NSString* frameName_ = [dictionary objectForKey:kFrameName];
//    self.frameName = frameName_;
//    
//    NSNumber* transparency = [dictionary objectForKey:kglossEffect];
//    NSNumber* frameHueShift = [dictionary objectForKey:kframeHueShift];
//    
//    //restore transparency
//    self.transparencySlider.value = transparency.floatValue;
//    [self transparencyChanged:transparencySlider];
//    
//    //reset the frame and change hue
//    hueSlider.value = frameHueShift.floatValue;
//    [self hueChanged:hueSlider];
//    
//    NSString* webViewURLPath = [dictionary objectForKey:kwebViewAddress];
//    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:webViewURLPath]]];
//    
//    //attempt to remember what was used as the icon's background - web or image
//    NSNumber* webViewOnTop = [dictionary objectForKey:kwebViewOnTop];
//    if(webViewOnTop.boolValue && !webView.userInteractionEnabled)
//    {
//        [self enableDisableOverlayInteraction:self];
//    }else if(!webViewOnTop.boolValue && webView.userInteractionEnabled)
//    {
//        [self enableDisableOverlayInteraction:self];
//    }
//    
// 
//   NSString* labelText =  [dictionary objectForKey:klabelText];
//   NSNumber* labelCenterX = [dictionary objectForKey:klabelCenterX];
//   NSNumber* labelCenterY = [dictionary objectForKey:klabelCenterY];
//    
//    iconTypeTextField.text = labelText;
//    iconTypeTextField.center = CGPointMake(labelCenterX.floatValue, labelCenterY.floatValue);
//    
//    NSData* imageData = [dictionary objectForKey:kimageData];
//    UIImage* image = [UIImage imageWithData:imageData];
//    arOverlayView.image = image;
//    [activityIndicator stopAnimating];
//    self.view.userInteractionEnabled = YES;
//    

    
}
-(void)interfaceWithIconFile:(IconFile*)iconFile_
{
//    [activityIndicator startAnimating];
    self.view.userInteractionEnabled = YES;

    
    //simply recall the frame name, do not re-set it yet
    self.frameName = iconFile_.frameName;
    
//    NSNumber* transparency = iconFile_.glossEffect;
    NSNumber* frameHueShift = iconFile_.frameHueShift;
    
//    //restore transparency

    //reset the frame and change hue
    hueSlider.value = frameHueShift.floatValue;
//    [self hueChanged:hueSlider];

    
    NSString* webViewURLPath = iconFile_.webViewAddress;
    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:webViewURLPath]]];
    
//    //attempt to remember what was used as the icon's background - web or image
//    NSNumber* webViewOnTop = iconFile_.webViewOnTop;
//    if(webViewOnTop.boolValue && !webView.userInteractionEnabled)
//    {
//        [self enableDisableOverlayInteraction:self];
//    }else if(!webViewOnTop.boolValue && webView.userInteractionEnabled)
//    {
//        [self enableDisableOverlayInteraction:self];
//    }
    
    
    NSString* labelText =  iconFile_.labels.labelText;

    iconTypeTextField.text = labelText;
//    iconTypeTextField.center = CGPointMake(labelCenterX.floatValue, labelCenterY.floatValue);
    
//    NSData* imageData = iconFile_.image;
//    UIImage* image = [UIImage imageWithData:imageData];
//    arOverlayView.image = image;
//    [activityIndicator stopAnimating];
//    self.view.userInteractionEnabled = YES;
    
    
    
    NSString* viewName = nil;
    for(ScalableLayer* scalableLayer in iconFile.layers)
    {
        for(ContainerScrollView* container in self.editableViewLayers)
        {
            viewName =[container.attributedView.attributes valueForKey:kTitleKey];
            
            //restore the active view
            if( [viewName isEqualToString:iconFile.activeViewName])
            {
                activeView = container;
                transparencySlider.value = scalableLayer.alpha.floatValue;
//                NSLog(@"active view name: %@",viewName);
            }
            
            if( [viewName isEqualToString:scalableLayer.name])
            {
                //remember the scalable layer
                container.attributedView.scalableLayer = scalableLayer;
                
                container.zoomScale = scalableLayer.zoomScale.floatValue;
                container.transform = CGAffineTransformMakeRotation(scalableLayer.rotationRadians.floatValue);
                container.contentOffset = CGPointMake(scalableLayer.centerX.floatValue, scalableLayer.centerY.floatValue);
                
//                NSLog(@"RESTORING alpha: %f ",scalableLayer.alpha.floatValue);
                container.attributedView.alpha = scalableLayer.alpha.floatValue;
                
              
//               float rotation = atan2(container.transform.b, container.transform.a);
                
//                 NSLog(@"*****Layer: %@ rotation : %.2f observed %.2f",scalableLayer.name, scalableLayer.rotationRadians.floatValue, rotation);
                
                
                //remember the rotation
                [container.attributedView.attributes setValue:scalableLayer.rotationRadians forKey:kRotationKey];
                [container.attributedView.attributes setValue:scalableLayer.topDownOrder forKey:kTopDownOrderKey];
                
                
                //restore the rotation and reflection (does not work for image frame)
                container.transform = CGAffineTransformMakeRotation(scalableLayer.rotationRadians.floatValue);
                BOOL isReflected = scalableLayer.isReflected.boolValue;
                float reflectionParameter = isReflected?-1.0:1.0;
                container.attributedView.transform = CGAffineTransformScale(CGAffineTransformMakeRotation(scalableLayer.internalRotation.floatValue),reflectionParameter, 1.0);
                
                
                
                if(scalableLayer.color1 !=nil && scalableLayer.color1.length >0)
                {
                    NSDictionary* dictionary = [scalableLayer.color1 objectFromJSONString];
                    
                    NSNumber* hue =[dictionary objectForKey:kHueKey];
                    NSNumber* saturation =[dictionary objectForKey:kSaturationKey];
                    NSNumber* brightness =[dictionary objectForKey:kBrightnessKey];
                    NSNumber* alpha =[dictionary objectForKey:kAlphaKey];
                    
                    UIColor* color = [UIColor colorWithHue:hue.floatValue saturation:saturation.floatValue brightness:brightness.floatValue alpha:alpha.floatValue];
                    
                    container.attributedView.topGradientColor = color;

                    
                     dictionary = [scalableLayer.color2 objectFromJSONString];
                    
                    hue =[dictionary objectForKey:kHueKey];
                    saturation =[dictionary objectForKey:kSaturationKey];
                    brightness =[dictionary objectForKey:kBrightnessKey];
                    alpha =[dictionary objectForKey:kAlphaKey];
                    
                    color = [UIColor colorWithHue:hue.floatValue saturation:saturation.floatValue brightness:brightness.floatValue alpha:alpha.floatValue];
                    
                    container.attributedView.bottomGradientColor = color;
                }
                
                
                if([container.attributedView isKindOfClass:[AttributedImageView class]])
                {
                    AttributedImageView* imageView = ((AttributedImageView*)container.attributedView);
//                    UIImage* image = [NSKeyedUnarchiver unarchiveObjectWithData:scalableLayer.image];
                    UIImage* image =nil;
                    
                    //using [UIImage imageWithContentsOfFile] keeps the file open for as long as the image is retained. Overwriting that file will fail. So read from file to data, and make an image from that data. 
                        if([scalableLayer.name isEqualToString:kCameraValue])
                        {
                            NSString* fullImagePath = [[iconFile_ imagesFolderPath] stringByAppendingPathComponent:[iconFile_ iconImageWithType:kCameraType]];
                            NSData* data = [NSData dataWithContentsOfFile:fullImagePath];
                            image = [UIImage imageWithData:data];
                        }else if([scalableLayer.name isEqualToString:kLogoValue])
                        {
                             NSString* fullImagePath = [[iconFile_ imagesFolderPath] stringByAppendingPathComponent:[iconFile_ iconImageWithType:kLogoType]];
                            NSData* data = [NSData dataWithContentsOfFile:fullImagePath];
                            image = [UIImage imageWithData:data];
                        }else if([scalableLayer.name isEqualToString:kglossEffect]) {
                            //restore gloss image
                            image = [UIImage imageNamed:@"gloss512.png"];
                        }
                        else {
                        image = [UIImage imageWithData:scalableLayer.image];
                        }
                    
                    if(image!=nil)
                    {
                    UIImage* correctedImage = [UIImage imageWithCGImage:image.CGImage   scale:image.scale orientation:scalableLayer.orientation.intValue];
                    
//                    NSAssert([image isKindOfClass:[UIImage class]],@"Not an image!");
                        imageView.image = correctedImage;
                    }else {
                        imageView.image = nil;
                    }
                }else  if([container.attributedView isKindOfClass:[AttributedTextView class]])
                {
                    AttributedTextView* textView = (AttributedTextView*)container.attributedView;
                    textView.text = scalableLayer.text;
                    textView.font = [UIFont fontWithName:scalableLayer.fontName size:scalableLayer.size.intValue]  ;
//                    textView.textColor = [NSKeyedUnarchiver unarchiveObjectWithData:scalableLayer.fontColor];
                    
                    
                    NSDictionary* dictionary = [scalableLayer.fontColor objectFromJSONString];
                    
                    NSNumber* hue =[dictionary objectForKey:kHueKey];
                    NSNumber* saturation =[dictionary objectForKey:kSaturationKey];
                    NSNumber* brightness =[dictionary objectForKey:kBrightnessKey];
                    NSNumber* alpha =[dictionary objectForKey:kAlphaKey];
                    
                    UIColor* color = [UIColor colorWithHue:hue.floatValue saturation:saturation.floatValue brightness:brightness.floatValue alpha:alpha.floatValue];
                    
                    textView.textColor = color;
                 
                    
                    
                }else  if([container.attributedView isKindOfClass:[DragAndDropLabel class]])
                {
                    
                }else  if([container.attributedView isKindOfClass:[AttributedWebView class]])
                {
                    AttributedWebView* webView_ = (AttributedWebView*)container.attributedView;
                    NSURL* lastUsedURL =[NSURL URLWithString:scalableLayer.text];
                    [webView_ loadRequest: [NSURLRequest requestWithURL:lastUsedURL]];
                      
                    //restore web view internal offset on first loading of an icon file
                    initialWebViewLayer = scalableLayer; 
                    initialLoadFlag = YES;
                    
                }else if([container.attributedView isKindOfClass:[AttributedView class]])
                {
                    
                }

            }
        }
    }
    
    
    NSArray* sortedArray = [self.editableViewLayers sortedArrayUsingComparator:^(ContainerScrollView* a, ContainerScrollView* b) {
        
        NSNumber* first = [a.attributedView.attributes valueForKey :kTopDownOrderKey];
        NSNumber* second = [b.attributedView.attributes valueForKey :kTopDownOrderKey];

        return [first compare:second];
    }];
    self.editableViewLayers = [NSMutableArray arrayWithArray:sortedArray];
    
    
    
 //sort container by attribute.topDownOrder    
    
    
}


-(NSMutableDictionary*)currentInterfaceDictionary:(id)sender
{
    
//    NSMutableDictionary* dictionary = [[NSMutableDictionary alloc] initWithCapacity:20];
    
    CGRect frame = containerView.frame;
    NSString* activeViewName = [NSString stringWithFormat:@"%@",[activeView.attributedView.attributes valueForKey:kTitleKey]];
    DLog(@"%@",activeViewName)
    iconFile.activeViewName = activeViewName;
    
//    [dictionary setValue:[NSNumber numberWithInt:frame.origin.x] forKey:@"containerOriginX"];
//     [dictionary setValue:[NSNumber numberWithInt:frame.origin.y] forKey:@"containerOriginY"];
//     [dictionary setValue:[NSNumber numberWithInt:frame.size.width] forKey:@"containerSizeWidth"];
//     [dictionary setValue:[NSNumber numberWithInt:frame.size.height] forKey:@"containerSizeHeight"];
    
    iconFile.containerOriginX =[NSNumber numberWithInt:frame.origin.x];
    iconFile.containerOriginY = [NSNumber numberWithInt:frame.origin.y];
    iconFile.containerSizeHeight =[NSNumber numberWithInt:frame.size.width];
    iconFile.containerSizeHeight = [NSNumber numberWithInt:frame.size.height];
    
    
    
//    [dictionary setValue:self.frameName forKey:@"frameName"];
    iconFile.frameName = self.frameName;
    
//    [dictionary setValue:[NSNumber numberWithFloat:self.transparencySlider.value] forKey:@"glossEffect"];
//    [dictionary setValue:[NSNumber numberWithFloat:self.hueSlider.value] forKey:@"frameHueShift"];
//    [dictionary setValue:[NSNumber numberWithBool:webView.userInteractionEnabled] forKey:@"webViewOnTop"];
    iconFile.glossEffect = [NSNumber numberWithFloat:self.transparencySlider.value];
    iconFile.frameHueShift = [NSNumber numberWithFloat:self.hueSlider.value];
    iconFile.webViewOnTop = [NSNumber numberWithBool:webView.userInteractionEnabled];
    
//    [dictionary setValue:[NSNumber numberWithFloat:self.scrollView.contentOffset.x] forKey:@"scrollViewOffsetX"];
//    [dictionary setValue:[NSNumber numberWithFloat:self.scrollView.contentOffset.y] forKey:@"scrollViewOffsetY"];
    
    iconFile.scrollViewOffsetX = [NSNumber numberWithFloat:self.scrollView.contentOffset.x];
    iconFile.scrollViewOffsetY = [NSNumber numberWithFloat:self.scrollView.contentOffset.y];
    
//    [dictionary setValue:[NSNumber numberWithFloat:self.scrollView.zoomScale] forKey:@"zoomScale"];
    iconFile.zoomScale = [NSNumber numberWithFloat:self.scrollView.zoomScale];
    
//    [dictionary setValue:iconTypeTextField.text forKey:@"labelText"];
//    [dictionary setValue:[NSNumber numberWithFloat:iconTypeTextField.center.x] forKey:@"labelCenterX"];
//    [dictionary setValue:[NSNumber numberWithFloat:iconTypeTextField.center.y] forKey:@"labelCenterY"];
    
    iconFile.labels.labelText = iconTypeTextField.text;
    iconFile.labels.centerX = [NSNumber numberWithFloat:iconTypeTextField.center.x];
    iconFile.labels.centerY = [NSNumber numberWithFloat:iconTypeTextField.center.y];


    NSString* currentURL = webView.request.URL.absoluteString;
//        NSString* currentURL = webView.request.mainDocumentURL.absoluteString;
//    [dictionary setValue:currentURL forKey:@"webViewAddress"];
    
    iconFile.webViewAddress = currentURL;
//    iconFile.webViewAddress = webView.request.mainDocumentURL.absoluteString;
    
//    iconFile.image =  UIImagePNGRepresentation(arOverlayView.image);
//    
//    if(self.placeholderIcon114.image != nil)
//    {
//        iconFile.image114 =  UIImagePNGRepresentation(self.placeholderIcon114.image);
//    }
    
    NSAssert([[IconFile managedObjectContext]isEqual:[ScalableLayer managedObjectContext]],@"Different contexts");
    //clear all layers prior to saving
    [iconFile removeLayers:iconFile.layers];
    
    ScalableLayer* scalableLayer = nil;
    NSMutableSet* layersSet = [[NSMutableSet alloc] initWithCapacity:self.editableViewLayers.count];
    for (ContainerScrollView* container in self.editableViewLayers)
    {
        
        if(container.attributedView.attributes ==nil)
        {
            container.attributedView.attributes =[[NSMutableDictionary alloc] initWithCapacity:6];
        }
        scalableLayer = [ScalableLayer object];
        //remember the connection between attributed view and a scalable layer. 
        container.attributedView.scalableLayer = scalableLayer;
        
        scalableLayer.uuid = [IconFile createUUID];
        scalableLayer.centerX = [NSNumber numberWithFloat:container.contentOffset.x ];
        scalableLayer.centerY = [NSNumber numberWithFloat:container.contentOffset.y ];
        scalableLayer.zoomScale = [NSNumber numberWithFloat:container.zoomScale ];
      
        
        scalableLayer.internalRotation = [AppGraphics rotationForView:container.attributedView];
        scalableLayer.isReflected = [container.attributedView.attributes valueForKey:kIsReflected];
        
        NSString* name = [container.attributedView.attributes valueForKey:kTitleKey]; 
        scalableLayer.name = name;
        NSNumber* rotationRadians = [AppGraphics rotationForView:container];
        int order = [self.editableViewLayers indexOfObject:container];
        scalableLayer.topDownOrder = [NSNumber numberWithInt:order];
        
//        NSLog(@">>>>> name: %@, rotationRadians: %.2f",name,rotationRadians.floatValue);
        
        scalableLayer.rotationRadians = rotationRadians;
        ;
        NSLog(@"Saving alpha(%@): %f ",name,container.attributedView.alpha);
        
        scalableLayer.alpha =[NSNumber numberWithFloat:container.attributedView.alpha];
       
        
        if([container.attributedView isKindOfClass:[AttributedImageView class]])
        {
            AttributedImageView* imageView = ((AttributedImageView*)container.attributedView);
                        
//            NSData* imageData = [NSKeyedArchiver archivedDataWithRootObject:(UIImage*)imageView.image];
//            UIImage* correctedImage = [UIImage imageWithCGImage:imageView.image.CGImage   scale:imageView.image.scale orientation:UIImageOrientationUp];
            NSData* imageData = UIImagePNGRepresentation(imageView.image);
//            NSData* imageData = UIImageJPEGRepresentation((imageView.image), .85);
            NSLog(@"saving: %@, %i, class: %@",[imageView.attributes valueForKey:kTitleKey],imageData.length, [imageView.image class]);
            
            scalableLayer.orientation = [NSNumber numberWithInt:imageView.image.imageOrientation];
            scalableLayer.image = imageData;
            
        }else  if([container.attributedView isKindOfClass:[AttributedTextView class]])
        {
            //TEXTVIEW
            AttributedTextView* textView = (AttributedTextView*)container.attributedView;
            scalableLayer.text = textView.text;
            scalableLayer.fontName =textView.font.fontName;
//            scalableLayer.fontColor = [NSKeyedArchiver archivedDataWithRootObject:textView.textColor];
            scalableLayer.size = [NSNumber numberWithInt:textView.font.pointSize];
            
            UIColor* color = textView.textColor;
            NSDictionary *colorData = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:color.hue], @"Hue",
                                       [NSNumber numberWithFloat:color.saturation], @"Saturation",
                                       [NSNumber numberWithFloat:color.brightness], @"Brightness",
                                       [NSNumber numberWithFloat:color.alpha], @"Alpha", nil];
            
            NSString* json = [colorData JSONString];
            scalableLayer.fontColor = json;
            
            
            
        }else  if([container.attributedView isKindOfClass:[DragAndDropLabel class]])
        {
                        
        }else  if([container.attributedView isKindOfClass:[AttributedWebView class]])
        {
            AttributedWebView* webView_ = (AttributedWebView*)container.attributedView;
//            webView_.scrollView.contentOffset;
            scalableLayer.text = webView_.request.mainDocumentURL.absoluteString;
            scalableLayer.internalOffsetX =  [NSNumber numberWithFloat:webView_.scrollView.contentOffset.x]; 
            scalableLayer.internalOffsetY =  [NSNumber numberWithFloat:webView_.scrollView.contentOffset.y]; 
            
            
            
        }else if([container.attributedView isKindOfClass:[AttributedView class]])
        {
            
            if(container.attributedView.topGradientColor !=nil)
            {
            UIColor* color = container.attributedView.topGradientColor;
            NSDictionary *colorData = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:color.hue], @"Hue",
                                       [NSNumber numberWithFloat:color.saturation], @"Saturation",
                                       [NSNumber numberWithFloat:color.brightness], @"Brightness",
                                       [NSNumber numberWithFloat:color.alpha], @"Alpha", nil];
            
            NSString* json = [colorData JSONString];
            scalableLayer.color1 = json;
            
            color = container.attributedView.bottomGradientColor;
            colorData = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithFloat:color.hue], @"Hue",
                                       [NSNumber numberWithFloat:color.saturation], @"Saturation",
                                       [NSNumber numberWithFloat:color.brightness], @"Brightness",
                                       [NSNumber numberWithFloat:color.alpha], @"Alpha", nil];
            
            json = [colorData JSONString];
            scalableLayer.color2 = json;
            }

        }
        [layersSet addObject:scalableLayer];
      
//    NSLog(@"##############");
//    NSLog(@"%@",[scalableLayer description]);
//    NSLog(@"##############");
    }


    [[ScalableLayer managedObjectContext]  save:nil];

//    NSLog(@"saved Layers: %i",[ScalableLayer count:nil]) ;
    
    [iconFile addLayers:layersSet];
    [[IconFile managedObjectContext] save:nil];

   
    return nil;
}


#pragma mark PHOTO BUTTON
- (IBAction)saveComposite:(id)sender {

    
    GLAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    [appDelegate showFullScreenProgress];
    
    
    [Appirater userDidSignificantEvent:YES];
    
    [self hideButtons:YES];
    [self snapShot];


}

-(void)stopWebViewLoading:(id)sender
{
     [webView stopLoading];
}
-(void)performSegueOnMainThread:(NSString*)segueIdentifier
{
    [self performSegueWithIdentifier:segueIdentifier sender:self];

}
-(void)saveInBackground:(id)sender
{
    
    
    //    UIImageWriteToSavedPhotosAlbum(photo, self, @selector(savedSnapShot:didFinishSavingWithError:contextInfo:), nil);
    
    GLAppDelegate* appDelegate =     [UIApplication sharedApplication].delegate;
    
    //    UIGraphicsBeginImageContext(appDelegate.window.bounds.size);
    //    [appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    CGSize iPhoneRetinaIconSize = CGSizeMake(320,480);
    //    CGSize iPhoneRetinaIconSize = CGSizeMake(57,57);
    
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(iPhoneRetinaIconSize, NO, [UIScreen mainScreen].scale);
    //    UIGraphicsBeginImageContextWithOptions(iPhoneRetinaIconSize, NO, 0.5);
    else
        UIGraphicsBeginImageContext(iPhoneRetinaIconSize);
    
    //    UIGraphicsBeginImageContext(CGSizeMake(57,57));
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
//    [appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    ////    UIImage *screenshot = [ScreenCapture UIViewToImage:self.view];
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    float scale = [[UIScreen mainScreen] scale];
//    CGRect cropRect = CGRectMake(iconFrame256.frame.origin.x*scale, (iconFrame256.frame.origin.y+self.navigationController.navigationBar.frame.size.height)*scale, iconFrame256.frame.size.width*scale, iconFrame256.frame.size.height*scale);
//    CGRect cropRect = CGRectMake(0*scale, (self.navigationController.navigationBar.frame.size.height)*scale, 256*scale, 256*scale);
    CGRect cropRect = CGRectMake(0, 0, 256*scale, 256*scale);
    

    
    CGImageRef imageRef = CGImageCreateWithImageInRect([screenshot CGImage], cropRect);
    UIImage *result = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    UIGraphicsEndImageContext();
    
    //create an image with rounded corners
    //just in case the icons would look different with different radius of rounded corners. The placeholders also preserve the cut images.
    for(UIImageView* placeholderView in placeholderImageViews)
    {
        placeholderView.image = result;
        
        if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
            UIGraphicsBeginImageContextWithOptions(placeholderView.frame.size, NO, [UIScreen mainScreen].scale);
        //    UIGraphicsBeginImageContextWithOptions(iPhoneRetinaIconSize, NO, 0.5);
        else
            UIGraphicsBeginImageContext(placeholderView.frame.size);
        
        [placeholderView.layer renderInContext:UIGraphicsGetCurrentContext()];
        screenshot = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        //save the result
        placeholderView.image = screenshot;
 
    }
    


    
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"saveToCamera"])
    {
        UIImageWriteToSavedPhotosAlbum(placeholderIcon256.image, self, 
                                       @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
//    [self emailImage:screenshot];
//    
//    //    if([[NSUserDefaults standardUserDefaults] boolForKey:@"sendEmail"])
//    //    {
//    //        [self emailImage:screenshot];
//    //    }
//    [self hideButtons:NO];
    
    [self performSelectorOnMainThread:@selector(currentInterfaceDictionary:) withObject:nil waitUntilDone:YES];
//    NSDictionary* dictionary =  [self currentInterfaceDictionary];
//    NSString* jsonString = [dictionary JSONString];
    
    [self performSelectorOnMainThread:@selector(stopWebViewLoading:) withObject:nil waitUntilDone:YES];
   
    self.navigationItem.rightBarButtonItem.enabled = YES;
    [self performSelectorOnMainThread:@selector(stopWebViewLoading:) withObject:nil waitUntilDone:YES];
    [self performSelectorOnMainThread:@selector(performSegueOnMainThread:) withObject:@"preview" waitUntilDone:NO];
    
    
}

- (void) saveDisplayView
{
    
    
    
    
    
    
    [self performSelectorInBackground:@selector(saveInBackground:) withObject:nil];
    
    //    UIImage *photo = [ScreenCapture UIViewToImage:displayView];   
    //    UIImage *photo = [ScreenCapture UIViewToImage:self.view];
    //    // returns an autoreleased image
    //    
    //    if ( photo == nil )
    //        return;
    //    
    //    UIImageWriteToSavedPhotosAlbum(photo, self,                                                                       @selector(image:didFinishSavingWithError:contextInfo:), nil);
    //
    
}


#pragma mark -
- (IBAction)timerAction:(id)sender {
    NSLog(@"timerAction");
}

- (IBAction)backArrowAction:(id)sender {
    
    [webView goBack];
}

//image saved callback
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error 
  contextInfo:(void *)contextInfo
{
    // Was there an error?
    if (error != NULL)
    {
        // Show error message...
         NSLog(@"save failed");
        
    }
    else  // No errors
    {
         NSLog(@"save successful");
        // Show message image successfully saved
    }
}








// Create a UIImage from sample buffer data
- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer 
{
    // Get a CMSampleBuffer's Core Video image buffer for the media data
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0); 
    
    // Get the number of bytes per row for the pixel buffer
    void *baseAddress = CVPixelBufferGetBaseAddress(imageBuffer); 
    
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer); 
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer); 
    size_t height = CVPixelBufferGetHeight(imageBuffer); 
    
    // Create a device-dependent RGB color space
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB(); 
    
    // Create a bitmap graphics context with the sample buffer data
    CGContextRef context = CGBitmapContextCreate(baseAddress, width, height, 8, 
                                                 bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst); 
    // Create a Quartz image from the pixel data in the bitmap graphics context
    CGImageRef quartzImage = CGBitmapContextCreateImage(context); 
    // Unlock the pixel buffer
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
    
    // Free up the context and color space
    CGContextRelease(context); 
    CGColorSpaceRelease(colorSpace);
    
    // Create an image object from the Quartz image
    UIImage *image = [UIImage imageWithCGImage:quartzImage];
    
    // Release the Quartz image
    CGImageRelease(quartzImage);
    
    return (image);
}

//// Delegate routine that is called when a sample buffer was written
//- (void)captureOutput:(AVCaptureOutput *)captureOutput 
//didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer 
//       fromConnection:(AVCaptureConnection *)connection
//{ 
//    // Create a UIImage from the sample buffer data
//    UIImage *image = [self imageFromSampleBuffer:sampleBuffer];
//    
//    //    < Add your code here that uses the image >
//    
//}


- (void)captureStillImage
{
	AVCaptureConnection *videoConnection = nil;
	for (AVCaptureConnection *connection in [[self stillImageOutput] connections]) {
		for (AVCaptureInputPort *port in [connection inputPorts]) {
			if ([[port mediaType] isEqual:AVMediaTypeVideo]) {
				videoConnection = connection;
				break;
			}
		}
		if (videoConnection) {
            break;
        }
	}
    
	NSLog(@"about to request a capture from: %@", [self stillImageOutput]);
	[[self stillImageOutput] captureStillImageAsynchronouslyFromConnection:videoConnection
                                                         completionHandler:^(CMSampleBufferRef imageSampleBuffer, NSError *error) {
                                                             CFDictionaryRef exifAttachments = CMGetAttachment(imageSampleBuffer, kCGImagePropertyExifDictionary, NULL);
                                                             if (exifAttachments) {
                                                                 NSLog(@"attachements: %@", exifAttachments);
                                                             } else {
                                                                 NSLog(@"no attachments");
                                                             }
                                                             NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer];
                                                             UIImage *image = [[UIImage alloc] initWithData:imageData];
                                                             [self setStillImage:image];
                                                             
                                                             
                                                             UIImage* overlay = image;
#warning wrong code, no more alphaView
                                                             UIImage* screenshotComposite = [ScreenCapture UIViewToImage:alphaView withOverlayImage:overlay];
                                                             
                                                             UIImageWriteToSavedPhotosAlbum(screenshotComposite, self, 
                                                                                            @selector(image:didFinishSavingWithError:contextInfo:), nil);

                                                            
                                                             [[NSNotificationCenter defaultCenter] postNotificationName:kImageCapturedSuccessfully object:nil];
                                                         }];
}


- (void) swapCameras
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.75];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(cameraSwapAnimation:finished:context:)];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:[self view] cache:YES];
    [UIView commitAnimations];
    
    [captureSession stopRunning];
    [captureSession beginConfiguration];
    [captureSession removeInput:captureInput];
    
//    [captureSession removeOutput:stillImageOutput];
    
    if ( currentCameraDeviceIndex==frontCameraDeviceIndex )
    {
        currentCameraDeviceIndex = backCameraDeviceIndex;
        cameraImageOrientation = UIImageOrientationRight;
    }
    else
    {
        currentCameraDeviceIndex = frontCameraDeviceIndex;
        cameraImageOrientation = UIImageOrientationLeftMirrored;
    }
    
    //
    // Re-map the Open/GL to account for imageOrientation change
    //
//    [self mapGLViewForOrientation:UIInterfaceOrientationPortrait];
    
    // Start the Camera
    //
    AVCaptureDevice *selectedCamera = [[AVCaptureDevice devices] objectAtIndex:(NSUInteger)currentCameraDeviceIndex];
    
    captureInput = [AVCaptureDeviceInput deviceInputWithDevice:selectedCamera error:nil];
    
    if ( [selectedCamera lockForConfiguration:nil] )
    {
        if ( [selectedCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure] )
        {
            [selectedCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
        }
        
        if ( [selectedCamera isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance] )
        {
            [selectedCamera setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
        }
        
        if ( [selectedCamera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus] )
        {
            [selectedCamera setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        }
        
        if ( [selectedCamera isTorchModeSupported:AVCaptureTorchModeAuto] )
        {
            [selectedCamera setTorchMode:AVCaptureTorchModeOff];    // AVCaptureTorchModeOn turns the "torch" light ON
        }
        
        if ( [selectedCamera isFlashModeSupported:AVCaptureFlashModeAuto] )
        {
            [selectedCamera setFlashMode:AVCaptureFlashModeAuto];   // AVCaptureFlashModeAuto
        }
        
        [selectedCamera unlockForConfiguration];
    }
    
    if ( [selectedCamera supportsAVCaptureSessionPreset:AVCaptureSessionPreset640x480])
    {
        cameraDeviceSetting = CameraDeviceSetting640x480;
        [captureSession setSessionPreset:AVCaptureSessionPreset640x480];    // AVCaptureSessionPresetHigh or AVCaptureSessionPreset640x480
    }
    else
        if ( [selectedCamera supportsAVCaptureSessionPreset:AVCaptureSessionPresetHigh] )
        {
            cameraDeviceSetting = CameraDeviceSettingHigh;
            [captureSession setSessionPreset:AVCaptureSessionPresetHigh];   // AVCaptureSessionPresetHigh or AVCaptureSessionPreset640x480
        }
        else
            if ( [selectedCamera supportsAVCaptureSessionPreset:AVCaptureSessionPresetMedium] )
            {
                cameraDeviceSetting = CameraDeviceSettingMedium;
                [captureSession setSessionPreset:AVCaptureSessionPresetMedium]; // AVCaptureSessionPresetHigh or AVCaptureSessionPreset640x480
            }
            else
                if ( [selectedCamera supportsAVCaptureSessionPreset:AVCaptureSessionPresetLow] )
                {
                    cameraDeviceSetting = CameraDeviceSettingLow;
                    [captureSession setSessionPreset:AVCaptureSessionPresetLow];    // AVCaptureSessionPresetHigh or AVCaptureSessionPreset640x480
    
                
                }   
    
//    [self addStillImageOutput];
    
    [captureSession addInput:captureInput];
    [captureSession commitConfiguration];
    
    [captureSession startRunning];
}

- (void) scanForCameraDevices
{
    cameraCount = 0;
    frontCameraDeviceIndex = -1;
    backCameraDeviceIndex = -1;
    
    AVCaptureDevice *backCameraDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSArray *deviceList = [AVCaptureDevice devices];
    NSRange cameraSearch;
    NSUInteger i;
    
    for ( i=0; i<[deviceList count]; i++ )
    {
        AVCaptureDevice *currentDevice = (AVCaptureDevice *)[deviceList objectAtIndex:i];
        
        //
        // This is the best info so skip string the string searches
        // that follow if we have a match on this
        //
        if ( currentDevice==backCameraDevice )
        {
            backCameraDeviceIndex = i;
            cameraCount++;
            continue;
        }
        
        cameraSearch = [[currentDevice description] rangeOfString:@"front camera" options:NSCaseInsensitiveSearch];
        if ( frontCameraDeviceIndex<0 && cameraSearch.location != NSNotFound )
        {
            frontCameraDeviceIndex = i;
            cameraCount++;
            continue;
        }
        
        cameraSearch = [[currentDevice description] rangeOfString:@"back camera" options:NSCaseInsensitiveSearch];
        if ( backCameraDevice<0 && cameraSearch.location != NSNotFound )
        {
            backCameraDeviceIndex = i;
            cameraCount++;
            continue;
        }
        
        cameraSearch = [[currentDevice description] rangeOfString:@"camera" options:NSCaseInsensitiveSearch];
        if ( backCameraDevice<0 && cameraSearch.location != NSNotFound )
        {
            backCameraDeviceIndex = i;
            cameraCount++;
            continue;
        }
    }
}
- (void) activateCameraFeed
{
    videoSettings = nil;
    
    pixelFormatCode = [[NSNumber alloc] initWithUnsignedInt:(unsigned int)kCVPixelFormatType_32BGRA];
    pixelFormatKey = [[NSString alloc] initWithString:(NSString *)kCVPixelBufferPixelFormatTypeKey];
    videoSettings = [[NSDictionary alloc] initWithObjectsAndKeys:pixelFormatCode, pixelFormatKey, nil]; 
    
    dispatch_queue_t queue = dispatch_queue_create("com.AugmentedRealityGlamour.ImageCaptureQueue", NULL);
    
    captureOutput = [[AVCaptureVideoDataOutput alloc] init];
    [captureOutput setAlwaysDiscardsLateVideoFrames:YES];
    [captureOutput setSampleBufferDelegate:self queue:queue];
    [captureOutput setVideoSettings:videoSettings];
    
    dispatch_release(queue);
    
    AVCaptureDevice *selectedCamera;
    
      
    currentCameraDeviceIndex = -1;
    
    // default to front facing camera
    //
    if ( useFrontCamera )
    {
        currentCameraDeviceIndex = frontCameraDeviceIndex;
        cameraImageOrientation = UIImageOrientationLeftMirrored;
    }
    else
    {
        currentCameraDeviceIndex = backCameraDeviceIndex;
        cameraImageOrientation = UIImageOrientationRight;
    }
    
    if ( currentCameraDeviceIndex < 0 )
        selectedCamera = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    else
        selectedCamera = [[AVCaptureDevice devices] objectAtIndex:(NSUInteger)currentCameraDeviceIndex];
    
    captureInput = [AVCaptureDeviceInput deviceInputWithDevice:selectedCamera error:nil];
    
    if ( [selectedCamera lockForConfiguration:nil] )
    {
        if ( [selectedCamera isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure] )
        {
            [selectedCamera setExposureMode:AVCaptureExposureModeContinuousAutoExposure];
        }
        
        if ( [selectedCamera isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance] )
        {
            [selectedCamera setWhiteBalanceMode:AVCaptureWhiteBalanceModeContinuousAutoWhiteBalance];
        }
        
        if ( [selectedCamera isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus] )
        {
            [selectedCamera setFocusMode:AVCaptureFocusModeContinuousAutoFocus];
        }
        
        if ( [selectedCamera isTorchModeSupported:AVCaptureTorchModeAuto] )
        {
            [selectedCamera setTorchMode:AVCaptureTorchModeOff];    // AVCaptureTorchModeOn turns the "torch" light ON
        }
        
        if ( [selectedCamera isFlashModeSupported:AVCaptureFlashModeAuto] )
        {
            [selectedCamera setFlashMode:AVCaptureFlashModeAuto];   // AVCaptureFlashModeAuto
        }
        
        [selectedCamera unlockForConfiguration];
    }
    
    captureSession = [[AVCaptureSession alloc] init];
    [captureSession beginConfiguration];
    
    if ( [selectedCamera supportsAVCaptureSessionPreset:AVCaptureSessionPreset640x480])
    {
        cameraDeviceSetting = CameraDeviceSetting640x480;
        [captureSession setSessionPreset:AVCaptureSessionPreset640x480];    // AVCaptureSessionPresetHigh or AVCaptureSessionPreset640x480
    }
    else
        if ( [selectedCamera supportsAVCaptureSessionPreset:AVCaptureSessionPresetHigh] )
        {
            cameraDeviceSetting = CameraDeviceSettingHigh;
            [captureSession setSessionPreset:AVCaptureSessionPresetHigh];   // AVCaptureSessionPresetHigh or AVCaptureSessionPreset640x480
        }
        else
            if ( [selectedCamera supportsAVCaptureSessionPreset:AVCaptureSessionPresetMedium] )
            {
                cameraDeviceSetting = CameraDeviceSettingMedium;
                [captureSession setSessionPreset:AVCaptureSessionPresetMedium]; // AVCaptureSessionPresetHigh or AVCaptureSessionPreset640x480
            }
            else
                if ( [selectedCamera supportsAVCaptureSessionPreset:AVCaptureSessionPresetLow] )
                {
                    cameraDeviceSetting = CameraDeviceSettingLow;
                    [captureSession setSessionPreset:AVCaptureSessionPresetLow];    // AVCaptureSessionPresetHigh or AVCaptureSessionPreset640x480
                }   
    
    [captureSession addInput:captureInput];
    [captureSession addOutput:captureOutput];
//    [captureSession addOutput:stillImageOutput];
    
//    [self addStillImageOutput];

    [captureSession commitConfiguration];
    
   
    [captureSession startRunning];
}

- (void) saveGLView
{
   
}


- (void) snapShot
{
    if ( ignoreImageStream )
        return;
    
    ignoreImageStream = YES;
    
    if ( currentViewSource==VIEWSOURCE_OPENGLVIEW )
        [self saveGLView];
    else
        if ( currentViewSource==VIEWSOURCE_UIIMAGEVIEW )
            [self saveDisplayView];
    
    ignoreImageStream = NO;
}

#pragma mark -
#pragma mark ASSIGNING IMAGE
//
// This method releases the 'newimage' because it may change it
// so the references passed can no longer be released by the
// caller of this method
//
- (void) newCameraImageNotification:(UIImage*)newImage
{
    if ( newImage == nil )
        return;
    
    if ( currentViewSource == VIEWSOURCE_UIIMAGEVIEW )
    {
        if([activeView.attributedView isEqual:logoView])
        {
             [logoView setImage:newImage];
        }else if([activeView.attributedView isEqual:arOverlayView])
        {
             [arOverlayView setImage:newImage];
        }else if([activeView.attributedView isKindOfClass:[iPhoneModel class]])
        {
            iPhoneModel* iPhoneModel = activeView.attributedView;
            [iPhoneModel.promoScreen setImage:newImage];
            
        }
       
        
        

    }
    else
        if ( currentViewSource == VIEWSOURCE_OPENGLVIEW )
        {}
//        {
//            size_t textureBufferWidth = (size_t)rintf( cameraTextureRect.size.width );
//            size_t textureBufferHeight = (size_t)rintf( cameraTextureRect.size.height );
//            
//            //      memset( cameraTextureImageBuffer, (unsigned char)0, textureBufferWidth * textureBufferHeight * 4 ); // needs to be done to avoid shadowing under transparency
//            
//            // Draw the full image into our cameraTextureImageBuffer (which is sized to account for this) even though
//            // for texture mapping to work, we will only bind to a 512x512 section of the image
//            //
//            CGRect extractRect = CGRectMake((CGFloat)0.0, (CGFloat)0.0, (CGFloat)CGImageGetWidth(newImage), (CGFloat)CGImageGetHeight(newImage));
//            CGContextDrawImage(cameraTextureContext, extractRect, newImage);
//            glBindTexture(GL_TEXTURE_2D, cameraTextureTag);
//            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, textureBufferWidth, textureBufferHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, cameraTextureImageBuffer);
//            
//            [self refreshVBObjects];
//        }
    
//    CGImageRelease(newImage);
}



- (void) performImageCaptureFrom:(CMSampleBufferRef)sampleBuffer
{
//    self.sampleBuffer = sampleBuffer;
    
    CVImageBufferRef imageBuffer;
    
    if ( CMSampleBufferGetNumSamples(sampleBuffer) != 1 )
        return;
    if ( !CMSampleBufferIsValid(sampleBuffer) )
        return;
    if ( !CMSampleBufferDataIsReady(sampleBuffer) )
        return;
    
    imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer); 
    
    if ( CVPixelBufferGetPixelFormatType(imageBuffer) != kCVPixelFormatType_32BGRA )
        return;
    
    CVPixelBufferLockBaseAddress(imageBuffer,0); 
    
    uint8_t *baseAddress = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer); 
    
    CGImageRef newImage = nil;
    
    if ( cameraDeviceSetting == CameraDeviceSetting640x480 )
    {
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        newImage = CGBitmapContextCreateImage(newContext);
        CGColorSpaceRelease( colorSpace );
        CGContextRelease(newContext);
    }
    else
    {
        uint8_t *tempAddress = malloc( 640 * 4 * 480 );
        memcpy( tempAddress, baseAddress, bytesPerRow * height );
        baseAddress = tempAddress;
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGContextRef newContext = CGBitmapContextCreate(baseAddress, width, height, 8, bytesPerRow, colorSpace,  kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst);
        newImage = CGBitmapContextCreateImage(newContext);
        CGContextRelease(newContext);
        newContext = CGBitmapContextCreate(baseAddress, 640, 480, 8, 640*4, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);
        CGContextScaleCTM( newContext, (CGFloat)640/(CGFloat)width, (CGFloat)480/(CGFloat)height );
        CGContextDrawImage(newContext, CGRectMake(0,0,640,480), newImage);
        CGImageRelease(newImage);
        newImage = CGBitmapContextCreateImage(newContext);
        CGColorSpaceRelease( colorSpace );
        CGContextRelease(newContext);
        free( tempAddress );
    }
    
    if ( newImage != nil )
    {
        
//    tempImage =  [[UIImage alloc] initWithCGImage:newImage scale:(CGFloat)1.0 orientation:UIImageOrientationUp];
//    CGImageRelease(newImage);
        tempImage =  [[UIImage alloc] initWithCGImage:newImage scale:(CGFloat)1.0 orientation:cameraImageOrientation];
        CGImageRelease(newImage);

        
        [self performSelectorOnMainThread:@selector(newCameraImageNotification:) withObject:tempImage waitUntilDone:YES];
        
    
               
//        for(UIImageView* v in iconsForDisplay)
//        {
//            v.image = result;
//        }
        
    }
    
    CVPixelBufferUnlockBaseAddress(imageBuffer,0);
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    if ( ignoreImageStream )
        return;
       [self performImageCaptureFrom:sampleBuffer];
    
} 


- (IBAction)searchButton:(id)sender {
    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:[[NSUserDefaults standardUserDefaults] stringForKey:@"searchEngine"]]]];
    
}

- (IBAction)helpButtonAction:(id)sender {
    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://luciddreamingapp.com/augmented-reality/augmented-reality-controls/"]]];
    
    
}

- (IBAction)facebookButtonAction:(id)sender {
    
    [webView loadRequest: [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.facebook.com/pages/Augmented-Reality-Glamour/160885867357601"]]];

}

- (IBAction)preferencesButtonAction:(id)sender {
//    NSLog(@"preferences");
    //does a segue to preferences
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

#pragma mark -
#pragma mark EMAIL IMAGE

-(void)displayComposerSheetWithFile:(id)image_
{
    MFMailComposeViewController *picker = [MFMailComposeViewController alloc];
    picker = [picker init];
    
    UIImage* image_57 = nil;
    UIImage* image_114 = nil;
    UIImage* image_72 = nil;
    UIImage* image_144 = nil;
    
   
        //retrieve the images from the placeholder and scale down for non-retina displays
        image_57 = [AppColors imageByScalingAndCroppingImage:placeholderIcon114.image ForSize:CGSizeMake(57,57)];
        image_114 = placeholderIcon114.image;
        
        image_72 = [AppColors imageByScalingAndCroppingImage:placeholderIcon144.image ForSize:CGSizeMake(72,72)];
        image_144 = placeholderIcon144.image;

    
    picker.mailComposeDelegate = self;
    
    NSLog(@"DEVICE MODEL: %@",[[UIDevice currentDevice] model]);
    
    
    
    // MAKING A SCREENSHOT
    //    Lucid_Dreaming_AppAppDelegate* appDelegate = ((Lucid_Dreaming_AppAppDelegate*)[[UIApplication sharedApplication] delegate]);
    
    UIImage* image = image_;
      // ATTACHING A SCREENSHOT
    
    NSString* dirtyString = springBoardTextField.text;
    NSData *myData = UIImagePNGRepresentation(placeholderIcon256.image);
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"app_store_512x512.png"]];     
  
    if(image_114!=nil)
    {
        myData = UIImagePNGRepresentation(image_114);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"iPhone_retina_114x114.png"]];    
    }
    
    if(image_57!=nil)
    {
        myData = UIImagePNGRepresentation(image_57);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPhone_57x57.png"]];    
    }
    if(image_144!=nil)
    {
        myData = UIImagePNGRepresentation(image_144);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPad_retina_144x144.png"]];    
    }
    if(image_72!=nil)
    {
        myData = UIImagePNGRepresentation(image_72);
        [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@%@",dirtyString,@"_iPad_72x72.png"]];    
    }
 
    
    
    
    NSString* filename = [NSString stringWithFormat:@"%@ iPhone App Maker Icons %@",springBoardTextField.text, [dateFormatter stringFromDate:[NSDate date]] ];
    [picker setSubject:filename];
    NSArray *toRecipients = nil;
    // Set up recipients
    NSString* email= [[NSUserDefaults standardUserDefaults] valueForKey:@"email"];
    if(email!=nil){
       toRecipients = [NSArray arrayWithObject:email]; 
    }else{
         toRecipients = [NSArray arrayWithObject:@""];
    }
    //     NSArray *ccRecipients = [NSArray arrayWithObjects:@"science@luciddreamingapp.com",nil]; 
    // NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"]; 
    
    [picker setToRecipients:toRecipients];
    // [picker setCcRecipients:ccRecipients];   
    // [picker setBccRecipients:bccRecipients];

    
    // Fill out the email body text
    NSString *emailBody = [NSString stringWithFormat:@"Attached are iOS icons for %@\n512x512 - for App store submission\n114x114 is iPhone with retina display \n57x57 is iPhone 3GS and below \n144x144 is iPadHD \n72x72 is iPad1 and iPad2 \n  gradient shadow transparency: %.2f \nborder hue: %.2f",    
                           springBoardTextField.text,
                           transparencySlider.value,
                           hueSlider.value                           
                           ];
    [picker setMessageBody:emailBody isHTML:NO];
    [self.navigationController presentModalViewController:picker animated:YES];
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;

    
}
-(void)emailImage:(UIImage*)image
{ 
//    [self.tabBarController.tabBar setHidden:YES]; 
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self performSelectorOnMainThread:@selector(displayComposerSheetWithFile:) withObject:image waitUntilDone: NO]   ;
    
}
#pragma mark - WEB VIEW

- (void)webViewDidStartLoad:(UIWebView *)webView
{
      [activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView_
{
    [activityIndicator stopAnimating];
    if(initialLoadFlag)
    {
        initialLoadFlag = NO;
         webView_.scrollView.contentOffset = CGPointMake(initialWebViewLayer.internalOffsetX.floatValue, initialWebViewLayer.internalOffsetY.floatValue); 
    }
   

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
     [activityIndicator stopAnimating];
}


#pragma mark -
#pragma mark GESTURE RECOGNIZERS

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
    if([gestureRecognizer isEqual:rotationRecognizer])
    {
        savedRotaion = [activeView.attributedView.attributes valueForKey:kRotationKey];
    }else {
        NSLog(@"received call from : %@", [gestureRecognizer class]);
    }
    return YES;
    
}



- (IBAction)rotateView:(id)sender {
    
    if([sender isKindOfClass:[UIRotationGestureRecognizer class]])
    {
        UIRotationGestureRecognizer* recognizer = sender;
        
      
        float recognizerRotation = [recognizer rotation];
        
        //turn all rotation into positive one to prevent date formatting issues
//        float rotation = (rotatingIconLabel?0:savedRotation+recognizerRotation);
        float rotation = (recognizerRotation+savedRotaion.floatValue);
//        float rotation = (recognizerRotation);        
        
        CGAffineTransform transform = CGAffineTransformMakeRotation(rotation);
        
        
        //causes major spinning of the view
        //        backgroundReminderView.transform = CGAffineTransformRotate(backgroundReminderView.transform, [recognizer rotation]);
        
        //         rotation = atan2(backgroundReminderView.transform.b, backgroundReminderView.transform.a);

        {
            
            activeView.transform = transform;
           
//            
            if(rotationRecognizer.state == UIGestureRecognizerStateEnded)
            {
                savedRotaion =  [AppGraphics rotationForView:activeView];
                [activeView.attributedView.attributes setValue: savedRotaion forKey:kRotationKey];
            }
//            activeView.dummyZoomView.transform = transform;
//            rotation = atan2(activeView.dummyZoomView.transform.b, activeView.dummyZoomView.transform.a);
// 
        }

        
    }
    
}

-(void)handleTapFrom:(id)sender
{
    NSLog(@"Tap");
    
    //dismiss keyboard by tapping out of it
    if([sender isEqual:tapGestureRecognizer]){
        CGPoint location = [tapGestureRecognizer locationInView:self.view];
        
        if(self.fontPickerView.alpha>0)
        {
            if(CGRectContainsPoint(self.fontPickerView.frame, location))
            {
                //do not dismiss the picker if a user tapped inside of it
                return;
            }
        }
        [self dismissKeyboard:self];
    }
    
    tapGestureRecognizer.enabled = NO;
}

- (IBAction)handleLongPress:(UILongPressGestureRecognizer*)gesture {
    
  
    if(UIGestureRecognizerStateBegan == gesture.state) {
        // Do initial work here
       
        CGPoint location = [gesture locationInView:iconView];
        
        if(CGRectContainsPoint(iconTypeTextField.frame, location))
        {
              draggingIconLabel = YES;
        }

      
        
    }
    
    
    if(UIGestureRecognizerStateChanged == gesture.state) {
        // Do repeated work here (repeats continuously) while finger is down
        
        CGPoint location = [gesture locationInView:iconView];
        CGPoint outOfIconLocation = [gesture locationInView:self.view];
        
        if(draggingIconLabel && CGRectContainsPoint(iconView.frame, outOfIconLocation))
        {
            iconTypeTextField.center = location;
        }

    }
    
    if(UIGestureRecognizerStateEnded == gesture.state) {
        // Do end work here when finger is lifted
        draggingIconLabel = NO;
    }

}




#pragma mark -

-(void)hideButtons:(BOOL) hide{
    
    return;
//    
//    cameraPanel.alpha = (hide)?0:1;
//    cameraModeButton.alpha = (hide)?0:1;
//    modeButton.alpha = (hide)?0:1;
//    startStopButton.alpha = (hide)?0:1;
//    screenshotButton.alpha = (hide)?0:1;
//    saveCompositeButton.alpha = (hide)?0:1;
//    
//    cameraModeButton2.alpha = (hide)?0:1;
//    modeButton2.alpha = (hide)?0:1;
//    startStopButton2.alpha = (hide)?0:1;
//    screenshotButton2.alpha = (hide)?0:1;
//    arScreenshotButton2.alpha = (hide)?0:1;
//    
//    for (UILabel* label in buttonLabels)
//    {
//        label.alpha = (hide)?0:1;
//    }
//    
    
}



- (IBAction)enableDisableGloss:(id)sender {
    
    [UIView animateWithDuration:0.6 animations:^{
        
        for(UIView* v in glossEffects)
        {
            v.alpha = glossSwitch.on?1:0;
        }
         
    }];
   
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField isEqual:springBoardTextField])
    {
#warning add check for special characters
        
        homeScreenLabel1.text =[NSString stringWithFormat:@"%@%@", springBoardTextField.text, @"Lite"];;
         homeScreenLabel4.text =springBoardTextField.text;
         homeScreenLabel2.text =[NSString stringWithFormat:@"%@%@", springBoardTextField.text, @"Pro"];
         homeScreenLabel3.text =[NSString stringWithFormat:@"%@%@", springBoardTextField.text, @"Free"];
    }
    return YES;
}


#pragma mark -
#pragma mark UITextViewDelegate
-(void)dismissKeyboard:(id)sender
{
    
   [ UIView animateWithDuration:0.4 animations:^{
        self.fontPickerView.alpha = 0;
        [[self activeTextView] resignFirstResponder];
   }];

    self.navigationItem.rightBarButtonItem = previewButton;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if(!doneButton)
    {
        doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    }
    self.navigationItem.rightBarButtonItem = doneButton;
     tapGestureRecognizer.enabled = YES;
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
;
    return  YES;
}

-(BOOL) textFieldShouldReturn:(UITextField*) textField {
    [textField resignFirstResponder]; 
    if([textField isEqual:iconTypeTextField])
    {
        iconView.userInteractionEnabled = NO;
    }
//   [UIView animateWithDuration:0.6 animations:^{
//        iconPanel.center = CGPointMake(160, 324);
//   }];
    
    return YES;
}



- (IBAction)showImagePicker:(id)sender {
    	[self presentModalViewController:self.imagePicker animated:YES];
}
#pragma mark image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	
    if([activeView.attributedView isEqual:logoView])
    {
        logoView.image = img;
        
    }else if([activeView.attributedView isEqual:arOverlayView]) {
        arOverlayView.image = img;	
    }else if([activeView.attributedView isKindOfClass:[iPhoneModel class]])
    {
        iPhoneModel* iPhoneModel = activeView.attributedView;
        [iPhoneModel.promoScreen setImage:img];
        
    }
    
	[self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if([activeView.attributedView isEqual:logoView])
    {
        logoView.image = nil;
    }else if([activeView.attributedView isEqual:arOverlayView]) {
        arOverlayView.image = nil;	
    }else if([activeView.attributedView isKindOfClass:[iPhoneModel class]])
    {
        iPhoneModel* iPhoneModel = activeView.attributedView;
        [iPhoneModel.promoScreen setImage:nil];
        
    }
    [self dismissModalViewControllerAnimated:YES];

}
#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView_ didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell* cell = [tableView_  cellForRowAtIndexPath:indexPath];


    if([activeControl isEqual:glossControl])
    {
        glossEffect.image =[UIImage imageNamed:cell.textLabel.text];
        return;
    }else if ([activeControl isEqual:frameControl])
    {
        self.frameName = cell.textLabel.text;
        [self hueChanged:nil];
       
    }
  
}

#pragma mark -
#pragma mark SEGUE
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
   if( [segue.identifier isEqualToString:@"preview"])
   {
       //user has chosen to save the icon, do not trash it
       self.doTrashIconOnClose = NO;
       
       //pass the json file for saving
   
//       [segue.destinationViewController setInterfaceLayoutJSON: jsonString];
       
       [segue.destinationViewController setIconFile: iconFile];

       [segue.destinationViewController setHueValue:hueSlider.value];
       [segue.destinationViewController setTransparencyValue:transparencySlider.value];
       
       [segue.destinationViewController setImage512:placeholderIcon256.image];
       [segue.destinationViewController setImage144:placeholderIcon144.image];
       [segue.destinationViewController setImage72:[AppColors imageByScalingAndCroppingImage:placeholderIcon144.image ForSize:CGSizeMake(72,72)] ];
        
       [segue.destinationViewController setImage114:placeholderIcon114.image];
           [segue.destinationViewController setImage57:[AppColors imageByScalingAndCroppingImage:placeholderIcon114.image ForSize:CGSizeMake(57,57)]];
       [segue.destinationViewController setLogoImage:self.logoView.image];
       [segue.destinationViewController setCameraImage:self.arOverlayView.image];
       
       
       [[RKObjectManager sharedManager].objectStore save];

   } 
    
   else  if([segue.identifier isEqualToString:@"iconMakerHelp"])
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


- (IBAction)dismissController:(id)sender {
    //delete default icon if the user clicks the red x button
    if(self.doTrashIconOnClose)
    {
        [self.iconFile deleteInContext:self.iconFile.managedObjectContext];
    }
    
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	UILabel *label = nil;
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
		view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]] ;
        view.frame = CGRectMake(0,0,100,100);
		label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,100,100)] ;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.font = [label.font fontWithSize:18];
		[view addSubview:label];
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
//	label.text = [items objectAtIndex:index];
	
	return view;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.view.subviews.count;
}

- (NSUInteger)numberOfVisibleItemsInCarousel:(iCarousel *)carousel
{
    //limit the number of items views loaded concurrently (for performance reasons)
    //this also affects the appearance of circular-type carousels
    return NUMBER_OF_VISIBLE_ITEMS;
}

- (NSUInteger)numberOfPlaceholdersInCarousel:(iCarousel *)carousel
{
	//note: placeholder views are only displayed on some carousels if wrapping is disabled
	return INCLUDE_PLACEHOLDERS? 2: 0;
}

- (UIView *)carousel:(iCarousel *)carousel placeholderViewAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
	UILabel *label = nil;
	
	//create new view if no view is available for recycling
	if (view == nil)
	{
		view = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"page.png"]] ;
        view.frame = CGRectMake(0,0,50,50);
		label = [[UILabel alloc] initWithFrame:view.bounds] ;
		label.backgroundColor = [UIColor clearColor];
		label.textAlignment = UITextAlignmentCenter;
		label.font = [label.font fontWithSize:18];
		[view addSubview:label];
	}
	else
	{
		label = [[view subviews] lastObject];
	}
	
    //set label
	label.text = (index == 0)? @"Top": @"Bottom";
	
	return view;
}

- (CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    //usually this should be slightly wider than the item views
    return ITEM_SPACING;
}

- (CGFloat)carousel:(iCarousel *)carousel itemAlphaForOffset:(CGFloat)offset
{
	//set opacity based on distance from camera
    return 1.0f - fminf(fmaxf(offset, 0.0f), 1.0f);
}

- (CATransform3D)carousel:(iCarousel *)_carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carouselController.carousel.itemWidth);
}

- (BOOL)carouselShouldWrap:(iCarousel *)carousel
{
    return NO;
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewActionDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    GMGridViewCell* cell =    [gridView cellForItemAtIndex:position];
    ContainerScrollView* v = nil;
    UIView* oldControl = nil;
    
    [self dismissKeyboard:nil];
    
    if(position<editableViewLayers.count)
    {
        oldControl = activeControl;
       
        
        v =[editableViewLayers objectAtIndex:position];
         NSAssert (v.attributedView.attributes!=nil ,@"NO attributes for view!");
        NSString* title = [v.attributedView.attributes valueForKey:kTitleKey];
        
        NSLog(@"Tapped on : %@",title);
        
        NSLog(@"center:x:%.0f, y:%.0f",v.attributedView.center.x,v.attributedView.center.y);
        NSLog(@"height::%.0f, width:%.0f",v.attributedView.frame.size.height,v.attributedView.frame.size.width);
        NSLog(@"v.alpha %f attr alpha: %f",v.alpha,v.attributedView.alpha);
        NSLog(@"v.scalable layer alpha %f",v.attributedView.scalableLayer.alpha.floatValue);
        NSLog(@"Superview: %@ %@",[v.superview class], [v.attributedView.superview class]);
        
        
        //remember the active view for other actions
        activeView = v;
        
        //reset user interaction, allowing only the active view to scroll
        for(UIView* view in editableViewLayers)
        {
            view.userInteractionEnabled = NO;
        }
        v.userInteractionEnabled = YES;
        
        
                //understand which view to show
        if([v.attributedView isKindOfClass:[AttributedImageView class]])
        {
           
            
            if([title isEqualToString:kGlossValue])
            {
                activeControl = nil;
//                activeControl = glossControl;
            }else if([title isEqualToString:kFrameValue]) {
                activeControl = frameControl;
            }else if ([title isEqualToString:kCameraValue])
            {
                activeControl = photoControl;
            }else if ([title isEqualToString:kLogoValue])
            {
                activeControl = photoControl;
            }
 
            
        }else  if([v.attributedView isKindOfClass:[AttributedTextView class]])
        {
            activeControl = fontControl;
            [self resetFontControls];
            
        }else  if([v.attributedView isKindOfClass:[iPhoneModel class]])
        {
            //must go before drag and drop label
            activeControl = photoControl;
                        
        }else  if([v.attributedView isKindOfClass:[DragAndDropLabel class]])
        {
            activeControl = fontControl;
            [self resetFontControls];
            
        }else  if([v.attributedView isKindOfClass:[AttributedWebView class]])
        {
            activeControl = webViewControl;
        }else if([v.attributedView isKindOfClass:[AttributedView class]])
        {
            activeControl = gradientControl;
            [self resetActiveGradientControlForCurrentGradient];
            self.gradientViewController.activeGradientView = activeView.attributedView;
//            activeControl = photoControl;
        }
        
        //after assigning controls, hide the frame color for all controls other than the frame
        
       
       
        
        //restore the transparency value
        [transparencySlider setValue:v.attributedView.alpha animated:YES];
  
    };
   
    bool activeControlIsFrame = [activeControl isEqual:frameControl];
    
    
    CGAffineTransform tempTransform = v.transform;
    
    [ UIView animateWithDuration:0.3 animations:^{
        cell.contentView.transform = CGAffineTransformScale(cell.contentView.transform, 1.2,1.2);
        v.transform = CGAffineTransformScale(tempTransform,1.2,1.2);
        if(![cell isEqual:selectedCell])
        {
            
            //previously selected
//            selectedCell.contentView.backgroundColor =  [UIColor lightGrayColor] ;
            selectedCell.selected = NO;
            
            //newly selected cell
//            cell.contentView.backgroundColor = [UIColor blueColor] ;
            selectedCell = cell;
            selectedCell.selected = YES;

        }
        
        [self positionSliders:activeControlIsFrame];
              
         oldControl.alpha =0;
        
    } completion:^(BOOL finished) {
        [ UIView animateWithDuration:0.3 animations:^{
            cell.contentView.transform = CGAffineTransformIdentity;
//            cell.contentView.backgroundColor = [UIColor purpleColor] ;
            v.transform = tempTransform;
            activeControl.alpha = 1;
            
        }];
    } ];
    
    
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewSortingDelegate
//////////////////////////////////////////////////////////////

- (void)GMGridView:(GMGridView *)gridView didStartMovingCell:(GMGridViewCell *)cell
{
    [UIView animateWithDuration:0.3 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 
                     animations:^{
                         cell.contentView.backgroundColor = [UIColor orangeColor];
                         cell.contentView.layer.shadowOpacity = 0.7;
                         
                     } 
                     completion:nil
     ];
}

- (void)GMGridView:(GMGridView *)gridView didEndMovingCell:(GMGridViewCell *)cell
{
    NSLog(@"ended moving cell");
    [UIView animateWithDuration:0.3 
                          delay:0 
                        options:UIViewAnimationOptionAllowUserInteraction 

                     animations:^{ 
                         
                         if(![cell isEqual:selectedCell])
                         {
//                             selectedCell.contentView.backgroundColor =  [UIColor lightGrayColor] ;
                             selectedCell.selected = NO;
                             
//                             cell.contentView.backgroundColor = [UIColor blueColor] ;
                             selectedCell = cell;
                             cell.selected = YES;
                         }
                         
//                         if([cell isEqual:selectedCell])
//                         {
//                             cell.contentView.backgroundColor = [UIColor blueColor];
//                             cell.contentView.layer.shadowOpacity = 0;
//                         }else{
//                             cell.contentView.backgroundColor = [UIColor lightGrayColor];
//                             cell.contentView.layer.shadowOpacity = 0;
//                         }
                         
                     }
                     completion:nil
     ];
}

- (BOOL)GMGridView:(GMGridView *)gridView shouldAllowShakingBehaviorWhenMovingCell:(GMGridViewCell *)cell atIndex:(NSInteger)index
{
    return YES;
}

- (void)GMGridView:(GMGridView *)gridView moveItemAtIndex:(NSInteger)oldIndex toIndex:(NSInteger)newIndex
{
    // We dont care about this in this demo (see demo 1 for examples)
    NSObject *object = [editableViewLayers objectAtIndex:oldIndex];
    [editableViewLayers removeObject:object];
    [editableViewLayers insertObject:object atIndex:newIndex];
    UIView* movedView = nil;
    if(newIndex>0)
    {
       movedView=  [editableViewLayers objectAtIndex:newIndex];
        CGRect oldFrame  = movedView.frame;
        
        //find the layer on top and insert the moved view under that
        UIView* coveringView = [editableViewLayers objectAtIndex:newIndex-1];
        [movedView removeFromSuperview];
        [self.view insertSubview:movedView belowSubview:coveringView];
        movedView.frame = oldFrame;
    }else {
        movedView =[editableViewLayers objectAtIndex:newIndex];
        CGRect oldFrame  = movedView.frame;
        
        //find the layer on top and insert the moved view under that
        UIView* viewBelow = [editableViewLayers objectAtIndex:newIndex+1];
        [movedView removeFromSuperview];
        [self.view insertSubview:movedView aboveSubview:viewBelow];
        movedView.frame = oldFrame;
    }
    
    //now rearrange all subviews below the moved one
    
    UIView* viewAbove = movedView;
    UIView* viewBelow = nil;
    for(int i = newIndex+1; i< editableViewLayers.count;i++)
    {
       viewBelow= [editableViewLayers objectAtIndex:i];
        [viewBelow removeFromSuperview];
        [self.view insertSubview:viewBelow belowSubview:viewAbove];
        
        //remember the next top view for the next iteration
        viewAbove= viewBelow;
    }
    
  
    
    
}

- (void)GMGridView:(GMGridView *)gridView exchangeItemAtIndex:(NSInteger)index1 withItemAtIndex:(NSInteger)index2
{
    // We dont care about this in this demo (see demo 1 for examples)
     [editableViewLayers exchangeObjectAtIndex:index1 withObjectAtIndex:index2];
    
}

//////////////////////////////////////////////////////////////
#pragma mark GMGridViewDataSource
//////////////////////////////////////////////////////////////

- (NSInteger)numberOfItemsInGMGridView:(GMGridView *)gridView
{
    return editableViewLayers.count;
}

- (CGSize)sizeForItemsInGMGridView:(GMGridView *)gridView
{
    return CGSizeMake(57, 57);
    
}

- (GMGridViewCell *)GMGridView:(GMGridView *)gridView cellForItemAtIndex:(NSInteger)index
{
    CGSize size = [self sizeForItemsInGMGridView:gridView];
    
    GMGridViewCell *cell = [gridView dequeueReusableCell];
    ContainerScrollView* s = [editableViewLayers objectAtIndex:index];
    AttributedView* attributedView =s.attributedView;

    if (!cell) 
    {
        cell = [[GMGridViewCell alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        
       
        if([s isEqual:activeView])
        {
            selectedCell = cell;
            view.backgroundColor = [UIColor blueColor];
        }else {
            view.backgroundColor = [UIColor lightGrayColor];
        }
        
        //rounded corners
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 9;
        view.layer.borderColor = [[UIColor blackColor] CGColor];
        view.layer.borderWidth = 1;
        //shadows do not show for rounded corner views
//        view.layer.shadowColor = [UIColor grayColor].CGColor;
//        view.layer.shadowOffset = CGSizeMake(5, 5);
//        view.layer.shadowPath = [UIBezierPath bezierPathWithRect:view.bounds].CGPath;
//        view.layer.shadowRadius = 9;
        
        cell.contentView = view;
    }
    
  
 
    
   
    //create gradient backgrounds by side effect
    if([s isEqual:activeView])
    {
        selectedCell = cell;
        cell.selected = YES;
    }else {
        cell.selected = NO;
    }
    
       
//    ShadowLabel* shadowLabel = [[ShadowLabel alloc] initWithFrame:cell.contentView.bounds];
//    shadowLabel.shadowDepth = 4;
    [cell.textLabel removeFromSuperview];
    cell.textLabel = [[UILabel alloc] initWithFrame:cell.contentView.bounds];
    cell.textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;  
    cell.textLabel.text = [attributedView.attributes objectForKey:@"title"];
    cell.textLabel.textAlignment = UITextAlignmentCenter;
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.adjustsFontSizeToFitWidth = YES;
    cell.textLabel.minimumFontSize = 10;
    cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    [cell.contentView addSubview:cell.textLabel];
    
    //add inner shadow and border (must be both)
    //http://stackoverflow.com/questions/4431292/inner-shadow-effect-on-uiview-layer
//    cell.contentView.layer.borderWidth = 1;
//    cell.contentView.layer.borderColor=[[UIColor whiteColor] CGColor];
    
//    cell.contentView.layer.shadowColor=[[UIColor blackColor] CGColor];
//    cell.contentView.layer.shadowOffset = CGSizeMake(0, 0);
//    cell.contentView.layer.shadowOpacity = 1;
//    cell.contentView.layer.shadowRadius  = 2.0;
    
    
    //does not work
//    http://www.sunsetlakesoftware.com/2008/10/22/3-d-rotation-without-trackball
//    CALayer *layer = cell.layer;
//
//    CATransform3D transform = CATransform3DIdentity;
//    transform.m34 = 1.0f / -500.0f;
//    layer.transform = CATransform3DRotate(transform,60.0f * M_PI / 180.0f,
//                                          1.0f, -1.0f, 0.0f);

    return cell;
}

#pragma mark -


- (IBAction)enableDisableWebView:(id)sender {
    
    activeView.attributedView.userInteractionEnabled = enableDisableWebViewSwitch.on;
    
    
}

-(UITextView*)activeTextView
{
   if( [activeView.attributedView isKindOfClass:[AttributedTextView class]])
   {
       return activeView.attributedView;
   }else if([activeView.attributedView isKindOfClass:[DragAndDropLabel class]])
   {
       return ((DragAndDropLabel*)activeView.attributedView).textView;
   }
    return nil;
}


- (IBAction)fontSizeChanged:(id)sender {
    if([sender isKindOfClass:[UIStepper class]])
    {
        fontSizeButton.title = [NSString stringWithFormat:@"%.0f", 12 ];
        
        
    } 
    
    [self activeTextView].font = [UIFont fontWithName:@"Eurostile" size:12];
    
    
}



- (IBAction)changeFont:(id)sender {
    
[UIView animateWithDuration:0.3 animations:^{
    self.fontPickerView.alpha = 1;

    if(!doneButton)
    {
        doneButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissKeyboard:)];
    }
    self.navigationItem.rightBarButtonItem = doneButton;
    tapGestureRecognizer.enabled = YES; //allow the user to tap out of the font selection
} ];
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    [[self activeTextView] setFont:[UIFont fontWithName:[fontNames objectAtIndex:row] size:[self activeTextView].font.pointSize]];
    
    NSString* fullFontName = [self activeTextView].font.fontName;
    
    changeFontButton.title = (fullFontName.length>20)?[fullFontName substringToIndex:19]:fullFontName;
    

}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return [fontNames count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    NSLog(@"[fontNames objectAtIndex:row]");
    return [fontNames objectAtIndex:row];
} 

-(UIView*)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if(view==nil)
    {
        int height =[self activeTextView].font.pointSize +5;
        UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0,0,280,height)];
        [label setFont:[UIFont fontWithName:[fontNames objectAtIndex:row] size:[self activeTextView].font.pointSize]];
        label.adjustsFontSizeToFitWidth = NO;
        label.text = [self activeTextView].text;
        return label;
        
    }else {
        if([view respondsToSelector:@selector(setFont:)])
           {
               UIFont* font = [UIFont fontWithName:[fontNames objectAtIndex:row] size:[self activeTextView].font.pointSize];
               [view performSelector:@selector(setFont:) withObject:font];
               
           }
        if([view respondsToSelector:@selector(setText:)])
        {
            
            [view performSelector:@selector(setText:) withObject:[self activeTextView].text];
            
        }
        return view;
    }
}


-(NSArray*)generateFontNames
{
    
    NSArray *familyNames = [UIFont familyNames];
    NSMutableArray* fontWithFamilyNames = [[NSMutableArray alloc] initWithCapacity:familyNames.count*3];
   
    for (NSString* familyName in familyNames)
    {

        [fontWithFamilyNames addObjectsFromArray:[UIFont fontNamesForFamilyName:familyName]];           
    }
    return fontWithFamilyNames;
}






- (IBAction)changeFontSize:(id)sender {
}
- (IBAction)changeFontColor:(id)sender {
    
    
    ColorPickerViewController* standIn = [[ColorPickerViewController alloc] initWithNibName:@"ColorPickerViewController" bundle:nil];
    standIn.delegate = self;
    standIn.defaultsColor = [self activeTextView].textColor;
    
    [self presentModalViewController:standIn animated:YES];


}
#pragma mark-
#pragma mark COLOR PICKER
- (void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color
{
    if([activeControl isEqual:self.fontControl])
    {
    fontColorButton.image = nil;
    fontColorButton.tintColor = color;   
    [self activeTextView].textColor = color;
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)changeFontAlignment:(id)sender {
    
    //cycle text alignment
    textAlignment=iconTypeTextField.textAlignment;
    
    if (textAlignment ==UITextAlignmentLeft)
    {
        textAlignment =UITextAlignmentCenter;
        
    }
    else if(textAlignment ==UITextAlignmentCenter)
    {
        textAlignment =UITextAlignmentRight;
    }else if (textAlignment ==UITextAlignmentRight)
    {
       textAlignment =UITextAlignmentLeft;
    }
    [self activeTextView].textAlignment = textAlignment;
    [self resetFontControls];
    
}

-(void)resetFontControls
{
    AttributedTextView* textView = [self activeTextView];
    textAlignment = textView.textAlignment;
    //display a shortened font name
    if(textView.font.fontName.length >20)
    {
        changeFontButton.title = [textView.font.fontName substringToIndex:19];
    }else {
        changeFontButton.title = textView.font.fontName;
    }
    fontColorButton.tintColor = textView.textColor;
    
    fontSizeButton.title = [NSString stringWithFormat:@"%.0f",textView.font.pointSize];
    
    textAlignment=textView.textAlignment;
    if(textAlignment ==UITextAlignmentCenter)
    {
        fontAlignmentButton.title = @"<=>";
    }else if (textAlignment ==UITextAlignmentLeft)
    {
        fontAlignmentButton.title = @"<==";
    }else if (textAlignment ==UITextAlignmentRight)
    {
         fontAlignmentButton.title = @"==>";
    }
}
- (IBAction)clearView:(id)sender {
    [self activeTextView].text = @"";
}

-(void)resetActiveGradientControlForCurrentGradient
{
    
    self.gradientViewController.topColor = activeView.attributedView.topGradientColor ;
    self.gradientViewController.bottomColor = activeView.attributedView.bottomGradientColor;  
    
}

-(void)setupGradient
{
//    
//    CAGradientLayer* gradientLayer = gradientBackground.gradientLayer;
//    [gradientLayer removeFromSuperlayer];
//    gradientLayer = [CAGradientLayer layer];
//
//    gradientLayer.startPoint = CGPointMake(0.5, 0);
//    gradientLayer.endPoint = CGPointMake(0.5,1);
//    gradientLayer.frame = gradientBackground.frame;
//    gradientLayer.colors = [NSArray arrayWithObjects:(id)[gradientBackground.topGradientColor CGColor], (id)[gradientBackground.bottomGradientColor CGColor], nil];
//    
//    [gradientBackground.layer addSublayer:gradientLayer];
//   gradientBackground.gradientLayer = gradientLayer;

}
-(void)hideNavbar
{
    NSLog(@"Navcontroller is nil: %@",self.navigationController==nil?@"YES":@"NO");
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [super viewWillAppear:YES];
}

-(void)setupFrameContent
{
    [pulseScroller setupForContent:kContentTypeFrames];
}

-(NSMutableArray*)setupLayers
{
   NSMutableArray* tempSetupArray= [[NSMutableArray alloc] initWithCapacity:10];
    
    [tempSetupArray addObject:self.iconTypeTextField];
    [tempSetupArray addObject:self.iconFrame256];
    [tempSetupArray addObject:self.logoView];
    [tempSetupArray addObject:self.glossEffect];
    [tempSetupArray addObject:self.arOverlayView];
    [tempSetupArray addObject:self.gradientBackground];
    [tempSetupArray addObject:self.webView];
    [tempSetupArray addObject:self.ornamentView];
    
    return tempSetupArray;
}

-(void)loadInitialFrame
{
    self.frameName = [AppColors frameNameWithTag:1];
    
}

-(QRGenerator*)qrGenerator
{
    if(__qrGenerator !=nil)
    {
        return __qrGenerator;
    }
    
    self.qrGenerator = [[QRGenerator alloc] init];
    
    return __qrGenerator;
}


-(void)resetLayerOrder
{
    //add layers one by one, starting with the bottom one
    ContainerScrollView* temp =nil;
    for (int i = self.editableViewLayers.count-1;i>=0;i--){
        temp = [self.editableViewLayers objectAtIndex:i];
        [temp removeFromSuperview];
        [self.view insertSubview:temp belowSubview:layersPanel];
    }
    
//    NSMutableArray *tmp = [[NSMutableArray alloc] init];
//    
//    for(int x=[editableViewLayers count] - 1;x>=0; x--){
//        [tmp addObject:[editableViewLayers objectAtIndex:x]];
//    }
//    self.editableViewLayers = tmp;
}

-(void)setupAttributesForLayers
{
    //create distinct attribute objects
    
    [iconTypeTextField.attributes setValue:kTextValue forKey:kTitleKey];
    [glossEffect.attributes setValue:kGlossValue forKey:kTitleKey];
    [logoView.attributes setValue: kLogoValue forKey:kTitleKey];
    [iconFrame256.attributes setValue:kFrameValue forKey:kTitleKey];
    [arOverlayView.attributes setValue:kCameraValue forKey:kTitleKey];
    [ webView.attributes setValue:kWebValue forKey:kTitleKey];
    [gradientBackground.attributes setValue:kGradientValue forKey:kTitleKey];
    [ornamentView.attributes setValue:kOrnamentValue forKey:kTitleKey];
    
   
    
       
}

-(void)setupDefaultLayerParameters
{
    
    //create and remember the gradient
    gradientBackground.topGradientColor = [UIColor lightGrayColor];
    gradientBackground.bottomGradientColor = [UIColor darkGrayColor];
    
    logoView.layer.cornerRadius = logoView.frame.size.width/2;
    logoView.layer.masksToBounds =YES;
    
    //remember layer parameters for reset operation
    for(ContainerScrollView* container in self.editableViewLayers)
    {
        [container.attributedView.attributes setValue: [NSNumber numberWithFloat:container.zoomScale]  forKey:kOriginalZoomScale];
        [container.attributedView.attributes setValue: [NSNumber numberWithFloat:container.contentOffset.x]  forKey:kOriginalXOffset];
        [container.attributedView.attributes setValue: [NSNumber numberWithFloat:container.contentOffset.y]  forKey:kOriginalYOffset];
        [container.attributedView.attributes setValue: [AppGraphics rotationForView:container]  forKey:kOriginalRotation];
        [container.attributedView.attributes setValue: [AppGraphics rotationForView:container.attributedView]  forKey:kOriginalAttributedViewRotation];
        [container.attributedView.attributes setValue: [NSNumber numberWithBool:NO]  forKey:kIsReflected];
        
        
        [container.attributedView.attributes setValue:[NSNumber numberWithFloat:container.attributedView.alpha] forKey:kOriginalTransparency];
        
        if([container.attributedView isEqual:iconFrame256])
        {
            [container.attributedView.attributes setValue:iconFile.frameHueShift forKey:kOriginalColor];
        }
        if([container.attributedView isKindOfClass:[AttributedTextView class]])
        {
            AttributedTextView* textView = (AttributedTextView*)container.attributedView;
            [container.attributedView.attributes setValue:textView.text forKey:kOriginalText];
        }else if([container.attributedView isKindOfClass:[DragAndDropLabel class]])
        {
            DragAndDropLabel* dragAndDropLabel = (DragAndDropLabel*)container.attributedView;
            [container.attributedView.attributes setValue:dragAndDropLabel.textView.text forKey:kOriginalText];
        }
        
        
        
    }
 
}

- (IBAction)resetActiveLayer:(id)sender {
    //reset the layer to how it was loaded
    NSNumber* rotation = [activeView.attributedView.attributes objectForKey:kOriginalRotation];
    NSNumber* attributedRotation = [activeView.attributedView.attributes objectForKey:kOriginalAttributedViewRotation];
    
    NSNumber* zoomScale  = [activeView.attributedView.attributes objectForKey:kOriginalZoomScale];
    NSNumber* contentOffsetX = [activeView.attributedView.attributes objectForKey:kOriginalXOffset];
    NSNumber* contentOffsetY = [activeView.attributedView.attributes objectForKey:kOriginalYOffset];
    
    NSString* text = [activeView.attributedView.attributes objectForKey:kOriginalText];
    NSString* hueShift = [activeView.attributedView.attributes valueForKey:kOriginalColor];
    NSNumber* alpha = [activeView.attributedView.attributes objectForKey:kOriginalTransparency];

    
   [ UIView animateWithDuration:0.3 animations:^{
       activeView.transform = CGAffineTransformMakeRotation(rotation.floatValue);
       activeView.attributedView.transform = CGAffineTransformMakeRotation(attributedRotation.floatValue);
       activeView.zoomScale = zoomScale.floatValue;
       activeView.contentOffset = CGPointMake(contentOffsetX.floatValue, contentOffsetY.floatValue);
       transparencySlider.value = alpha.floatValue;
       [self transparencyChanged:transparencySlider];
    }];
    
    if([activeView.attributedView isKindOfClass:[AttributedTextView class]])
    {
        AttributedTextView* textView = (AttributedTextView*)activeView.attributedView;
        textView.text = text;
    }else if([activeView.attributedView isKindOfClass:[DragAndDropLabel class]])
    {
        DragAndDropLabel* dragAndDropLabel = (DragAndDropLabel*)activeView.attributedView;
       dragAndDropLabel.textView.text = text;
    }else if ([activeView.attributedView isEqual:iconFrame256]) {
        hueSlider.value = hueShift.floatValue;
        [self hueChanged:hueSlider];
    }

}


-(void)positionSliders:(bool)activeControlIsFrame
{
    if(activeControlIsFrame)
    {
        hueSlider.alpha =1;
        frameColorLabel.alpha = 1;
        
        alphaChannelLabel.center = CGPointMake(70,28);
        transparencySlider.center = CGPointMake(160,30);
    }else {
        hueSlider.alpha =0;
        frameColorLabel.alpha = 0;
        
        alphaChannelLabel.center = CGPointMake(70,40);
        transparencySlider.center = CGPointMake(160,40);
    }

}
-(void)configureButton:(UIButton*)button
{
   button.layer.cornerRadius = 4;
   button.layer.masksToBounds = YES;
   button.layer.borderColor = [[UIColor blackColor] CGColor];
   button.layer.borderWidth = 1;
    [AppGraphics addLinearGradientToView:button TopColor:[UIColor whiteColor] BottomColor:[UIColor darkGrayColor]];
}

-(void)setupBordersAndGradients
{
     [self configureButton:self.selectImageButton];
     [self configureButton:self.cameraModeButton];
     [self configureButton:self.forwardButton];
     [self configureButton:self.backButton];
     [self configureButton:self.helpButton];
     [self configureButton:self.loadingButton];
    [self configureButton:self.resetButton];
    [self configureButton:self.rotateButton];
    [self configureButton:self.reflectButton];

    
    self.startStopButton.layer.cornerRadius = self.startStopButton.bounds.size.height/2;
    self.startStopButton.layer.masksToBounds = YES;
    self.startStopButton.layer.borderColor = [[UIColor blackColor] CGColor];
    self.startStopButton.layer.borderWidth = 1;
    
    
    self.frameBoundary.layer.cornerRadius = 45;
    self.frameBoundary.layer.masksToBounds = YES;
    self.frameBoundary.layer.borderColor =[[UIColor greenColor] CGColor];
    self.frameBoundary.layer.borderWidth = 1;
    
//    self.topControlPanel.layer.cornerRadius = 8;
//    self.topControlPanel.layer.masksToBounds = YES;
//    self.bottomControlPanel.layer.cornerRadius = 8;
//    self.bottomControlPanel.layer.masksToBounds = YES;

  
    
    [AppGraphics addLinearGradientToView:self.startStopButton TopColor:[UIColor whiteColor] BottomColor:[UIColor darkGrayColor]];

    
    [AppGraphics addLinearGradientToView:self.controlPanel TopColor:[UIColor lightGrayColor] BottomColor:[UIColor darkGrayColor]];
    
    
//    [AppGraphics addLinearGradientToView:self.layersPanel TopColor:[UIColor lightGrayColor] BottomColor:[UIColor darkGrayColor]];
    
//    [AppGraphics addLinearGradientToView:self.maskPanel TopColor:[UIColor lightGrayColor] BottomColor:[UIColor lightGrayColor]];
//    
    
    //custom gradient from top middle to bottom left
//    for(CALayer* layer in self.maskPanel.layer.sublayers)
//    {
//        if ([layer isKindOfClass:[CAGradientLayer class]])
//        {
//            [layer removeFromSuperlayer];
//        }
//    }
//    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
//    
//    gradientLayer.startPoint = CGPointMake(1, 0);
//    gradientLayer.endPoint = CGPointMake(0,1);
//    gradientLayer.frame = self.maskPanel.bounds;
//    gradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor darkGrayColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];    //    [view.layer addSublayer:gradientLayer];
//
//    [self.maskPanel.layer insertSublayer:gradientLayer atIndex:0];


    
//    self.layersPanel.layer.cornerRadius =6;
//    self.layersPanel.layer.masksToBounds = YES;
//    self.maskPanel.layer.cornerRadius =6;
//    self.maskPanel.layer.masksToBounds = YES;
    self.controlPanel.layer.cornerRadius =6;
    self.controlPanel.layer.masksToBounds = YES;
//    [AppGraphics addLinearGradientToView:self.topControlPanel TopColor:[UIColor darkGrayColor] BottomColor:[UIColor lightGrayColor]];

}

-(void)doFlip
{

}
//reflect images!
- (IBAction)reflectView:(id)sender {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.8];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(doFlip)];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.activeView cache:YES];
    //        [self.activeView removeFromSuperview];
    
    
   
    [UIView commitAnimations];
   
//    NSNumber* isReflected = [self.activeView.attributedView.attributes valueForKey:kIsReflected];
//
//    [UIView animateWithDuration:0.75 animations:^{
//        if(isReflected.boolValue)
//        {
//            self.activeView.attributedView.transform = CGAffineTransformScale(self.activeView.attributedView.transform, 1,1);
//            [self.activeView.attributedView.attributes setValue: [NSNumber numberWithBool:NO]  forKey:kIsReflected];
//        }else {
//            //do reflection
//            self.activeView.attributedView.transform = CGAffineTransformScale(self.activeView.attributedView.transform,-1,1);
//            [self.activeView.attributedView.attributes setValue: [NSNumber numberWithBool:YES]  forKey:kIsReflected];
//        }
//    } completion:^(BOOL finished) {
//        
//    } ];
    
    
    
    if([self.activeView.attributedView isKindOfClass:[AttributedImageView class]])
    {
    AttributedImageView* attributedImageView = (AttributedImageView*)self.activeView.attributedView;
        if(attributedImageView.image == nil)
        {
            //rotating a nil image retuns a white screen which may mess up gradient icons in the future
            return;
        }
        
    //create drawing context
    UIGraphicsBeginImageContextWithOptions(attributedImageView.bounds.size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, -1.0, 1.0);
    CGContextTranslateCTM(context, -attributedImageView.bounds.size.width,0);
    
//        CGContextScaleCTM(context, 1.0, -1.0);
//        CGContextTranslateCTM(context, 0.0, -attributedImageView.bounds.size.height);
//        
        
//    //clip to gradient
//    CGContextClipToMask(context, self.activeView.attributedView.bounds, gradientMask);
//    CGImageRelease(gradientMask);
//    
    //draw reflected layer content
   [attributedImageView.layer renderInContext:context];
    attributedImageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    }
    else {
        //reflect a regular view
        
        NSNumber* isReflected =  self.activeView.attributedView.scalableLayer.isReflected ;
        if(isReflected.boolValue)
        {
            self.activeView.transform = CGAffineTransformMakeScale(1,1);
            [self.activeView.attributedView.attributes setValue: [NSNumber numberWithBool:NO]  forKey:kIsReflected];
            self.activeView.attributedView.scalableLayer.isReflected =[NSNumber numberWithBool:NO];
            
        }else {
            //do reflection
            self.activeView.transform = CGAffineTransformMakeScale(-1,1);
            [self.activeView.attributedView.attributes setValue: [NSNumber numberWithBool:YES]  forKey:kIsReflected];
             self.activeView.attributedView.scalableLayer.isReflected =[NSNumber numberWithBool:YES];
        }
        
    }
}

- (IBAction)rotateActiveView:(id)sender {
    NSLog(@"center: %.1f %.1f",self.activeView.center.x,self.activeView.center.y);
    
    
//   [ UIView animateWithDuration:0.3 animations:^{
//       [self gestureRecognizerShouldBegin:self.rotationRecognizer];
//       self.rotationRecognizer.rotation -= M_PI/2;
//       
//       
//       
//       [self rotateView:self.rotationRecognizer];
//       savedRotaion =  [AppGraphics rotationForView:activeView];
//       [activeView.attributedView.attributes setValue: savedRotaion forKey:kRotationKey];
//   } ];
    
    [ UIView animateWithDuration:0.75 animations:^{
        
        float rotation = [AppGraphics rotationForView:activeView.attributedView].floatValue -  M_PI/2;
        CGAffineTransform transform = CGAffineTransformMakeRotation(rotation);
        activeView.attributedView.transform = transform;
            
    } ];
    
   
}

-(void)showReorderLayerAlert
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"skipReorderAlert"])
    {
        return;
    }
    UIAlertView* reorderLayerAlert =[[UIAlertView alloc] initWithTitle:@"Layers widget" message:@"You can reorder layer order by long press - dragging buttons above or below each other within the right panel >>>>>>>>>>" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:@"Do not show again", nil];
    [reorderLayerAlert show];
}

-(void)alertViewCancel:(UIAlertView *)alertView
{
    
}
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == alertView.firstOtherButtonIndex )
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"skipReorderAlert"];
    }
}

@end    

