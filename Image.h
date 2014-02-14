//
//  Image.h
//  glamourAR
//
//  Created by Mahmood1 on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IconFile;

@interface Image : NSManagedObject

@property (nonatomic, retain) NSNumber * width;
@property (nonatomic, retain) NSNumber * height;
@property (nonatomic, retain) NSNumber * centerX;
@property (nonatomic, retain) NSNumber * centerY;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * transparency;
@property (nonatomic, retain) IconFile *iconFile;

@end
