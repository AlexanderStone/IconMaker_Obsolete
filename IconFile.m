//
//  IconFile.m
//  IconMaker
//
//  Created by Alexander Stone on 5/6/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "IconFile.h"
#import "IconFileWrapper.h"
#import "IconImageLocalFile.h"
#import "Image.h"
#import "Label.h"
#import "ScalableLayer.h"
#import "IconFile+LocalFileManagement.h"

@implementation IconFile

@dynamic activeViewName;
@dynamic appStoreName;
@dynamic companyName;
@dynamic containerOriginX;
@dynamic containerOriginY;
@dynamic containerSizeHeight;
@dynamic containerSizeWidth;
@dynamic createDate;
@dynamic frameHueShift;
@dynamic frameID;
@dynamic frameName;
@dynamic glossEffect;
@dynamic iconID;
@dynamic image;
@dynamic image114;
@dynamic localImageFolder;
@dynamic scrollViewOffsetX;
@dynamic scrollViewOffsetY;
@dynamic springBoardName;
@dynamic webViewAddress;
@dynamic webViewOnTop;
@dynamic zoomScale;
@dynamic uuid;
@dynamic application;
@dynamic images;
@dynamic labels;
@dynamic layers;
@dynamic localImages;
@dynamic wrapper;

-(void)prepareForDeletion
{
    [self deleteLocalContent];
}

@end
