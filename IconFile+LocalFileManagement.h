//
//  IconFile+LocalFileManagement.h
//  IconMaker
//
//  Created by Alexander Stone on 5/5/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "IconFile.h"

//these are sacred file extensions, they should not be modified or the icon files would no longer be found!
#define k512Extension @"app_store_512x512.png"
#define k114Extension @"iPhone_retina_114x114.png"
#define k57Extension @"iPhone_57x57.png"

#define k144Extension @"iPad_retina_144x144.png"
#define k72Extension @"iPad_72x72.png"
#define k58Extension @"iPhone_preferences_retina_58x58.png"
#define k29Extension @"iPhone_preferences_29x29.png"
#define k50Extension @"iPad_preferences_50x50.png"

#define kCameraImageExtension @"CameraImage.jpg"
#define kLogoImageExtension @"LogoImage.jpg"

enum IconTypes {
    kIconType114,
    kIconType57,
    kIconType144,
    kIconType72,
    kIconType58,
    kIconType29,
    kIconType50,
    kIconType512,
    kCameraType,
    kLogoType,
    kNumberOfIconTypes
};

@interface IconFile (LocalFileManagement)

-(BOOL)moveLocalContentToLocalFolder:(NSString*)localFolder;
-(void)deleteLocalContent;

-(void)saveLocalImage:(UIImage *)image name:(NSString *)name isPNG:(BOOL)isPNG;
-(NSArray*)imageFilepaths;

-(NSString*)imagesFolderPath;
-(NSString*)generateLocalJSONData;
+(void)setupCoreDataObjectMapping;
+(NSString*)createUUID;

-(UIImage*)displayImage;

//name that is allowed in html and file paths
-(NSString*)cleanName;
-(NSString*)iconImageWithType:(int)type;
@end
