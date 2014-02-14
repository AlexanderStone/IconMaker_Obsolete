//
//  GradientViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 3/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "GradientViewController.h"

#import "StandinViewController.h"
#import "ColorPickerViewController.h"
#import "AttributedView.h"
#import <QuartzCore/QuartzCore.h>

@interface GradientViewController ()

@end

@implementation GradientViewController
@synthesize roundedCornerViews;
@synthesize gradientContainer;
@synthesize gradientContainer1;
@synthesize gradientContainer3;
@synthesize gradientControl;
@synthesize gradientSliders;
@synthesize parentContainerController;
@synthesize topColor;
@synthesize bottomColor;
@synthesize activeColor;
@synthesize gradientTopButton;
@synthesize gradientBottomButton;
@synthesize gradientLayer;
@synthesize activeGradientView;
@synthesize gradientLayerStyle1;
@synthesize gradientLayerStyle2;
@synthesize gradientLayerStyle3;

@synthesize gradientLayer1;
@synthesize gradientLayer2;
@synthesize gradientLayer3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        topColor = [UIColor whiteColor];
        bottomColor = [UIColor blueColor];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    gradientStartPoint = CGPointMake(0.5, 0);
    gradientEndPoint = CGPointMake(0.5,1);
    [self setupGradient];

    for(UIView* v in self.roundedCornerViews)
    {
        v.layer.cornerRadius = 8;
        v.layer.masksToBounds = YES;
        v.layer.shadowRadius = 5;
        
    }
    
}

- (void)viewDidUnload
{
    [self setGradientControl:nil];
    [self setGradientSliders:nil];
    [self setGradientTopButton:nil];
    [self setGradientBottomButton:nil];
    [self setGradientContainer:nil];
    [self setGradientLayerStyle1:nil];
    [self setGradientLayerStyle2:nil];
    [self setGradientLayerStyle3:nil];
    [self setGradientContainer1:nil];
    [self setGradientContainer3:nil];
    [self setRoundedCornerViews:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (void) draggedOut: (UIControl *) c withEvent: (UIEvent *) ev {
    NSLog(@"Gradient drag");

    c.center = [[[ev allTouches] anyObject] locationInView:self.view];
}

-(void)prepareAndPresentModalControllerWithColor:(UIColor*)color
{
    ColorPickerViewController* standIn = [[ColorPickerViewController alloc] initWithNibName:@"ColorPickerViewController" bundle:nil];
    standIn.delegate = self;
    standIn.defaultsColor = color;
    [self.parentContainerController presentModalViewController:standIn animated:YES];

}

- (IBAction)pickGradientTopColor:(id)sender {
    NSLog(@"Gradient top tap");
    activeColor = topColor;
    [self prepareAndPresentModalControllerWithColor:activeColor];
    
}

- (IBAction)pickGradientBottomColor:(id)sender {
     NSLog(@"Gradient bottom tap");
    activeColor = bottomColor;
    [self prepareAndPresentModalControllerWithColor:activeColor];
    
}
- (void)colorPickerViewController:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color
{

    if([activeColor isEqual:topColor])
    {
        self.topColor = color;
    } else if([activeColor isEqual:bottomColor])
    {
        self.bottomColor = color;
    }
    
    
    
    [self.parentContainerController dismissModalViewControllerAnimated:YES];
}

-(void)setTopColor:(UIColor *)topColor_
{
    topColor = topColor_;
    gradientTopButton.imageView.backgroundColor = topColor_;
    gradientTopButton.backgroundColor = topColor_;
    [self setupGradient];
}

-(void)setBottomColor:(UIColor *)bottomColor_
{
    bottomColor = bottomColor_;
    gradientBottomButton.imageView.backgroundColor = bottomColor_;
    gradientBottomButton.backgroundColor = bottomColor_;
    [self setupGradient];
}

-(void)setupGradientButtons
{
    CAGradientLayer* tempGradientLayer = gradientLayer1;
    //clear layers before adding new ones

    
    [tempGradientLayer removeFromSuperlayer];
    tempGradientLayer = [CAGradientLayer layer];
    
    tempGradientLayer.startPoint = CGPointMake(0, 0);
    tempGradientLayer.endPoint = CGPointMake(1,1);
    tempGradientLayer.frame = gradientContainer1.bounds;
    tempGradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [gradientContainer1.layer addSublayer:tempGradientLayer];
//    [gradientContainer1.layer insertSublayer:tempGradientLayer atIndex:0];
    
    tempGradientLayer = gradientLayer3;
    //clear layers before adding new ones
    
    
    [tempGradientLayer removeFromSuperlayer];
    tempGradientLayer = [CAGradientLayer layer];
    
    tempGradientLayer.startPoint = CGPointMake(1, 0);
    tempGradientLayer.endPoint = CGPointMake(0,1);
    tempGradientLayer.frame = gradientContainer3.bounds;
    tempGradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [gradientContainer3.layer addSublayer:tempGradientLayer];
//    [gradientContainer3.layer insertSublayer:tempGradientLayer atIndex:0];
    

   
}

-(void)setupGradient
{
    //layer for display purposes
    [gradientLayer removeFromSuperlayer];
    gradientLayer = [CAGradientLayer layer];

    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.frame = gradientContainer.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
    [gradientContainer.layer addSublayer:gradientLayer];
//    [gradientContainer.layer insertSublayer:gradientLayer atIndex:0];
    [self setupGradientButtons];    
    
    
//    actual layer in the icon
    
    gradientLayer = activeGradientView.gradientLayer;
    [gradientLayer removeFromSuperlayer];
    gradientLayer = [[CAGradientLayer alloc] init];
    
    gradientLayer.startPoint = gradientStartPoint;
    gradientLayer.endPoint = gradientEndPoint;
    gradientLayer.frame = activeGradientView.bounds;
    
    activeGradientView.topGradientColor = topColor;
    activeGradientView.bottomGradientColor = bottomColor;    
    
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[activeGradientView.topGradientColor CGColor], (id)[activeGradientView.bottomGradientColor CGColor], nil];
    
    [activeGradientView.layer addSublayer:gradientLayer];
    activeGradientView.gradientLayer = gradientLayer;
 
}

- (IBAction)changeGradientStyleAction:(id)sender {
    
    if([sender isEqual:gradientLayerStyle1])
    {
        gradientStartPoint = CGPointMake(0,0);
        gradientEndPoint = CGPointMake(1,1);
    }else if([sender isEqual:gradientLayerStyle2])
    {
        gradientStartPoint = CGPointMake(0.5,0);
        gradientEndPoint = CGPointMake(0.5,1);
    }else if([sender isEqual:gradientLayerStyle3])
    {
        gradientStartPoint = CGPointMake(1,0);
        gradientEndPoint = CGPointMake(0,1);
    }
    [self setupGradient];
    
}




@end
