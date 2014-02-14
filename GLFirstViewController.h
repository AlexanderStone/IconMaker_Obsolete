//
//  GLFirstViewController.h
//  glamourAR
//
//  Created by Mahmood1 on 1/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <AVFoundation/AVFoundation.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "iCarouselExampleViewController.h"
#import "Demo2ViewController.h"
#import "GMGridView.h"
#import "GradientViewController.h"
#import "ColorPickerViewController.h"

#import "QRGenerator.h"
#import "FullScreenProgressViewController.h"

#define kTitleKey @"title"
#define kRotationKey @"rotation"
#define kTopDownOrderKey @"topDownOrder"
#define kTransformKey @"originalTransform"
#define kOriginalXOffset @"originalXOffset"
#define kOriginalYOffset @"originalYOffset"
#define kOriginalZoomScale @"originalZoomScale"
#define kOriginalRotation @"originalRotation"
#define kOriginalAttributedViewRotation @"originalAttributedViewRotation"
#define kOriginalText @"originalText"
#define kOriginalColor @"originalHueShift"
#define kOriginalTransparency @"originalTransparency"
#define kIsReflected @"isReflected"

#define kFrameValue @"Frame"
#define kCameraValue @"Camera"
#define kGlossValue @"Gloss"
#define kTextValue @"Text"
#define kWebValue @"Web"
#define kLogoValue @"Logo"
#define kGradientValue @"Gradient"
#define kOrnamentValue @"Ornament"

@class AttributedView;
@class AttributedImageView;
@class AttributedWebView;
@class AttributedTextField;
@class AttributedTextView;

@class ContainerScrollView;
@class ScalableLayer;

#define kImageCapturedSuccessfully @"imageCapturedSuccessfully"
@class TableViewController;
@class IconFile;

enum    {
    VIEWSOURCE_UIIMAGEVIEW = 1,
    VIEWSOURCE_OPENGLVIEW,
};

enum    {
    CameraDeviceSetting640x480 = 0,
    CameraDeviceSettingHigh = 1,
    CameraDeviceSettingMedium = 2,
    CameraDeviceSettingLow = 3,
};

enum BasicLayerTags
{
    kLayerTagLabel,
    kLayerTagGloss,
    kLayerTagLogo,
    kLayerTagFrame,
    kLayerTagCamera,
    kLayerTagWeb,
    kLayerTagBackground,
    kLayerNumberOfTags
};

@interface GLFirstViewController : UIViewController<AVCaptureVideoDataOutputSampleBufferDelegate,MFMailComposeViewControllerDelegate, UITextFieldDelegate,UIImagePickerControllerDelegate, UITableViewDelegate, UIImagePickerControllerDelegate,iCarouselDelegate,iCarouselDataSource, GMGridViewActionDelegate, GMGridViewDataSource,GMGridViewSortingDelegate, UIGestureRecognizerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate,ColorPickerViewControllerDelegate,QRGeneratorDelegate,UIAlertViewDelegate>
{
    
    UITextAlignment textAlignment; 
    
    UIBarButtonItem* doneButton;
    UIBarButtonItem* previewButton;
     BOOL ignoreImageStream;
    
    NSTimer* animationTimer;
    bool animating;
    bool running;
    
    bool initialLoadFlag;
    ScalableLayer* initialWebViewLayer;
    
    bool useFrontCamera;

    int frameNumber;
    
    UIView* alphaView;
    
    AVCaptureVideoPreviewLayer *previewLayer;
    
    AVCaptureStillImageOutput* imageOutput;
    
    // Device Information
    //
    int cameraCount;
    int currentCameraDeviceIndex;
    int frontCameraDeviceIndex;
    int backCameraDeviceIndex;
    int cameraImageOrientation;
    UIInterfaceOrientation currentDeviceOrientation;
    
    // test layers for augmented screen capture
    //
    UIImageView *backingLayer;
    UIImageView *overlayLayer;
    
    // The primary View for image capture
    // and it's cooresponding view for display
    //
    int currentViewSource; 
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    // Camera Capture, OpenGL and Pixel Manipulation Stuff
    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    //
    //
    AVCaptureDeviceInput *captureInput;
    AVCaptureVideoDataOutput *captureOutput;
    AVCaptureSession *captureSession;
    AVCaptureVideoPreviewLayer *cameraPreviewLayer;
    NSDictionary* videoSettings;
    NSNumber *pixelFormatCode;
    NSString *pixelFormatKey;
    int cameraDeviceSetting;
    
    UIImageView *cameraView;
    UIImage *cameraImage;
    UIImage *cameraImage0;
    UIImage *cameraImage1;
    UIImage* tempImage;
    

    NSNumber* savedRotaion;
    TableViewController* pulseScroller;
}

- (void)captureStillImage;
- (void) activateCameraFeed;
- (void) swapCameras;
- (void) scanForCameraDevices;
- (void) snapShot;
-(void)emailImage:(UIImage*)image;


