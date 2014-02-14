//
//  IconFileWrapper.h
//  IconMaker
//
//  Created by Alexander Stone on 5/6/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IconFile;

@interface IconFileWrapper : NSManagedObject

@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) IconFile *iconFile;

@end
