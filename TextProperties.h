//
//  TextProperties.h
//  glamourAR
//
//  Created by Mahmood1 on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface TextProperties : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * family;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSNumber * colorRed;
@property (nonatomic, retain) NSNumber * alignment;
@property (nonatomic, retain) NSNumber * colorGreen;
@property (nonatomic, retain) NSNumber * colorBlue;
@property (nonatomic, retain) NSNumber * colorAlpha;
@property (nonatomic, retain) NSString * text;

@end
