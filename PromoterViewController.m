//
//  PromoterViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 3/28/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "PromoterViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PromoterViewController ()

@end

@implementation PromoterViewController
@synthesize topToolbars;
@synthesize bottomToolbar;
@synthesize backgroundView;
@synthesize iPhoneContentImage;

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
	// Do any additional setup after loading the view
    
    //clear tint.
    for(UINavigationBar* bar in topToolbars)
    {
        bar.tintColor = nil;;
    }
    self.bottomToolbar.tintColor = nil;
    
    
   CAGradientLayer* tempGradientLayer = [CAGradientLayer layer];
    
    tempGradientLayer.startPoint = CGPointMake(0.5, 0);
    tempGradientLayer.endPoint = CGPointMake(0.5,1);
    tempGradientLayer.frame = backgroundView.bounds;
    tempGradientLayer.colors = [NSArray arrayWithObjects:(id)[[UIColor darkGrayColor] CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
    [backgroundView.layer addSublayer:tempGradientLayer];

    
}

- (void)viewDidUnload
{
    [self setIPhoneContentImage:nil];
    [self setBottomToolbar:nil];
    [self setTopToolbars:nil];
    [self setBackgroundView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



#pragma mark image picker delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)img editingInfo:(NSDictionary *)editInfo {
	iPhoneContentImage.image = img;	
	[self dismissModalViewControllerAnimated:YES];
}
@end
