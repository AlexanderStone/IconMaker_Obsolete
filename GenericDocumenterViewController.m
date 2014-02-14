//
//  GenericDocumenterViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/7/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "GenericDocumenterViewController.h"
#import "PaintingView.h"
#import "ContainerScrollView.h"

#define kPaintValue @"Paint"
@interface GenericDocumenterViewController ()

@end

@implementation GenericDocumenterViewController
@synthesize paintControl;
@synthesize paintBrushColor;
@synthesize stickyNote1;
@synthesize stickyNote2;
@synthesize previewContainer;
@synthesize paintingView;
@synthesize panGestureRecognizer;

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
    NSLog(@"Documenter");
    [super viewDidLoad];
    
    [paintingView setBrushColorWithRed:1 green:1 blue:1];
    
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
//    self.previewContainer.transform = CGAffineTransformScale(self.previewContainer.transform, 0.8, 0.8);
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    self.previewContainer.transform = CGAffineTransformIdentity;
}
- (void)viewDidUnload
{
    [self setStickyNote1:nil];
    [self setStickyNote2:nil];
    [self setPreviewContainer:nil];
    [self setPaintingView:nil];
    [self setPanGestureRecognizer:nil];
    [self setPaintControl:nil];
    [self setPaintBrushColor:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(NSMutableArray*)setupLayers
{
    NSMutableArray* tempSetupArray= [[NSMutableArray alloc] initWithCapacity:10];
    
    [tempSetupArray addObject:self.iconTypeTextField];
    [tempSetupArray addObject:self.iconFrame256];
    [tempSetupArray addObject:stickyNote1];
    [tempSetupArray addObject:stickyNote2];
    [tempSetupArray addObject:paintingView];
    [tempSetupArray addObject:self.gradientBackground];
    [tempSetupArray addObject:self.arOverlayView];

   
//    [tempSetupArray addObject:self.mapView];
//    //    [tempSetupArray addObject:self.ornamentView];
//    [tempSetupArray addObject:self.gradientBackground];
    
    return tempSetupArray;
}
-(void)setupAttributesForLayers
{
    [super setupAttributesForLayers];
    [self.stickyNote1.attributes setValue:@"Sticky1" forKey:kTitleKey];
    [self.stickyNote2.attributes setValue:@"Sticky2" forKey:kTitleKey];
    [self.paintingView.attributes setValue:kPaintValue forKey:kTitleKey];
    
    
    for(ContainerScrollView* container in self.editableViewLayers)
    {
        if([container.attributedView isEqual:self.paintingView])
        {
            container.scrollEnabled = NO;
            paintingView.panMode = YES;
        }
    }
}
-(void)loadInitialFrame
{
    self.frameName = @"postcard_5.png";
    
}

-(void)positionSliders:(bool)activeControlIsFrame
{
    [super positionSliders:activeControlIsFrame];
}

- (IBAction)handlePan:(id)sender {
//    CGPoint location = [panGestureRecognizer locationInView:self.view];
//    NSLog(@"%.0f, %.0f",location.x, location.y);
    [self.paintingView drawLineWithGestureRecognizer:panGestureRecognizer];
}

- (IBAction)erasePaintingView:(id)sender {
    [self.paintingView erase];
}

- (IBAction)changePaintColor:(id)sender {
    ColorPickerViewController* standIn = [[ColorPickerViewController alloc] initWithNibName:@"ColorPickerViewController" bundle:nil];
    standIn.delegate = self;
    standIn.defaultsColor = self.paintingView.brushColor;
    
    [self presentModalViewController:standIn animated:YES];
}

-(void)GMGridView:(GMGridView *)gridView didTapOnItemAtIndex:(NSInteger)position
{
    [super GMGridView:gridView didTapOnItemAtIndex:position];
    
//    GMGridViewCell* cell =    [gridView cellForItemAtIndex:position];
    ContainerScrollView* v = nil;
    v =[self.editableViewLayers objectAtIndex:position];
     NSString* title = [v.attributedView.attributes valueForKey:kTitleKey];
    if([title isEqualToString:kPaintValue])
    {
        self.activeControl =paintControl;
    }
}
-(void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color
{
    [super colorPickerViewController:colorPicker didSelectColor:color];
    if([self.activeControl isEqual:self.paintControl])
    {
        CGFloat red ;
        CGFloat green ;
        CGFloat blue;
        CGFloat alpha;
        [color getRed:&red green:&green blue:&blue alpha:&alpha];
        
       [paintingView setBrushColorWithRed:red green:green blue:blue];
        self.paintBrushColor.tintColor = paintingView.brushColor;
        
    }
    
}

- (IBAction)hidePaintingViewControls:(id)sender {
    [UIView animateWithDuration:0.3 animations:^{
        self.paintControl.alpha = 0;
    }];
}
@end
