//
//  DropboxConfigAPI.m
//  RKCatalog
//
//  Created by Alexander Stone on 5/2/12.
//  Copyright (c) 2012 Two Toasters. All rights reserved.
//

#import "DropboxConfigAPI.h"
#import "Reachability.h"


//1: get this key/secret pair from :https://www.dropbox.com/developers/apps
//new pair is required for each new project
NSString *kDropboxAppKey = @"kd61k1b14frt0f2";
NSString *kDropboxAppSecret = @"dm266uwr4upfu7t";

//2: Open RKCatalog-Info.plist as source code
//locate CFBundleURLSchemes, add app key after db-
//db-9vj2o72crbels29

//<key>CFBundleURLTypes</key>
//<array>
//<dict>
//<key>CFBundleURLSchemes</key>
//<array>
//<string>db-kd61k1b14frt0f2</string>
//</array>
//</dict>
//</array>


//3: within app delegate after app finished launching:
//DBSession* dbSession = [[[DBSession alloc] initWithAppKey:kDropboxAppKey appSecret:kDropboxAppSecret root:kDBRootAppFolder] autorelease];
//[DBSession setSharedSession:dbSession];


/*
 4: Add the following method to app delegate
 */
//-(BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
//{
//    if ([[DBSession sharedSession] handleOpenURL:url]) {
//        if ([[DBSession sharedSession] isLinked]) {
//            NSLog(@"App linked successfully!");
//            [CHDropboxSync forgetStatus];
//            [[NSNotificationCenter defaultCenter] postNotificationName:@"Linked" object:nil];
//            // At this point you can start making API calls
//        }
//        return YES;
//    }
//    // Add whatever other url handling code your app requires here
//    return NO;
//}



//folder name for the local documents directory in which to store data. 
NSString* kLocalDataFolder = @"iconData";

@implementation DropboxConfigAPI





+(BOOL)isReachableByWifi
{
     BOOL wifiAvailable = [[Reachability reachabilityForLocalWiFi] isReachableViaWiFi];
    return wifiAvailable;
}
-(void)showWifiNotAvailableDialog
{
    NSLog(@"Not implemented");
}

@end
