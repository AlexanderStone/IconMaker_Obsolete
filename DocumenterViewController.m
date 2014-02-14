//
//  DocumenterViewController.m
//  glamourAR
//
//  Created by Mahmood1 on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DocumenterViewController.h"

#import "AppController.h"
#import "PaintingView.h"
#import "SoundEffect.h"
#import "DeleteViewButton.h"
#import "DragAndDropLabel.h"
#import <QuartzCore/QuartzCore.h>
#import "GLAppDelegate.h"
#import "AppGraphics.h"

//CONSTANTS:

#define kPaletteHeight			30
#define kPaletteSize			5
#define kMinEraseInterval		0.5

// Padding for margins
#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kRightMargin			10.0

#define kSmallFontSize 11

//FUNCTIONS:
/*
 HSL2RGB Converts hue, saturation, luminance values to the equivalent red, green and blue values.
 For details on this conversion, see Fundamentals of Interactive Computer Graphics by Foley and van Dam (1982, Addison and Wesley)
 You can also find HSL to RGB conversion algorithms by searching the Internet.
 See also http://en.wikipedia.org/wiki/HSV_color_space for a theoretical explanation
 */
static void HSL2RGB(float h, float s, float l, float* outR, float* outG, float* outB)
{
	float			temp1,
    temp2;
	float			temp[3];
	int				i;
	
	// Check for saturation. If there isn't any just return the luminance value for each, which results in gray.
	if(s == 0.0) {
		if(outR)
			*outR = l;
		if(outG)
			*outG = l;
		if(outB)
			*outB = l;
		return;
	}
	
	// Test for luminance and compute temporary values based on luminance and saturation 
	if(l < 0.5)
		temp2 = l * (1.0 + s);
	else
		temp2 = l + s - l * s;
    temp1 = 2.0 * l - temp2;
	
	// Compute intermediate values based on hue
	temp[0] = h + 1.0 / 3.0;
	temp[1] = h;
	temp[2] = h - 1.0 / 3.0;
    
	for(i = 0; i < 3; ++i) {
		
		// Adjust the range
		if(temp[i] < 0.0)
			temp[i] += 1.0;
		if(temp[i] > 1.0)
			temp[i] -= 1.0;
		
		
		if(6.0 * temp[i] < 1.0)
			temp[i] = temp1 + (temp2 - temp1) * 6.0 * temp[i];
		else {
			if(2.0 * temp[i] < 1.0)
				temp[i] = temp2;
			else {
				if(3.0 * temp[i] < 2.0)
					temp[i] = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - temp[i]) * 6.0;
				else
					temp[i] = temp1;
			}
		}
	}
	
	// Assign temporary values to R, G, B
	if(outR)
		*outR = temp[0];
	if(outG)
		*outG = temp[1];
	if(outB)
		*outB = temp[2];
}


@implementation DocumenterViewController

@synthesize fontStyleToolbar;
@synthesize dismissStyleToolbar;
@synthesize fontSizeBar;
@synthesize fontSizeBarFontSizeButton;
@synthesize fontSizeSlider;
@synthesize fontSizeStepper;
@synthesize componentControlsToolbar;
@synthesize paintToolbar;
@synthesize companionLabels;
@synthesize fontNameButton;
@synthesize fontSizeButton;
@synthesize documentPanel;
@synthesize sampleLabelView;
@synthesize paintingView;
@synthesize toolPanel;
@synthesize labelViews;
@synthesize editingToolbar;

@synthesize activeCompanionLabelView;
@synthesize longPressGestureRecognizer;
@synthesize rotationGestureRecognizer;
@synthesize tapGestureRecognizer;
@synthesize pinchGestureRecognizer;

@synthesize imagePicker;
@synthesize backgroundImage;
@synthesize hideDrawingPanel;
@synthesize colorSelectorSegmentedControl;

