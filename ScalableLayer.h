//
//  ScalableLayer.h
//  IconMaker
//
//  Created by Alex Stone on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IconFile;

@interface ScalableLayer : NSManagedObject

@property (nonatomic, retain) NSNumber * alpha;
@property (nonatomic, retain) NSNumber * centerX;
@property (nonatomic, retain) NSNumber * centerY;
@property (nonatomic, retain) NSString * fontColor;
@property (nonatomic, retain) NSString * fontName;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * internalOffsetX;
@property (nonatomic, retain) NSNumber * internalOffsetY;
@property (nonatomic, retain) NSNumber * internalRotation;
@property (nonatomic, retain) NSNumber * isReflected;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * orientation;
@property (nonatomic, retain) NSNumber * reservedInt;
@property (nonatomic, retain) NSString * reservedString;
@property (nonatomic, retain) NSNumber * rotationRadians;
@property (nonatomic, retain) NSNumber * size;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * topDownOrder;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSNumber * zoomScale;
@property (nonatomic, retain) NSString * color1;
@property (nonatomic, retain) NSString * color2;
@property (nonatomic, retain) IconFile *iconFile;

@end
