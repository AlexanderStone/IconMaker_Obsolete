//
//  SalesCopy.h
//  glamourAR
//
//  Created by Alexander Stone on 4/22/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface SalesCopy : NSManagedObject

@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSString * keywords;
@property (nonatomic, retain) NSString * text;

@end