@synthesize fontPicker = __fontPicker;
@synthesize fontNames;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [paintingView setBrushColorWithRed:1 green:1 blue:1];
    
    
    
    imagePicker =  [[UIImagePickerController alloc] init];
	self.imagePicker.delegate = self;
    
	// Load the sounds
	NSBundle *mainBundle = [NSBundle mainBundle];	
	erasingSound = [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Erase" ofType:@"caf"]];
	selectSound =  [[SoundEffect alloc] initWithContentsOfFile:[mainBundle pathForResource:@"Select" ofType:@"caf"]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(eraseView) name:@"shake" object:nil];
    
    [tapGestureRecognizer requireGestureRecognizerToFail:longPressGestureRecognizer];
    [tapGestureRecognizer requireGestureRecognizerToFail:rotationGestureRecognizer];
    [tapGestureRecognizer requireGestureRecognizerToFail:pinchGestureRecognizer];
    
    tapGestureRecognizer.cancelsTouchesInView = NO;
    
//    [pinchGestureRecognizer requireGestureRecognizerToFail:rotationGestureRecognizer];
//    
    UIFont* regularFont = [UIFont systemFontOfSize:11];
    
    for(DragAndDropLabel* v in companionLabels)
    {
//        v.layer.cornerRadius = 9;
//        v.layer.masksToBounds = YES;
        
        if([v.textView.font.fontName isEqualToString:regularFont.fontName])
        {
            
            UIFont* eurostile = [UIFont fontWithName:@"Eurostile" size:v.textView.font.pointSize];
            v.textView.font = eurostile;
        }
//        for(UIView* subview in v.subviews)
//        {
//            subview.layer.cornerRadius = 9;
//            subview.layer.masksToBounds = YES;
//        }
    }

    
}


