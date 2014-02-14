//
//  IconPreviewViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "IconPreviewViewController.h"

@interface IconPreviewViewController ()

@end

@implementation IconPreviewViewController
@synthesize icon57;
@synthesize icon114;
@synthesize icon72;
@synthesize icon144;
@synthesize appName57;
@synthesize appName114;
@synthesize appName72;
@synthesize appName144;

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
}

- (void)viewDidUnload
{
    [self setIcon57:nil];
    [self setIcon114:nil];
    [self setIcon72:nil];
    [self setIcon144:nil];

    [self setAppName57:nil];
    [self setAppName114:nil];
    [self setAppName72:nil];
    [self setAppName144:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
