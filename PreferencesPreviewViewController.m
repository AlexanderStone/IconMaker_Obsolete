//
//  PreferencesPreviewViewController.m
//  IconMaker
//
//  Created by Alexander Stone on 5/6/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "PreferencesPreviewViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PreferencesPreviewViewController ()

@end

@implementation PreferencesPreviewViewController
@synthesize iconImageView;
@synthesize appName;

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
    self.view.layer.cornerRadius = 8;
    self.view.layer.masksToBounds = YES;
}

- (void)viewDidUnload
{
    [self setIconImageView:nil];
    [self setAppName:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