- (void)viewDidUnload
{
    [self setPaintingView:nil];
    [self setToolPanel:nil];
    [self setSampleLabelView:nil];
    [self setDocumentPanel:nil];
    [self setEditingToolbar:nil];
    [self setFontSizeButton:nil];
    [self setFontNameButton:nil];
    [self setCompanionLabels:nil];
    [self setLongPressGestureRecognizer:nil];
    [self setTapGestureRecognizer:nil];
    [self setRotationGestureRecognizer:nil];
    [self setPinchGestureRecognizer:nil];
    [self setBackgroundImage:nil];
    [self setHideDrawingPanel:nil];
    [self setColorSelectorSegmentedControl:nil];
    [self setComponentControlsToolbar:nil];
    [self setPaintToolbar:nil];
    [self setDismissStyleToolbar:nil];
    [self setFontStyleToolbar:nil];
    [self setFontSizeBar:nil];
    [self setFontSizeBarFontSizeButton:nil];
    [self setFontSizeSlider:nil];
    [self setFontSizeStepper:nil];

    [self setToolPanel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (IBAction)eraseView:(id)sender {
    
    if(CFAbsoluteTimeGetCurrent() > lastTime + kMinEraseInterval) {
		[erasingSound play];
		[paintingView erase];
		lastTime = CFAbsoluteTimeGetCurrent();
	}
}

#pragma mark -
#pragma mark UIGestureRecognizer Delegate
//makes 2 gesture recognizers behave together
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

-(void)positionForLongPressWithView:(DragAndDropLabel*)view Location:(CGPoint)location
{ //pretend that the label is being held by the bottom right corner
     view.center = CGPointMake(location.x-view.textView.frame.size.width/2, location.y-view.textView.frame.size.height/2);
}

- (IBAction)handleLongPress:(UILongPressGestureRecognizer*)gesture {
    
    
    if(UIGestureRecognizerStateBegan == gesture.state) {
        // Do initial work here
        
        CGPoint location = [gesture locationInView:self.documentPanel];
        bool longpressOnLabel = NO;
        for(DragAndDropLabel* v in companionLabels)
        {
            if(v.alpha >0 && CGRectContainsPoint(v.frame, location))
                {
                    activeCompanionLabelView = v;
                    activeLabelContainerFrame = v.frame;

                    [self positionForLongPressWithView:v Location:location];
                    
                    longpressOnLabel = YES;
                    break;
                }
        }
        
        if(!longpressOnLabel)
        {
            for (UIView* v in companionLabels)
            {
                if(v.superview == nil)
                {
                    [self.documentPanel addSubview:v];
                    [UIView animateWithDuration:0.3 animations:^{
                        v.alpha = 1;
                        v.center = location;
                    }];
                    
                    break;
                }
            }
        }
        

    }
    
    if(UIGestureRecognizerStateChanged == gesture.state) {
        // Do repeated work here (repeats continuously) while finger is down
        
        CGPoint location = [gesture locationInView:self.documentPanel];

        [self positionForLongPressWithView:activeCompanionLabelView Location:location];
         
    }
    
    if(UIGestureRecognizerStateEnded == gesture.state) {
        // Do end work here when finger is lifted
        
    }
    
}

- (IBAction)buttonWillDelete:(id)sender {
    if([sender isKindOfClass:[DeleteViewButton class]])
    {
        [((DeleteViewButton*)sender) deleteViewActionWithSender:sender];
    }
    
    
    
}

-(void)updateFontStyleControls
{
    UITextView* textView = activeCompanionLabelView.textView;
    
    NSString* trimmedFontName = activeCompanionLabelView.textView.font.fontName ;
    if(textView.font.fontName.length>11)
    {
        trimmedFontName = [textView.font.fontName substringToIndex:11] ;
    }
    fontNameButton.title = trimmedFontName;
    
    float size = textView.font.pointSize ;
    
    
    fontSizeButton.title = [NSString stringWithFormat:@"%.1f",size];
    fontSizeBarFontSizeButton.title = fontSizeButton.title ;
    fontSizeSlider.value = size;
    fontSizeStepper.value = size;
    
}
#pragma mark -
#pragma mark UITextViewDelegate

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    activeCompanionLabelView = (DragAndDropLabel*)textView.superview;
    
    //initialize font size related controls
    [self updateFontStyleControls];

    
    editingToolbar.alpha = 1;
    
    if(activeCompanionLabelView.center.y >200)
    {
        [ UIView animateWithDuration:0.4 animations:^{
            documentPanel.center = CGPointMake(160, 20);
            
        } completion:^(BOOL finished) {
            
        } ];
        
    }
    return YES;
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    editing = YES;
    activeCompanionLabelView = (DragAndDropLabel*)textView.superview;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    //avoid interfering with the long press for position purposes
    textView.userInteractionEnabled = NO;
    
    editing = NO;
//    editingToolbar.alpha = 0;
//    fontStyleToolbar.alpha = 0;
    
    [ UIView animateWithDuration:0.4 animations:^{
        documentPanel.center = CGPointMake(160, 240);
        
    } completion:^(BOOL finished) {
        
    } ];

}


- (IBAction)doneEditing:(id)sender {
    
    for(DragAndDropLabel* v in companionLabels)
    {
        [v.textView resignFirstResponder];
    }
    [activeCompanionLabelView.textView resignFirstResponder];
    
    //extra check to bring down the panel
    if(!CGPointEqualToPoint(documentPanel.center,  CGPointMake(160,240)) )
    {
        [UIView animateWithDuration:0.4 animations:^{
            documentPanel.center =  CGPointMake(160,240);
            editingToolbar.alpha = 0;
        } ];
        
    }
}

- (IBAction)clearLabel:(id)sender {
    activeCompanionLabelView.textView.text = @"";
}


- (IBAction)deleteLabel:(id)sender {
    [activeCompanionLabelView resignFirstResponder];
    [activeCompanionLabelView.deleteButton deleteViewActionWithSender:self];
}


-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    
//    if([gestureRecognizer isEqual:rotationGestureRecognizer])
//    {
//        activeCompanionLabelView.savedRotation=   [[NSUserDefaults standardUserDefaults] floatForKey:@"outerDialRotation"];;
//    }
    
    if(drawingMode && [self.documentPanel.gestureRecognizers containsObject:gestureRecognizer])return NO;
   
    if([gestureRecognizer isEqual:pinchGestureRecognizer])
    {
        switch (rotationGestureRecognizer.state) {
            case  UIGestureRecognizerStateBegan:
                NSLog(@"UIGestureRecognizerStateBegan");
                return NO;
                break;
            case  UIGestureRecognizerStateChanged:
                NSLog(@"UIGestureRecognizerStateChanged");
                return NO;
                break;
                
            case  UIGestureRecognizerStateRecognized:
                NSLog(@"UIGestureRecognizerStateRecognized");
                return NO;
                break;
            case  UIGestureRecognizerStateFailed:
                NSLog(@"UIGestureRecognizerStateFailed");
                return YES;
                break;
            default:
                return YES;
                break;
        }

    }
    
    if(editing && [gestureRecognizer isEqual:longPressGestureRecognizer])
    {
        return NO;
    }
    
    return YES;
}



