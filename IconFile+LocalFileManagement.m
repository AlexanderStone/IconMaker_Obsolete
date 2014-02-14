//
//  IconFile+LocalFileManagement.m
//  IconMaker
//
//  Created by Alexander Stone on 5/5/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "IconFile+LocalFileManagement.h"
#import "IconImageLocalFile.h"
#import "ConciseKit.h"
#import "IconFileWrapper.h"
#import "JSONKit.h"
#import <RestKit/CoreData/CoreData.h>
#import "DropboxConfigAPI.h"





@implementation IconFile (LocalFileManagement)


-(BOOL)moveLocalContentToLocalFolder:(NSString*)localFolder
{
    
    NSString* currentImagesFolderPath = [self imagesFolderPath];
    
    NSString* newFolderPath = [[$ documentPath] stringByAppendingPathComponent:localFolder]; 
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    BOOL success =  [fileManager moveItemAtPath:currentImagesFolderPath toPath:newFolderPath error:&error];
    if(!success)
    {
        DLog(@"failed to move folder to: %@",newFolderPath);

    }
    
    if(error)
    {
        DLog(@"error: %@",[error localizedDescription]);
    }
    
    return success;
}
-(void)deleteLocalContent
{ 
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSError* error = nil;
    
    BOOL success = [fileManager removeItemAtPath:[self imagesFolderPath] error:&error];
    if(!success || error)
    {
        DLog(@"failed to delete images folder %@",[self imagesFolderPath]);
    }
    
//    for(IconImageLocalFile* localImage in self.localImages)
//    {
//        error = nil;
//        filepath = [[[$ documentPath] stringByAppendingPathComponent:self.localImageFolder] stringByAppendingPathComponent:localImage.fileName];
//        [fileManager removeItemAtPath:filepath error:&error ];
//        if(error)
//        {
//            NSLog(@"error removing file at path: %@",filepath);
//        }
//    }
    //remove all references to local image files
    [self removeLocalImages:self.localImages];
    
}

-(void)saveLocalImage:(UIImage *)image name:(NSString *)name isPNG:(BOOL)isPNG
{
    NSString* imagesFolder = [self imagesFolderPath];
    if(![[NSFileManager defaultManager] fileExistsAtPath:imagesFolder])
    {
        NSError* error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:imagesFolder withIntermediateDirectories:YES attributes:nil error:&error];
        if(error)
        {
            DLog(@"Error creating directory: %@ ",imagesFolder);
            DLog(@"Error creating directory: %@ ",[error localizedDescription]);
        }
    }
       
       
    NSString* filepath = [imagesFolder stringByAppendingPathComponent:name];
    NSLog(@"saving to path: %@",filepath);
     DLog(@"file already exists: %@",[[NSFileManager defaultManager]fileExistsAtPath:filepath]?@"YES":@"NO");
    
    IconImageLocalFile* localFile = [IconImageLocalFile object];
    localFile.fileName = name;
    localFile.uuid = [IconFile createUUID];
    [self addLocalImagesObject:localFile];
    
    NSData* data = isPNG?UIImagePNGRepresentation(image):UIImageJPEGRepresentation(image, 0.66);
   BOOL success =   [data writeToFile:filepath atomically:YES];
    if(!success)
    {
        DLog(@"failed to write to file: %@",filepath );
    }
    NSAssert(localFile.uuid !=nil,@"Failed to create UUID");
    
    DLog(@"file created: %@",[[NSFileManager defaultManager]fileExistsAtPath:filepath]?@"YES":@"NO");
}

-(NSArray*)imageFilepaths
{
    NSString* filepath = [self imagesFolderPath];
    
    NSArray* filenames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:filepath error:nil];
    NSMutableArray* fullFilepaths = [[NSMutableArray alloc] initWithCapacity:filenames.count];
    
    for(NSString* filename in filenames)
    {
        [fullFilepaths addObject:[filepath stringByAppendingPathComponent: filename]];
        DLog(@"Adding image: %@",filename);
    }
        
   return  fullFilepaths;

}

-(NSString*)imagesFolderPath
{
       return  [[[$ documentPath] stringByAppendingPathComponent:kLocalDataFolder] stringByAppendingPathComponent:[self cleanName]]; 
}

