//
//  LengthWidgetViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "LengthWidgetViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface LengthWidgetViewController ()

@end

@implementation LengthWidgetViewController
@synthesize lengthIndicator;
@synthesize limitIndicator;
@synthesize limit;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.limit = 4000;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.layer.cornerRadius = self.view.frame.size.height/2;
    self.view.layer.masksToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setLengthIndicator:nil];
    [self setLimitIndicator:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)updateLength:(int)length
{
    self.lengthIndicator.text = [NSString stringWithFormat:@"%i",length];
  
    if(length>limit)
    {
        self.lengthIndicator.textColor = [UIColor redColor];
    }else if(length>limit*0.75) {
        self.lengthIndicator.textColor = [UIColor greenColor];
    }else
    {
        self.lengthIndicator.textColor = [UIColor whiteColor];
    }

}

@end
