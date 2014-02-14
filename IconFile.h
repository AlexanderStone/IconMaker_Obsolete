//
//  IconFile.h
//  IconMaker
//
//  Created by Alexander Stone on 5/6/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@class IconFileWrapper, IconImageLocalFile, Image, Label, ScalableLayer;

@interface IconFile : NSManagedObject

@property (nonatomic, retain) NSString * activeViewName;
@property (nonatomic, retain) NSString * appStoreName;
@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSNumber * containerOriginX;
@property (nonatomic, retain) NSNumber * containerOriginY;
@property (nonatomic, retain) NSNumber * containerSizeHeight;
@property (nonatomic, retain) NSNumber * containerSizeWidth;
@property (nonatomic, retain) NSDate * createDate;
@property (nonatomic, retain) NSNumber * frameHueShift;
@property (nonatomic, retain) NSNumber * frameID;
@property (nonatomic, retain) NSString * frameName;
@property (nonatomic, retain) NSNumber * glossEffect;
@property (nonatomic, retain) NSNumber * iconID;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSData * image114;
@property (nonatomic, retain) NSString * localImageFolder;
@property (nonatomic, retain) NSNumber * scrollViewOffsetX;
@property (nonatomic, retain) NSNumber * scrollViewOffsetY;
@property (nonatomic, retain) NSString * springBoardName;
@property (nonatomic, retain) NSString * webViewAddress;
@property (nonatomic, retain) NSNumber * webViewOnTop;
@property (nonatomic, retain) NSNumber * zoomScale;
@property (nonatomic, retain) NSString * uuid;
@property (nonatomic, retain) NSManagedObject *application;
@property (nonatomic, retain) NSSet *images;
@property (nonatomic, retain) Label *labels;
@property (nonatomic, retain) NSSet *layers;
@property (nonatomic, retain) NSSet *localImages;
@property (nonatomic, retain) IconFileWrapper *wrapper;
@end

@interface IconFile (CoreDataGeneratedAccessors)

- (void)addImagesObject:(Image *)value;
- (void)removeImagesObject:(Image *)value;
- (void)addImages:(NSSet *)values;
- (void)removeImages:(NSSet *)values;

- (void)addLayersObject:(ScalableLayer *)value;
- (void)removeLayersObject:(ScalableLayer *)value;
- (void)addLayers:(NSSet *)values;
- (void)removeLayers:(NSSet *)values;

- (void)addLocalImagesObject:(IconImageLocalFile *)value;
- (void)removeLocalImagesObject:(IconImageLocalFile *)value;
- (void)addLocalImages:(NSSet *)values;
- (void)removeLocalImages:(NSSet *)values;

@end