-(NSString*)generateLocalJSONData
{
    
    NSString* folderPath = [self imagesFolderPath];

    NSString* localFileName = [[self springBoardName] stringByAppendingPathExtension:@"json"];
    NSString* dataFile = [folderPath stringByAppendingPathComponent:localFileName];
  
    NSError* error = nil;
    
    DLog(@"data file: %@",dataFile);
    
    //app user subclass is the same as AppUser, but is used to differentiate between file based mapping and core data mapping
    //    RKObjectMapping *serMap = [[[RKObjectManager sharedManager] mappingProvider] serializationMappingForClass:[AppUser class]];
    RKObjectMapping *serMap = [[[RKObjectManager sharedManager] mappingProvider] serializationMappingForClass:[IconFileWrapper class]];
    
    if(self.wrapper == nil)
    {
        IconFileWrapper* wrapper = [IconFileWrapper object];
        wrapper.iconFile = self;
        [[wrapper managedObjectContext] save:nil];
    }
    NSDictionary *d = [[RKObjectSerializer serializerWithObject:self.wrapper mapping:serMap] serializedObject:&error];
    
    
    if(error!=nil)
    {
        NSLog(@"!!!!! Error: %@",[error localizedDescription]);
    }else {
        NSLog(@"%@",[d description]);
    }
    
    
//    NSString* dataContents = [d JSONString];
    error = nil;
   NSData* serializedData =  [NSJSONSerialization dataWithJSONObject:d options:NSJSONWritingPrettyPrinted error:&error];
    if(error)
    {
        NSLog(@"%@",[error localizedDescription]);
    }
    
    BOOL success = [serializedData writeToFile:dataFile atomically:YES];
    
//    NSString* dataContents = [d JSONString];
    
//    BOOL success =  [dataContents writeToFile:dataFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(!success)
    {
       DLog(@"Error writing to data file:\n%@",dataFile);
    }
    
//    DLog(@"data: %@",dataContents);
    [[IconFileWrapper managedObjectContext] save:nil];
    
    return dataFile;
    
}

+(void)setupCoreDataObjectMapping
{
    
    RKObjectManager *objectManager = [RKObjectManager sharedManager ] ;
    
    // Setup our object mappings    
    /*!
     Mapping by entity. Here we are configuring a mapping by targetting a Core Data entity with a specific
     name. This allows us to map back Twitter user objects directly onto NSManagedObject instances --
     there is no backing model class!
     */
    //********************************    
    RKManagedObjectMapping* scalableLayerMapping = [RKManagedObjectMapping mappingForEntityWithName:@"ScalableLayer"];
    scalableLayerMapping.primaryKeyAttribute = @"uuid";
    [scalableLayerMapping mapKeyPathsToAttributes:
     @"alpha", @"alpha",
     @"centerX",@"centerX",
     @"centerY",@"centerY",
     @"fontColor",@"fontColor",
     @"fontName",@"fontName",
     @"internalOffsetX",@"internalOffsetX",
     @"internalOffsetY",@"internalOffsetY",
     @"name",@"name",
     @"reservedInt",@"reservedInt",
     @"reservedString",@"reservedString",
     @"rotationRadians",@"rotationRadians",
     @"size",@"size",
     @"text",@"text",
     @"topDownOrder",@"topDownOrder",
     @"type",@"type",
     @"orientation",@"orientation",
    @"zoomScale",@"zoomScale",
     @"isReflected",@"isReflected",
     @"internalRotation",@"internalRotation",
     @"color1",@"color1",
     @"color2",@"color2",
     nil];
    [objectManager.mappingProvider addObjectMapping:scalableLayerMapping];
    
    
    
    RKManagedObjectMapping* localImageMapping = [RKManagedObjectMapping mappingForEntityWithName:@"IconImageLocalFile"];
    localImageMapping.primaryKeyAttribute = @"uuid";
    [localImageMapping mapKeyPathsToAttributes:
     @"fileName", @"fileName",
     nil];
    [objectManager.mappingProvider addObjectMapping:localImageMapping];
    
    
    //********************************    
    
    RKManagedObjectMapping* iconFileMapping = [RKManagedObjectMapping mappingForEntityWithName:@"IconFile"];
    iconFileMapping.primaryKeyAttribute = @"uuid";
    [iconFileMapping mapKeyPathsToAttributes:
//     @"activeViewName", @"activeViewName", //Bug: activeViewName = Camera; no " marks in resulting dictionary!
     @"appStoreName",@"appStoreName",
     @"companyName",@"companyName",
     @"containerOriginX",@"containerOriginX",
     @"containerOriginY",@"containerOriginY",
     @"containerSizeHeight",@"containerSizeHeight",
     @"containerSizeWidth",@"containerSizeWidth",
     @"createDate",@"createDate",
     @"frameHueShift",@"frameHueShift",
     @"frameID",@"frameID",
     @"frameName",@"frameName",
     @"glossEffect",@"glossEffect",
     @"iconID",@"iconID",
     @"localImageFolder",@"localImageFolder",
     @"scrollViewOffsetX",@"scrollViewOffsetX",
     @"scrollViewOffsetY",@"scrollViewOffsetY",
     @"springBoardName",@"springBoardName",
     @"webViewAddress",@"webViewAddress",
     @"webViewOnTop",@"webViewOnTop",
     @"zoomScale",@"zoomScale",
     nil];
    
    
    [iconFileMapping mapRelationship:@"layers" withMapping:scalableLayerMapping];
    [iconFileMapping mapRelationship:@"localImages" withMapping:localImageMapping];
    [objectManager.mappingProvider addObjectMapping:iconFileMapping];
    
    
    [objectManager.mappingProvider addObjectMapping:iconFileMapping];
    [objectManager.mappingProvider setSerializationMapping:[iconFileMapping inverseMapping] forClass:[IconFile class]];
    
    //    // Update date format so that we can parse Twitter dates properly
    //	// Wed Sep 29 15:31:08 +0000 2010
    //	[statusMapping.dateFormatStrings addObject:@"E MMM d HH:mm:ss Z y"];
    
    //these are used for export
    [objectManager.mappingProvider setMapping:localImageMapping forKeyPath:@"localImages"];
    [objectManager.mappingProvider setMapping:scalableLayerMapping forKeyPath:@"layers"];
    [objectManager.mappingProvider setMapping:iconFileMapping forKeyPath:@"iconFile"];
    
    
    RKManagedObjectMapping* iconWrapperMapping = [RKManagedObjectMapping mappingForClass:[IconFileWrapper class]];
    iconWrapperMapping.primaryKeyAttribute = @"uuid";
    //    keyPath and attribute names. must be even
    [iconWrapperMapping mapKeyPathsToAttributes:@"uuid",@"uuid",nil];
    [iconWrapperMapping mapRelationship:@"iconFile" withMapping:iconFileMapping];
    
    [objectManager.mappingProvider addObjectMapping:iconWrapperMapping];
    [objectManager.mappingProvider setSerializationMapping:[iconWrapperMapping inverseMapping] forClass:[IconFileWrapper class]];
    
    
}


