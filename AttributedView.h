//
//  AttributedView.h
//  glamourAR
//
//  Created by Alexander Stone on 3/21/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ScalableLayer.h"

@interface AttributedView : UIView
@property(nonatomic,strong)NSMutableDictionary* attributes;
@property(nonatomic,strong)UIColor* topGradientColor;
@property(nonatomic,strong)UIColor* bottomGradientColor;
@property (nonatomic,strong)CAGradientLayer* gradientLayer;
@property(nonatomic,strong)ScalableLayer* scalableLayer;
@end
