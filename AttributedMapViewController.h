//
//  AttributedMapViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/21/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@class AttributedMapView;

@interface AttributedMapViewController : UIViewController<CLLocationManagerDelegate,MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet AttributedMapView *attributedMapView;

@property(nonatomic,strong)CLLocation* location;
@property(nonatomic,strong)CLLocationManager* locationManager;
@end