+(NSString *)createUUID
{
    
    // Create universally unique identifier (object)
    CFUUIDRef uuidObject = CFUUIDCreate(kCFAllocatorDefault);
    
    // Get the string representation of CFUUID object.
    NSString *uuidStr = (__bridge NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuidObject) ;
    
    CFRelease(uuidObject);
    
    return uuidStr;
    
}

-(NSString*)cleanName
{

    NSString* stringToTrim = self.springBoardName;
    
    
    NSMutableCharacterSet* alphaNumericWithWhiteSpace = [NSCharacterSet alphanumericCharacterSet];
    [alphaNumericWithWhiteSpace formUnionWithCharacterSet:[NSCharacterSet whitespaceCharacterSet]];
    NSCharacterSet* allButAlphaNumeric = [alphaNumericWithWhiteSpace invertedSet];
    
    stringToTrim = [stringToTrim stringByTrimmingCharactersInSet:allButAlphaNumeric];
    return stringToTrim;

}

-(NSString*)iconImageWithType:(int)type
{
    NSString* extension = nil;
    switch (type) {
        case kIconType114:
            extension = k114Extension;
            break;
        case kIconType57:
            extension = k57Extension;
            break;
        case kIconType144:
            extension = k144Extension;
            break;
        case kIconType72:
            extension = k72Extension;
            break;
        case kIconType58:
            extension = k58Extension;
            break;
        case kIconType29:
            extension = k29Extension;
            break;
            
        case kIconType50:
            extension = k50Extension;
            break;
        case kIconType512:
            extension = k512Extension;
            break;
            
        case kCameraType:
            extension = kCameraImageExtension;
            break;
        case kLogoType:
            extension = kLogoImageExtension;
            break;
            
        default:
            break;
    }
    
    return [NSString stringWithFormat:@"%@_%@",[self cleanName],extension];
}

-(UIImage*)displayImage
{
    if(self.image114 ==nil ||self.image114.length ==0)
    {
        //if there's no image data (restored from dropbox), find the local 114 image and make it the icon
        NSString* folderPath = [self imagesFolderPath];
        NSString* filename = [self iconImageWithType:kIconType114];
        NSString* image114Path = nil;
        
        image114Path=[folderPath stringByAppendingPathComponent:filename];
        
        
        if(image114Path!=nil)
        {
            
            DLog(@"getting image from: %@",image114Path);
            //            NSError* error = nil;
            //            [[NSFileManager defaultManager] contentsOfDirectoryAtPath:[[$ documentPath] stringByAppendingPathComponent:[IconFile image]] error:&error]
            
            //            NSString* fullPath = [[$ documentPath] stringByAppendingPathComponent:image114Path];
            DLog(@"getting image from full path: %@",image114Path);
            NSString* fileExists = [[NSFileManager defaultManager] fileExistsAtPath:image114Path]?@"YES":@"NO";
            DLog(@"file exists: %@",fileExists);
            
            return  [UIImage imageWithData:[NSData dataWithContentsOfFile:image114Path]];
            
            
        }
        
        
    }else {
        //got image data
        return  [UIImage imageWithData:self.image114];
    }

}

@end