- (IBAction)handleTapFrom:(id)sender {
    NSLog(@"Tap");
    
//    [self autoHideToolsPanel:nil] ;
    //check if the user has tapped out of the text field
    bool doResignFirstResponder = YES;
    CGPoint location = [tapGestureRecognizer locationInView:self.documentPanel];
    for(DragAndDropLabel* v in companionLabels)
    {
        NSLog(@"%.0f,%.0f,%.0f,%.0f",v.frame.origin.x, v.frame.origin.y, v.frame.size.height, v.frame.size.width);
        
        CGPoint locationForDeleteButton = [tapGestureRecognizer locationInView:v];
        
        if( v.alpha>0 && CGRectContainsPoint(v.frame, location))
        {
            
             NSLog(@"[%.0f,%.0f] [%.0f,%.0f,%.0f,%.0f]",locationForDeleteButton.x,locationForDeleteButton.y, v.deleteButton.frame.origin.x, v.deleteButton.frame.origin.y, v.deleteButton.frame.size.height, v.deleteButton.frame.size.width);
            
            //selected the view, allow editing of it
            if(!CGRectContainsPoint(v.deleteButton.frame, locationForDeleteButton))
            {
                v.textView.userInteractionEnabled = YES;
                [v.textView becomeFirstResponder];
            }else {
                [v.deleteButton deleteViewActionWithSender:self];
//                doResignFirstResponder= YES;
            }
            doResignFirstResponder = NO;
            break;
        }
    }
    if(doResignFirstResponder)
    {
        [activeCompanionLabelView.textView resignFirstResponder];
    }   
}

- (IBAction)handleRotationFrom:(id)sender {
    NSLog(@"Gesture rotation %.1f", rotationGestureRecognizer.rotation);
//    
//    
//    
    float rotation = activeCompanionLabelView.savedRotation;
//    float rotation = atan2(activeCompanionLabelView.transform.b, activeCompanionLabelView.transform.a);
//    NSLog(@"existing rotation %.1f", rotation);
//    
////    rotation = rotation<0?(2*M_PI)-fabs(rotation):rotation;
//    rotation +=rotationGestureRecognizer.rotation;
    
    NSLog(@"*** gesture rotation %.1f sum: %.1f, saved: %.1f",rotationGestureRecognizer.rotation, rotation, activeCompanionLabelView.savedRotation);
    if(rotationGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        activeCompanionLabelView.transform = CGAffineTransformMakeRotation((rotationGestureRecognizer.rotation));
    }
    activeCompanionLabelView.savedRotation = rotationGestureRecognizer.rotation;
    
    
}

- (IBAction)handlePinch:(id)sender {
    
    
        switch (rotationGestureRecognizer.state) {
            case  UIGestureRecognizerStateBegan:
                NSLog(@"UIGestureRecognizerStateBegan");
                return;
                break;
            case  UIGestureRecognizerStateChanged:
                NSLog(@"UIGestureRecognizerStateChanged");
                return;
                break;
                
            case  UIGestureRecognizerStateRecognized:
                NSLog(@"UIGestureRecognizerStateRecognized");
                return;
                break;
            case  UIGestureRecognizerStateFailed:
                NSLog(@"UIGestureRecognizerStateFailed");
                
                break;
            default:
               
                break;
        }
    NSLog(@"pinch %.2f", pinchGestureRecognizer.scale);

    if(pinchGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        
        activeCompanionLabelView.frame = CGRectMake(activeLabelContainerFrame.origin.x, activeLabelContainerFrame.origin.y, activeLabelContainerFrame.size.width*pinchGestureRecognizer.scale, activeLabelContainerFrame.size.height*pinchGestureRecognizer.scale);    
    }
    
    
}

