//
//  PostcardMakerViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/7/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "PostcardMakerViewController.h"
#import "AttributedView.h"
#import <QuartzCore/QuartzCore.h>
#import "AppColors.h"
#import "TableViewController.h"
#import "AttributedImageView.h"
#import "AttributedMapViewController.h"
#import "AppGraphics.h"
#import "AttributedTextView.h"
#import <ImageIO/ImageIO.h>
#import <CoreMedia/CoreMedia.h>
#import "GLAppDelegate.h"

@interface PostcardMakerViewController ()
-(void)addGPSMetadataAndSave;
@end

@implementation PostcardMakerViewController
@synthesize qrCode;
@synthesize mapView;
@synthesize dismissControllerButton;
@synthesize dateView;
@synthesize mapViewController;

@synthesize saveButton;

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
//    self.mapViewController = [[AttributedMapViewController alloc] initWithNibName:@"AttributedMapViewController" bundle:nil];
//    [self.view addSubview:self.mapViewController.view];
//    self.mapViewController.view.frame = self.mapView.frame;
//    [self.mapView removeFromSuperview];
//    self.mapView = self.mapViewController.attributedMapView;
    
//    for(AttributedView* v in self.editableViewLayers)
//    {
//        if(![v isEqual:self.logoView])
//        {
//            for(CALayer* l in v.layer.sublayers)
//            {
//                v.layer.cornerRadius = 12;
//                v.layer.masksToBounds = YES;
//            }
//        }
//    }
    NSLog(@"count: %i",self.editableViewLayers.count);
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:animated animated:animated];
    [super viewWillAppear:animated];
    
   
    UIView* tempView = self.mapView;
    NSLog(@"MAP %.0f, %.0f, %.0f, %.0f",
          tempView.frame.origin.x,
          tempView.frame.origin.y,
          tempView.frame.size.height,
          tempView.frame.size.width);
    
    tempView = self.qrCode;
    NSLog(@"QR %.0f, %.0f, %.0f, %.0f",
          tempView.frame.origin.x,
          tempView.frame.origin.y,
          tempView.frame.size.height,
          tempView.frame.size.width);
    self.dateView.text = [self.dateFormatter stringFromDate:[NSDate date]];

}
-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:animated animated:animated];
    [super viewWillDisappear:animated];
    
}
- (void)viewDidUnload
{
    [self setSaveButton:nil];
    [self setQrCode:nil];

    [self setMapView:nil];
    [self setDismissControllerButton:nil];
    [self setDateView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (IBAction)hideInterface:(id)sender {
    saveButton.selected = !saveButton.selected;
    bool hidden = saveButton.selected;
    
    
    self.layersController.gridView1.hidden = hidden;
    self.layersPanel.hidden = hidden;
    self.bottomControlPanel.hidden = hidden;
    self.transparencySlider.hidden = hidden;
    self.transparencyLabel.hidden = hidden;
    self.alphaChannelLabel.hidden = hidden;
    self.frameColorLabel.hidden = hidden;
    self.hueSlider.hidden = hidden;
    self.hueLabel.hidden =hidden;
    self.saveButton.hidden = hidden;
    self.dismissControllerButton.hidden = hidden;
    self.tapGestureRecognizer.enabled = saveButton.selected;
    
//    [self addGPSMetadataAndSave];
}


-(void)setupFrameContent
{
    [pulseScroller setupForContent:kContentTypePostcards];
}

-(void)loadInitialFrame
{
    self.frameName = @"postcard_7.png";
    
}

-(NSMutableArray*)setupLayers
{
       NSMutableArray* tempSetupArray= [[NSMutableArray alloc] initWithCapacity:10];
    
    [tempSetupArray addObject:self.iconTypeTextField];

    [tempSetupArray addObject:self.logoView];
//    [tempSetupArray addObject:self.glossEffect];
    [tempSetupArray addObject:self.mapView];
    [tempSetupArray addObject:self.qrCode];
    [tempSetupArray addObject:self.dateView];
    [tempSetupArray addObject:self.iconFrame256];
    [tempSetupArray addObject:self.arOverlayView];
    [tempSetupArray addObject:self.webView];
 
//    [tempSetupArray addObject:self.ornamentView];
    [tempSetupArray addObject:self.gradientBackground];
    
    self.qrGenerator.delegate = self;
    [self.qrGenerator askForQR];
   return tempSetupArray;
}

-(void)qRGenerator:(QRGenerator *)generator didLoadImage:(UIImage *)image
{
//    QR code leaves unsightly white around it. reduce the white area's size and increase the image size
//    CGSize scaledSize = CGSizeMake(self.qrCode.frame.size.width*1.3, self.qrCode.frame.size.width*1.3);
//    self.qrCode.image = [AppColors imageByScalingAndCroppingImage:image ForSize:scaledSize];
    
    qrCode.image = image;
}

-(void)setupAttributesForLayers
{
    [super setupAttributesForLayers];
    [self.mapView.attributes setValue:@"Map" forKey:kTitleKey];
    [self.qrCode.attributes setValue:@"QR Code" forKey:kTitleKey];
    
     [self.dateView.attributes  setValue:@"Date" forKey:kTitleKey];
    self.mapView.layer.cornerRadius = self.mapView.frame.size.height/2;
    self.mapView.layer.masksToBounds = YES;

}

-(void)handleTapFrom:(UITapGestureRecognizer *)sender
{
    [super handleTapFrom:sender];
    if(self.saveButton.selected)
    {
        [self hideInterface:saveButton];
        
    }
}

-(void)positionSliders:(bool)activeControlIsFrame
{
    if(activeControlIsFrame)
    {
        self.hueSlider.alpha =1;
        self.frameColorLabel.alpha = 1;
        
        self.alphaChannelLabel.center = CGPointMake(70,18);
        self.transparencySlider.center = CGPointMake(132,20);
    }else {
        self.hueSlider.alpha =0;
        self.frameColorLabel.alpha = 0;
        
        self.alphaChannelLabel.center = CGPointMake(70,30);
        self.transparencySlider.center = CGPointMake(132,30);
    }
    
}


#pragma mark -
#pragma mark MapViewDelegate
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    for(MKAnnotationView *annotationView in views) {
        if(annotationView.annotation == mv.userLocation) {
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            
            span.latitudeDelta=0.1;
            span.longitudeDelta=0.1; 
            
            CLLocationCoordinate2D location_ =mv.userLocation.coordinate;
            
            region.span=span;
            region.center=location_;
            
            [mv setRegion:region animated:YES];
            [mv regionThatFits:region];
        }
    }
}


//-(void)addGPSMetadataAndSave
//{
//    CLLocation* location = self.mapView.userLocation.location;
//    CFDictionaryRef metaDict = CMCopyDictionaryOfAttachments(NULL, NULL, kCMAttachmentMode_ShouldPropagate);
////    CFDictionaryRef metaDict = CMCopyDictionaryOfAttachments(NULL, self.sampleBuffer, kCMAttachmentMode_ShouldPropagate);
//    
//    
//    CFMutableDictionaryRef mutable = CFDictionaryCreateMutableCopy(NULL, 0, metaDict);
//    
//    // Create formatted date
//    NSTimeZone      *timeZone   = [NSTimeZone timeZoneWithName:@"UTC"];
//    NSDateFormatter *formatter  = [[NSDateFormatter alloc] init]; 
//    [formatter setTimeZone:timeZone];
//    [formatter setDateFormat:@"HH:mm:ss.SS"];
//    
//    // Create GPS Dictionary
//    NSDictionary *gpsDict   = [NSDictionary dictionaryWithObjectsAndKeys:
//                               [NSNumber numberWithFloat:fabs(location.coordinate.latitude)], kCGImagePropertyGPSLatitude
//                               , ((location.coordinate.latitude >= 0) ? @"N" : @"S"), kCGImagePropertyGPSLatitudeRef
//                               , [NSNumber numberWithFloat:fabs(location.coordinate.longitude)], kCGImagePropertyGPSLongitude
//                               , ((location.coordinate.longitude >= 0) ? @"E" : @"W"), kCGImagePropertyGPSLongitudeRef
//                               , [formatter stringFromDate:[location timestamp]], kCGImagePropertyGPSTimeStamp
//                               , [NSNumber numberWithFloat:fabs(location.altitude)], kCGImagePropertyGPSAltitude
//                               , nil];  
//    
//    // The gps info goes into the gps metadata part
//    
//    CFDictionarySetValue(mutable, kCGImagePropertyGPSDictionary, (__bridge void *)gpsDict);
//    
//    // Here just as an example im adding the attitude matrix in the exif comment metadata
//    
////    CMRotationMatrix m = att.rotationMatrix;
////    GLKMatrix4 attMat = GLKMatrix4Make(m.m11, m.m12, m.m13, 0, m.m21, m.m22, m.m23, 0, m.m31, m.m32, m.m33, 0, 0, 0, 0, 1);
////    
////    NSMutableDictionary *EXIFDictionary = (__bridge NSMutableDictionary*)CFDictionaryGetValue(mutable, kCGImagePropertyExifDictionary);
//    
////    [EXIFDictionary setValue:NSStringFromGLKMatrix4(attMat) forKey:(NSString *)kCGImagePropertyExifUserComment];
//    
////    CFDictionarySetValue(mutable, kCGImagePropertyExifDictionary, (__bridge void *)EXIFDictionary);
//    
////    NSData *jpeg = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageSampleBuffer] ;
//    CGSize iPhoneRetinaIconSize = CGSizeMake(320,480);
//    //    CGSize iPhoneRetinaIconSize = CGSizeMake(57,57);
//    
//    GLAppDelegate* appDelegate =     [UIApplication sharedApplication].delegate;
//    
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
//        UIGraphicsBeginImageContextWithOptions(iPhoneRetinaIconSize, NO, [UIScreen mainScreen].scale);
//    //    UIGraphicsBeginImageContextWithOptions(iPhoneRetinaIconSize, NO, 0.5);
//    else
//        UIGraphicsBeginImageContext(iPhoneRetinaIconSize);
//    
//    //    UIGraphicsBeginImageContext(CGSizeMake(57,57));
//    [appDelegate.window.layer renderInContext:UIGraphicsGetCurrentContext()];
//    
//    ////    UIImage *screenshot = [ScreenCapture UIViewToImage:self.view];
//    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
//    
//    NSData* png = UIImagePNGRepresentation(screenshot);
//    
//    CGImageSourceRef  source ;
//    source = CGImageSourceCreateWithData((__bridge CFDataRef)png, NULL);
//    
//    CFStringRef UTI = CGImageSourceGetType(source); //this is the type of image (e.g., public.jpeg)
//    
//    NSMutableData *dest_data = [NSMutableData data];
//    
//    
//    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)dest_data,UTI,1,NULL);
//    
//    if(!destination) {
//        NSLog(@"***Could not create image destination ***");
//    }
//    
//    //add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
//    CGImageDestinationAddImageFromSource(destination,source,0, (CFDictionaryRef) mutable);
//    
//    //tell the destination to write the image data and metadata into our data object.
//    //It will return false if something goes wrong
//    BOOL success = NO;
//    success = CGImageDestinationFinalize(destination);
//    
//    if(!success) {
//        NSLog(@"***Could not create data from image destination ***");
//    }
//    
//    //now we have the data ready to go, so do whatever you want with it
//    //here we just write it to disk at the same path we were passed
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
//    NSString *documentsDirectory = [paths objectAtIndex:0]; // Get documents folder
//    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:@"ImagesFolder"];
//    
//    NSError *error;
//    if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath])
//        [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:&error]; //Create folder
//    
//    NSString *imageName = @"ImageName";
//    
//    NSString *fullPath = [dataPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg", imageName]]; //add our image to the path
//    
//    [dest_data writeToFile:fullPath atomically:YES];
//    
//    //cleanup
//    
//    CFRelease(destination);
//    CFRelease(source);
//}

@end
