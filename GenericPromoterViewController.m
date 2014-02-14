//
//  GenericPromoterViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/27/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "GenericPromoterViewController.h"
#import "DragAndDropLabel.h"
#import "AttributedTextView.h"
#import "AttributedImageView.h"


@interface GenericPromoterViewController ()

@end

@implementation GenericPromoterViewController
@synthesize iPhoneModel;
@synthesize topCallout;
@synthesize bottomCallout;
@synthesize flagCallout;
@synthesize bottomCalloutText;
@synthesize topCalloutText;
@synthesize flagCalloutText;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setIPhoneModel:nil];
    [self setTopCallout:nil];
    [self setBottomCallout:nil];
    [self setFlagCallout:nil];
    [self setBottomCalloutText:nil];
    [self setTopCalloutText:nil];
    [self setFlagCalloutText:nil];
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
    [tempSetupArray addObject:self.topCalloutText];
    [tempSetupArray addObject:self.topCallout];
    
    [tempSetupArray addObject:self.flagCalloutText];
    [tempSetupArray addObject:self.flagCallout];
    
    [tempSetupArray addObject:self.bottomCalloutText];
    [tempSetupArray addObject:self.bottomCallout];
    
    [tempSetupArray addObject:self.iconFrame256];
    [tempSetupArray addObject:iPhoneModel];
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
    [self.iPhoneModel.attributes setValue:@"iPhone" forKey:kTitleKey];
    
    [self.topCalloutText.attributes setValue:@"TitleText" forKey:kTitleKey];
    [self.topCallout.attributes setValue:@"TitleView" forKey:kTitleKey];
    
    [self.flagCalloutText.attributes setValue:@"Flag Text" forKey:kTitleKey];
    [self.flagCallout.attributes setValue:@"Flag" forKey:kTitleKey];
    

    [self.bottomCalloutText.attributes setValue:@"Bottom Text" forKey:kTitleKey];
    [self.bottomCallout.attributes setValue:@"Bottom Panel" forKey:kTitleKey];
    
    


}

-(void)setupDefaultLayerParameters
{
    [super setupDefaultLayerParameters];
    self.logoView.layer.cornerRadius = 0;
    self.logoView.layer.masksToBounds = YES;
}


@end
