//
//  ShadowLabel.m
//  glamourAR
//
//  Created by Mahmood1 on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShadowLabel.h"

@implementation ShadowLabel
@synthesize shadowDepth;

- (void) drawTextInRect:(CGRect)rect {
    CGSize myShadowOffset = CGSizeMake(1, 2);
    float myColorValues[] = {0, 0, 0, .8};
    
    CGContextRef myContext = UIGraphicsGetCurrentContext();
    CGContextSaveGState(myContext);
    
    CGColorSpaceRef myColorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef myColor = CGColorCreate(myColorSpace, myColorValues);
    CGContextSetShadowWithColor (myContext, myShadowOffset, shadowDepth, myColor);
    
    [super drawTextInRect:rect];
    
    CGColorRelease(myColor);
    CGColorSpaceRelease(myColorSpace); 
    
    CGContextRestoreGState(myContext);
}


@end
