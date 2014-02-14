//
//  DropboxConfigAPI.h
//  RKCatalog
//
//  Created by Alexander Stone on 5/2/12.
//  Copyright (c) 2012 Two Toasters. All rights reserved.
//

#import <Foundation/Foundation.h>



extern NSString *kDropboxAppKey;
extern NSString *kDropboxAppSecret;


extern NSString* kLocalDataFolder;

@interface DropboxConfigAPI : NSObject

+(BOOL)isReachableByWifi;
-(void)showWifiNotAvailableDialog;

@end
