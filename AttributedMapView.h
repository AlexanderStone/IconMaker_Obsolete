//
//  AttributedMapView.h
//  glamourAR
//
//  Created by Alexander Stone on 4/11/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ScalableLayer.h"

@interface AttributedMapView : MKMapView
@property(nonatomic,strong)NSMutableDictionary* attributes;
@property(nonatomic,strong)UIColor* topGradientColor;
@property(nonatomic,strong)UIColor* bottomGradientColor;
@property (nonatomic,strong)CAGradientLayer* gradientLayer;
@property(nonatomic,strong)ScalableLayer* scalableLayer;
@end
