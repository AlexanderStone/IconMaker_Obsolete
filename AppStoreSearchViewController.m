//
//  AppStoreSearchViewController.m
//  IconMaker
//
//  Created by Alexander Stone on 5/5/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "AppStoreSearchViewController.h"

@interface AppStoreSearchViewController ()

@end

@implementation AppStoreSearchViewController
@synthesize icon114;
@synthesize companyName;
@synthesize appStoreName;
@synthesize rating;
@synthesize ratingsCount;

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
    
    //fukkin xcode keeps crashing when I add an outlet to the reflection view!!!
    for(UIView* subview in self.view.subviews)
    {
        if([subview isKindOfClass:[ReflectionView class]])
        {
            ReflectionView* starReflectionView = (ReflectionView*)subview;
            starReflectionView.reflectionScale = 0.15;
            starReflectionView.reflectionGap = 0;
            starReflectionView.reflectionAlpha = 0.75;
            starReflectionView.dynamic = YES;
            
        }
    }
    
}

- (void)viewDidUnload
{
    [self setIcon114:nil];
    [self setCompanyName:nil];
    [self setAppStoreName:nil];
    [self setRating:nil];
    [self setRatingsCount:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
