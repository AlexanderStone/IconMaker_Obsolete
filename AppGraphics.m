//
//  AppGraphics.m
//  glamourAR
//
//  Created by Alexander Stone on 3/21/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "AppGraphics.h"
#import <QuartzCore/QuartzCore.h>

#import <QuartzCore/QuartzCore.h>

@implementation AppGraphics

+(CGGradientRef)CreateGradient:(UIColor*)startColor endColor:(UIColor*)endColor
{
    CGGradientRef result;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[2] = {0.0f, 1.0f};
    CGFloat startRed, startGreen, startBlue, startAlpha;
    CGFloat endRed, endGreen, endBlue, endAlpha;
    
    [endColor getRed:&endRed green:&endGreen blue:&endBlue alpha:&endAlpha];
    [startColor getRed:&startRed green:&startGreen blue:&startBlue alpha:&startAlpha];
    
    CGFloat componnents[8] = {
        startRed, startGreen, startBlue, startAlpha,
        endRed, endGreen, endBlue, endAlpha
    };
    result = CGGradientCreateWithColorComponents(colorSpace, componnents, locations, 2);
    CGColorSpaceRelease(colorSpace);
    return result;
}


-(void)FillGradientRect:(CGRect)area startColor:(UIColor *)startColor endColor:(UIColor *)endColor isVertical:(BOOL)isVertical
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    CGGradientRef gradient = [AppGraphics CreateGradient:startColor endColor:endColor];
    
    CGPoint startPoint, endPoint;
    if (isVertical) {
        startPoint = CGPointMake(CGRectGetMinX(area), area.origin.y);
        endPoint = CGPointMake(startPoint.x, area.origin.y + area.size.height);
    }else{
        startPoint = CGPointMake(0, area.size.height / 2.0f);
        endPoint = CGPointMake(area.size.width, startPoint.y);
    }
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    
    CGGradientRelease(gradient);
    UIGraphicsPopContext();
}

+(NSMutableData *)createPDFDatafromUIView:(UIView*)aView 
{
    // Creates a mutable data object for updating with binary data, like a byte array
    NSMutableData *pdfData = [NSMutableData data];
    
    // Points the pdf converter to the mutable data object and to the UIView to be converted
    UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    
    // draws rect to the view and thus this is captured by UIGraphicsBeginPDFContextToData
    
    [aView.layer renderInContext:pdfContext];
    
    // remove PDF rendering context
    UIGraphicsEndPDFContext();
    
    return pdfData;
}


+(NSString*)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    // Creates a mutable data object for updating with binary data, like a byte array
    NSMutableData *pdfData = [AppGraphics createPDFDatafromUIView:aView];
    
    // Retrieves the document directories from the iOS device
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    // instructs the mutable data object to write its context to a file on disk
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
    return documentDirectoryFilename;
}

+(NSNumber*)rotationForView:(UIView *)view
{
    float rotation = atan2(view.transform.b, view.transform.a);
    rotation = rotation<0?(2*M_PI)-fabs(rotation):rotation;
    return [NSNumber numberWithFloat:rotation];
    
}

+(void)addLinearGradientToView:(UIView*)view TopColor:(UIColor*)topColor BottomColor:(UIColor*)bottomColor
{
    for(CALayer* layer in view.layer.sublayers)
    {
        if ([layer isKindOfClass:[CAGradientLayer class]])
        {
            [layer removeFromSuperlayer];
        }
    }
   CAGradientLayer* gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.startPoint = CGPointMake(0.5, 0);
    gradientLayer.endPoint = CGPointMake(0.5,1);
    gradientLayer.frame = view.bounds;
    
   
   
    gradientLayer.colors = [NSArray arrayWithObjects:(id)[topColor CGColor], (id)[bottomColor CGColor], nil];
//    [view.layer addSublayer:gradientLayer];
    
    [view.layer insertSublayer:gradientLayer atIndex:0];
    
//    if(view.layer.sublayers.count>0)
//    {
//    [view.layer insertSublayer:gradientLayer atIndex:view.layer.sublayers.count-2];
//    }else {
//        [view.layer addSublayer:gradientLayer];
//    }
}

@end
