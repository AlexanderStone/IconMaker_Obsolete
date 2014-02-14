//
//  FullScreenProgressViewController.m
//  ServiceRecord
//
//  Created by Alexander Stone on 4/20/12.
//  Copyright (c) 2012 Splinter Software. All rights reserved.
//

#import "FullScreenProgressViewController.h"

@interface FullScreenProgressViewController ()

@end

@implementation FullScreenProgressViewController
@synthesize activityIndicator;

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
    [activityIndicator startAnimating];
}


- (void)viewWillDisappear: (BOOL)animated
{
    [activityIndicator stopAnimating];
}

- (void)viewDidUnload
{
    [self setActivityIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
