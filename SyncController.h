//
//  SyncController.h
//  IconMaker
//
//  Created by Alexander Stone on 5/5/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CHDropboxSync.h"
#import <RestKit/RestKit.h>

@class RKJSONParserJSONKit;
@class BackgroundProgressViewController;


@interface SyncController : NSObject<CHDropboxSyncDelegate>


@property(nonatomic,strong)RKJSONParserJSONKit* parser;

@property (nonatomic,strong) BackgroundProgressViewController* backgroundProgressViewController;

-(void)showBackgroundProgress;
-(void)hideBackgroundProgress;

+(void)setupCoreDataObjectMapping;

@end
