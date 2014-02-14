//
//  AttributedWebView.h
//  glamourAR
//
//  Created by Alexander Stone on 3/21/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScalableLayer.h"
@interface AttributedWebView : UIWebView
@property(nonatomic,strong)NSMutableDictionary* attributes;
@property(nonatomic,strong)ScalableLayer* scalableLayer;
@end
