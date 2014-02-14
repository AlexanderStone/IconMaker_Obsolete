//
//  AppGraphics.h
//  glamourAR
//
//  Created by Alexander Stone on 3/21/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppGraphics : NSObject

+(CGGradientRef)CreateGradient:(UIColor*)startColor endColor:(UIColor*)endColor;

+(NSMutableData *)createPDFDatafromUIView:(UIView*)aView ;
+(NSString*)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename;
+(NSNumber*)rotationForView:(UIView *)view;


+(void)addLinearGradientToView:(UIView*)view TopColor:(UIColor*)topColor BottomColor:(UIColor*)bottomColor;

@end
