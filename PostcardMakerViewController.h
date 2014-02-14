//
//  PostcardMakerViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/7/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "GLFirstViewController.h"
#import <MapKit/MapKit.h>
#import "AttributedMapView.h"
@class AttributedMapViewController;

@interface PostcardMakerViewController : GLFirstViewController<MKMapViewDelegate>
@property(nonatomic,strong)AttributedMapViewController* mapViewController;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
- (IBAction)hideInterface:(id)sender;

@property (weak, nonatomic) IBOutlet AttributedImageView *qrCode;


@property (weak, nonatomic) IBOutlet AttributedMapView *mapView;

@property (weak, nonatomic) IBOutlet UIButton *dismissControllerButton;
@property (weak, nonatomic) IBOutlet AttributedTextView *dateView;

@end
