//
//  AttributedMapViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/21/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "AttributedMapViewController.h"
#import "AttributedMapView.h"
#import <QuartzCore/QuartzCore.h>

@interface AttributedMapViewController ()
-(void)dropPinForLocation:(CLLocation*)location_;
@end

@implementation AttributedMapViewController
@synthesize attributedMapView;
@synthesize location,locationManager;



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
    [self.attributedMapView setMapType:MKMapTypeHybrid];
    
    self.view.layer.cornerRadius = 20;
    self.view.layer.masksToBounds = YES;
    
    if(self.location)
    {
        
    }else {
        
    }
    self.locationManager  =[[CLLocationManager alloc] init];
    locationManager.delegate = self;
    
    self.attributedMapView.delegate = self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [self.locationManager startUpdatingLocation];
}

- (void)viewDidUnload
{
    [self setAttributedMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark CLLocationManager delegate


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    [manager stopUpdatingLocation];
    self.location = newLocation;
    
//    [self.attributedMapView setCenterCoordinate:newLocation.coordinate animated:YES];
//   
//    MKCoordinateSpan span = MKCoordinateSpanMake(0.0025, 0.0055);
//    MKCoordinateRegion region = MKCoordinateRegionMake(newLocation.coordinate, span);
//    [self.attributedMapView setRegion:region animated:NO];
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [manager stopUpdatingLocation];
    //    [preferences intForKey:@"bioClockOffsetEstimate"];
    //
    //    DLog(@"failed");
}


//Responding to Authorization Changes
-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if(status == kCLAuthorizationStatusDenied ||status == kCLAuthorizationStatusRestricted)
    {
      [manager stopUpdatingLocation];
#warning test with the location authorization changes
    }
    
}
//heading

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    
}
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
    
}
-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
    
}

-(void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error
{
    
}


-(void)dropPinForLocation:(CLLocation *)location_
{
    
}
#pragma mark -
#pragma mark MapViewDelegate
- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    for(MKAnnotationView *annotationView in views) {
        if(annotationView.annotation == mv.userLocation) {
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            
            span.latitudeDelta=0.1;
            span.longitudeDelta=0.1; 
            
            CLLocationCoordinate2D location_ =mv.userLocation.coordinate;
            
            region.span=span;
            region.center=location_;
            
            [mv setRegion:region animated:YES];
            [mv regionThatFits:region];
        }
    }
}

#pragma mark -


@end