- (IBAction)activateDrawing:(id)sender {
    
    paintingView.userInteractionEnabled = YES;
    //disable the gestures, hoping this would help the UIResponder process gestures moved events
    tapGestureRecognizer.enabled = NO;
    rotationGestureRecognizer.enabled = NO;
    pinchGestureRecognizer.enabled = NO;
    longPressGestureRecognizer.enabled = NO;
    for(UIView* v in companionLabels)
    {     v.userInteractionEnabled = NO;
    }
    drawingMode = YES;
    
    [UIView animateWithDuration:0.4 animations:^{
        componentControlsToolbar.alpha = 0;
        paintToolbar.alpha = 1;
    } ];
    
}

- (IBAction)activateLabels:(id)sender {
    paintingView.userInteractionEnabled =NO;
    
    //reactivate gestures and views
    tapGestureRecognizer.enabled = YES;
    rotationGestureRecognizer.enabled = YES;
    pinchGestureRecognizer.enabled = YES;
    longPressGestureRecognizer.enabled = YES;
    for(UIView* v in companionLabels)
    {     v.userInteractionEnabled = YES;
    }
    drawingMode = NO;
    
    [UIView animateWithDuration:0.4 animations:^{

        paintToolbar.alpha = 0;
    } ];
    
}

- (IBAction)selectBackground:(id)sender {
    
    [self presentModalViewController:self.imagePicker animated:YES];
}
#pragma mark image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	backgroundImage.image = img;	
	[self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    backgroundImage.image = nil;
    [self dismissModalViewControllerAnimated:YES];

}
- (IBAction)changeColor:(id)sender {
    
    switch (colorSelectorSegmentedControl.selectedSegmentIndex) {
        case 0:
            [paintingView setBrushColorWithRed:1 green:1 blue:1];
            break;
        case 1:
             [paintingView setBrushColorWithRed:1 green:0 blue:0];
            break;
        case 2:
             [paintingView setBrushColorWithRed:0 green:1 blue:0];
            break;
        case 3:
             [paintingView setBrushColorWithRed:0 green:0 blue:1];
            break;
        case 4: 
             [paintingView setBrushColorWithRed:0 green:0 blue:0];
            break;
        default:
             [paintingView setBrushColorWithRed:1 green:1 blue:1];
            break;
    }
}
- (IBAction)hidePaintPanel:(id)sender {
   
    
    [UIView animateWithDuration:0.4 animations:^{
        componentControlsToolbar.alpha = 1;
        paintToolbar.alpha = 0;
    } completion:^(BOOL finished) {
        [self activateLabels:nil];
    } ];
    
}


#pragma mark -
#pragma mark EMAIL IMAGE

-(void)displayComposerSheetWithImage:(UIImage*)image andData:(NSMutableData*) pdfData
{
    MFMailComposeViewController *picker = [MFMailComposeViewController alloc];
    picker = [picker init];


    picker.mailComposeDelegate = self;
    
    NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterFullStyle;
    
    // ATTACHING A SCREENSHOT
    
   
    NSData *myData = UIImagePNGRepresentation(image);
    
    [picker addAttachmentData:myData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"%@",@"documentation.png"]];     
    
    [picker addAttachmentData:pdfData mimeType:@"application/pdf" fileName:[NSString stringWithFormat:@"%@",@"documentation.pdf"]];     
    

    NSString* filename = @"iPhone App documentation ";
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
    NSString *emailBody = @"Attached is overlay documentation ";                         
                           
    [picker setMessageBody:emailBody isHTML:NO];
    [self presentModalViewController:picker animated:YES];
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    
}


- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error 
{   
   
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
    //restore the buttons after the email has been dispatched
    for(DragAndDropLabel* v in companionLabels)
    {
        v.deleteButton.alpha = 1;
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)emailDocumentation:(id)sender {

    //hide the extra buttons
    for(DragAndDropLabel* v in companionLabels)
    {
        v.deleteButton.alpha = 0;
    }
    
    CGSize iPhoneRetinaIconSize = CGSizeMake(320,480);
    
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
        UIGraphicsBeginImageContextWithOptions(iPhoneRetinaIconSize, NO, [UIScreen mainScreen].scale);
    
    else
        UIGraphicsBeginImageContext(iPhoneRetinaIconSize);
    
    
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    
    UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    [self displayComposerSheetWithImage:screenshot andData:[AppGraphics createPDFDatafromUIView:self.view]];
    
}

- (IBAction)dismissModalDialog:(id)sender {
   [ self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
   }];
}

- (IBAction)showStyleToolbar:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        fontStyleToolbar.alpha = 1;
    } ];
}
- (IBAction)hideStyleToolbar:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        fontStyleToolbar.alpha = 0;
    } ];
}

- (IBAction)fontSizeChanged:(id)sender {
    if([sender isKindOfClass:[UIStepper class]])
    {
        fontSizeSlider.value = fontSizeStepper.value ;
        
        
    } else if([sender isKindOfClass:[UISlider class]])
    {
        fontSizeStepper.value = fontSizeSlider.value ;
        
    }else{
        
    }
    fontSizeButton.title = [NSString stringWithFormat:@"%.1f",fontSizeStepper.value ];
    fontSizeBarFontSizeButton.title = fontSizeButton.title ;
    
    activeCompanionLabelView.textView.font = [UIFont fontWithName:@"Eurostile" size:fontSizeStepper.value];


}

- (IBAction)hideFontSizeBar:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        fontSizeBar.alpha = 0;
    } ];
}

- (IBAction)changeFont:(id)sender {
    
    [activeCompanionLabelView.textView resignFirstResponder];
    GLAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:self.fontPicker];
    self.fontPicker.center = CGPointMake(160,320);
    
//    [self.view addSubview:self.fontPicker];
    
//     [self.view addSubview:self.fontPicker];
    
    
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    
    [activeCompanionLabelView.textView setFont:[UIFont fontWithName:[fontNames objectAtIndex:row] size:activeCompanionLabelView.textView.font.pointSize]];
    
    [self updateFontStyleControls];
    
    [self.fontPicker removeFromSuperview];
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

-(NSArray*)generateFontNames
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
//    NSArray *fontNames;
//    NSInteger indFamily, indFont;
//    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
//    {
//        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
//        fontNames = [[NSArray alloc] initWithArray:
//                     [UIFont fontNamesForFamilyName:
//                      [familyNames objectAtIndex:indFamily]]];
//        for (indFont=0; indFont<[fontNames count]; ++indFont)
//        {
//            NSLog(@"    Font name: %@", [fontNames objectAtIndex:indFont]);
//        }
//        [fontNames release];
//    }
    return familyNames;
}

-(UIPickerView*)fontPicker
{
    if(__fontPicker!=nil)
    {
        return __fontPicker;
    }
    
    self.fontPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0,100,320,240)];

    
    self.fontNames = [self generateFontNames];
    
    __fontPicker.dataSource = self;
    __fontPicker.delegate = self;
    
    [self.view addSubview:__fontPicker];
    __fontPicker.center = CGPointMake(160,140);
    
    
    return __fontPicker;
    
}

- (IBAction)changeFontSize:(id)sender {
    //displays the font size panel
    [UIView animateWithDuration:0.3 animations:^{
        fontSizeBar.alpha = 1;
    } ];
}


-(void)autoHideToolsPanel:(id)sender
{
    [UIView animateWithDuration:0.4 animations:^{
        toolPanel.alpha = toolPanel.alpha>0?0:1;
    }];
}



@end
