//
//  AppStorePreviewViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "AppStorePreviewViewController.h"
#import "ReflectionView.h"
#import <QuartzCore/QuartzCore.h>

@interface AppStorePreviewViewController ()

@end

@implementation AppStorePreviewViewController
@synthesize reflectionView;
@synthesize starReflectionView;
@synthesize appStoreName;
@synthesize companyName;
@synthesize rating;
@synthesize reviewCountLabel;
@synthesize installAppButton;
@synthesize iconImageView;
@synthesize appIconButton;

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
    // Do any additional setup after loading the view from its nib.
    
    self.reflectionView.reflectionScale = 0.25;
    self.reflectionView.reflectionGap = 1;
    self.reflectionView.reflectionAlpha = 0.5;
    self.reflectionView.dynamic = YES;
    
    self.starReflectionView.reflectionScale = 0.15;
    self.starReflectionView.reflectionGap = 0;
    self.starReflectionView.reflectionAlpha = 0.75;
    self.starReflectionView.dynamic = YES;

    self.installAppButton.layer.cornerRadius = 2;
    self.installAppButton.layer.masksToBounds = YES;
    
    for(CALayer* layer in self.view.layer.sublayers)
    {
        if ([layer isKindOfClass:[CAGradientLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
    CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.frame = self.view.bounds;
//     UIColor* topColor = [UIColor colorWithRed:144 green:146 blue:147 alpha:1];
    UIColor* topColor = [UIColor colorWithWhite:0.58 alpha:1];
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[[UIColor lightGrayColor] CGColor], nil];
    //    [view.layer addSublayer:gradientLayer];
    
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    
    
    //reflection is not masked
    self.appIconButton.layer.cornerRadius = 9;
    self.appIconButton.layer.masksToBounds = YES;
    
}

- (void)viewDidUnload
{
    [self setAppStoreName:nil];
    [self setCompanyName:nil];
    [self setRating:nil];
    [self setReviewCountLabel:nil];
    [self setInstallAppButton:nil];
    [self setIconImageView:nil];
    [self setAppIconButton:nil];
    [self setReflectionView:nil];
    [self setStarReflectionView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)appIconButtonAction:(id)sender {
    NSLog(@"App icon button action!");
}
@end
