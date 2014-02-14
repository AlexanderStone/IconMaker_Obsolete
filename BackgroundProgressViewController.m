//
//  BackgroundProgressViewController.m
//  ServiceRecord
//
//  Created by Alexander Stone on 4/20/12.
//  Copyright (c) 2012 Splinter Software. All rights reserved.
//

#import "BackgroundProgressViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface BackgroundProgressViewController ()

@end

@implementation BackgroundProgressViewController
@synthesize progressView;
@synthesize percentageLabel;
@synthesize statusLabel;

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
    //add rounded corners to the view
    self.view.layer.cornerRadius = self.view.frame.size.height/2;
    self.view.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
    [self.progressView startAnimating];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [self.progressView stopAnimating];
}

- (void)viewDidUnload
{
    [self setProgressView:nil];
    [self setPercentageLabel:nil];
    [self setStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