-(void)hideButtons:(BOOL) hide;
@property(nonatomic)BOOL doTrashIconOnClose;


@property(nonatomic,strong)QRGenerator* qrGenerator;

@property(nonatomic,strong)IconFile* iconFile;
          
@property(nonatomic,strong)iCarouselExampleViewController* carouselController;
@property(nonatomic,strong)Demo2ViewController* layersController;

@property (strong) AVCaptureStillImageOutput *stillImageOutput;
@property (nonatomic, strong) UIImage *stillImage;

@property (weak, nonatomic) IBOutlet AttributedWebView *webView;

@property (weak, nonatomic) IBOutlet UISlider *transparencySlider;

- (IBAction)transparencyChanged:(id)sender;

@property (weak, nonatomic) IBOutlet AttributedImageView *arOverlayView;


- (IBAction)buttonAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGestureRecognizer;
- (IBAction)handlePinch:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)enableDisableOverlayInteraction:(id)sender;

- (IBAction)switchCameraMode:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UISlider *hueSlider;
- (IBAction)hueChanged:(id)sender;
- (IBAction)saveOverlay:(id)sender;

- (IBAction)saveComposite:(id)sender;
- (IBAction)timerAction:(id)sender;
- (IBAction)backArrowAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *forwardButton;


- (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer ;

@property (weak, nonatomic) IBOutlet UIView *toolPanel;

@property (weak, nonatomic) IBOutlet UIButton *modeButton;
@property (weak, nonatomic) IBOutlet UIButton *screenshotButton;
@property (weak, nonatomic) IBOutlet UIButton *cameraModeButton;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton;

@property (weak, nonatomic) IBOutlet UIImageView *timerArrow;
@property (weak, nonatomic) IBOutlet UIButton *saveCompositeButton;

- (IBAction)searchButton:(id)sender;
- (IBAction)helpButtonAction:(id)sender;
- (IBAction)facebookButtonAction:(id)sender;
- (IBAction)preferencesButtonAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;

@property (weak, nonatomic) IBOutlet UIButton *helpButton;
@property (weak, nonatomic) IBOutlet UIButton *loadingButton;

@property (weak, nonatomic) IBOutlet UIButton *preferencesButton;


@property (weak, nonatomic) IBOutlet UILabel *transparencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *hueLabel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@property (strong, nonatomic) IBOutlet UIRotationGestureRecognizer *rotationRecognizer;
- (IBAction)rotateView:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *selectImageLabel;

//additional ipad controls
@property (weak, nonatomic) IBOutlet UIButton *modeButton2;
@property (weak, nonatomic) IBOutlet UIButton *cameraModeButton2;
@property (weak, nonatomic) IBOutlet UIButton *startStopButton2;
@property (weak, nonatomic) IBOutlet UIButton *screenshotButton2;
@property (weak, nonatomic) IBOutlet UIButton *arScreenshotButton2;

@property (weak, nonatomic) IBOutlet UIButton *selectImageButton;

//collection to hide and show labels
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *buttonLabels;

@property (weak, nonatomic) IBOutlet UIView *cameraPanel;

@property (weak, nonatomic) IBOutlet UIImageView *selectionSlider;

@property (weak, nonatomic) IBOutlet UIImageView *appStoreListingIcon;
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneHomeScreenIcon1;

@property (weak, nonatomic) IBOutlet UILabel *iPhoneHomeScreenLabel1;

@property (weak, nonatomic) IBOutlet UITextField *springBoardTextField;




@property (weak, nonatomic) IBOutlet UITextField *companyNameLabel;

@property (weak, nonatomic) IBOutlet UITextField *productNameAppStoreLabel;


@property (weak, nonatomic) IBOutlet UILabel *homeScreenLabel1;
@property (weak, nonatomic) IBOutlet UILabel *homeScreenLabel2;
@property (weak, nonatomic) IBOutlet UILabel *homeScreenLabel3;
@property (weak, nonatomic) IBOutlet UILabel *homeScreenLabel4;

@property (weak, nonatomic) IBOutlet AttributedImageView *glossEffect;


@property (weak, nonatomic) IBOutlet UISwitch *glossSwitch;
- (IBAction)enableDisableGloss:(id)sender;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *glossEffects;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *frames;

@property(nonatomic,strong)NSString* frameName;
- (IBAction)nextFrame:(id)sender;

- (IBAction)previousFrame:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *appTypeLabel;
@property (weak, nonatomic) IBOutlet UIView *iconView;

- (UIImage*)imageByScalingAndCroppingImage:(UIImage*) sourceImage ForSize:(CGSize)targetSize;

@property (weak, nonatomic) IBOutlet UIView *appStoreEntryPanel;
@property (weak, nonatomic) IBOutlet UIView *springBoardIconpanel;

@property (weak, nonatomic) IBOutlet UIView *iconPanel;


@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *iconsForDisplay;

@property (nonatomic, retain) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UITableViewCell *tableView;
@property (weak, nonatomic) IBOutlet UITableView *frameTableView;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@property (weak, nonatomic) IBOutlet AttributedTextView *iconTypeTextField;
@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPressGestureRecognizer;

@property(nonatomic)bool draggingIconLabel;
@property(nonatomic)bool rotatingIconLabel;

- (IBAction)handleLongPress:(id)sender;

@property (weak, nonatomic) IBOutlet AttributedImageView *iconFrame256;
@property (weak, nonatomic) IBOutlet UIImageView *iPadHDIcon;
@property (weak, nonatomic) IBOutlet UIImageView *iPadIcon;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderIcon256;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderIcon144;
@property (weak, nonatomic) IBOutlet UIImageView *placeholderIcon114;

//more than 5 interface elements go into an outlet collection
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *placeholderImageViews;

- (IBAction)dismissController:(id)sender;

@property(nonatomic,strong) NSMutableDictionary* interfaceLayoutDictionary;
-(NSMutableDictionary*)currentInterfaceDictionary;
-(void)interfaceWithIconFile:(IconFile*)iconFile_;

-(void)interfaceWithDictionary:(NSMutableDictionary*)dictionary;

@property (weak, nonatomic) IBOutlet AttributedImageView *logoView;

@property (weak, nonatomic) IBOutlet UIView *maskPanel;
@property (weak, nonatomic) IBOutlet UIView *layersPanel;
@property (nonatomic,strong)NSMutableArray* editableViewLayers;

@property (weak, nonatomic) IBOutlet UIView *scrollVIewCenter;


@property(nonatomic,strong)ContainerScrollView* activeView;
@property(nonatomic,strong)GMGridViewCell* selectedCell;
@property (weak, nonatomic) IBOutlet UIButton *effectButton;

//instrument panels on the bottom
@property (weak, nonatomic) IBOutlet UIView *genericControl;

@property (weak, nonatomic) IBOutlet UIView *photoControl;
@property (weak, nonatomic) IBOutlet UIToolbar *fontControl;
@property (weak, nonatomic) IBOutlet UITableView *frameControl;
@property(nonatomic,strong) UIView* activeControl;
@property (weak, nonatomic) IBOutlet UITableView *glossControl;
@property(nonatomic,strong)TableViewController* glossScroller;
@property (weak, nonatomic) IBOutlet UIView *webViewControl;
@property (weak, nonatomic) IBOutlet UISwitch *enableDisableWebViewSwitch;
- (IBAction)enableDisableWebView:(id)sender;


- (IBAction)changeFont:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *changeFontButton;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *fontSizeButton;



-(NSArray*)generateFontName;
-(AttributedTextView*)activeTextViews;

@property(nonatomic,strong)NSArray* fontNames;
- (IBAction)changeFontSize:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *fontColorButton;
- (IBAction)changeFontColor:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fontAlignmentButton;
- (IBAction)changeFontAlignment:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *clearFontButton;
- (IBAction)clearView:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *fontPickerView;
-(void) resetFontControls;

-(void)setupGradient;
-(void)resetActiveGradientControlForCurrentGradient;
@property(nonatomic,strong)GradientViewController* gradientViewController;
@property (weak, nonatomic) IBOutlet AttributedView *gradientBackground;
@property (weak, nonatomic) IBOutlet UIView *gradientControl;
@property (weak, nonatomic) IBOutlet UIView *topControlPanel;
@property (weak, nonatomic) IBOutlet UIView *controlPanel;

@property (weak, nonatomic) IBOutlet UIView *bottomControlPanel;
@property (weak, nonatomic) IBOutlet UILabel *frameColorLabel;
@property (weak, nonatomic) IBOutlet UILabel *alphaChannelLabel;


- (IBAction)handleTapFrom:(UITapGestureRecognizer*)sender;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
- (IBAction)resetActiveLayer:(id)sender;
@property (weak, nonatomic) IBOutlet AttributedTextView *ornamentView;

//methods to override

-(void)hideNavbar;
-(void)setupFrameContent;
-(NSMutableArray*)setupLayers;
-(void)loadInitialFrame;
-(void)setupAttributesForLayers;
-(void)setupDefaultLayerParameters;
-(void)positionSliders:(bool)activeControlIsFrame;
-(void)setupBordersAndGradients;
@property (nonatomic,strong)NSDateFormatter* dateFormatter;
@property (weak, nonatomic) IBOutlet UIView *frameBoundary;
@property (weak, nonatomic) IBOutlet UIButton *rotateButton;
@property (weak, nonatomic) IBOutlet UIButton *reflectButton;
- (IBAction)reflectView:(id)sender;

- (IBAction)rotateActiveView:(id)sender;

//@property (nonatomic)CMSampleBufferRef sampleBuffer;

-(void)showReorderLayerAlert;

@end
