//
//  SyncController.m
//  IconMaker
//
//  Created by Alexander Stone on 5/5/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "SyncController.h"
#import "RKJSONParserJSONKit.h"
#import "BackgroundProgressViewController.h"
#import "GLAppDelegate.h"

#import "IconFile.h"
#import "IconFileWrapper.h"
#import "ScalableLayer.h"
#import "IconImageLocalFile.h"
#import <RestKit/RestKit.h>
#import "IconFile+LocalFileManagement.h"
#import "IconImageLocalFile.h"

@implementation SyncController
@synthesize parser;
@synthesize backgroundProgressViewController = __backgroundProgressViewController;

-(void)syncStarted
{
    Class<RKParser> parser_ = [[RKParserRegistry sharedRegistry] parserClassForMIMEType:@"application/json"]; 
    [[RKParserRegistry sharedRegistry] setParserClass:parser_ forMIMEType:@"text/plain"]; 
    //asihttpobject loader returns this as mime type
    [[RKParserRegistry sharedRegistry] setParserClass:parser_ forMIMEType:@"text/plain; charset=ascii"];
   
    
    if(self.parser==nil)
    {
        self.parser = [[RKJSONParserJSONKit alloc] init];
    }
    
    DLog(@"SyncStarted");
    isSynchronizing = YES;
}
-(void)syncCancelled
{
    DLog(@"Sync Cancelled");
    isSynchronizing = NO;
}

-(void)syncError:(NSString*)errorMessage
{
    DLog(@"Sync error: %@",errorMessage);
}



-(void)downloadedFileAtPath:(NSString*)path
{
//    DLog(@"Downloaded file: %@",path);
}


// Sync has finished, so you can dealloc it now
- (void)syncComplete {
    DLog(@"Sync complete");
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    isSynchronizing = NO;
    
    NSLog(@"Finishing background task");
    [[UIApplication sharedApplication] endBackgroundTask: taskIdentifier];
    taskIdentifier = UIBackgroundTaskInvalid;
    
    //    [self.presentingViewController dismissModalViewControllerAnimated:YES];
    
}

/**
 Overwrite this method to setup the sync
 */
-(void)deserializeFileAtPath:(NSString*)filePath
{
    DLog(@"Deserialize file: %@",filePath);
    NSError* error = nil;
    NSString *stringJSON = [NSString stringWithContentsOfFile:filePath usedEncoding:nil error:&error];
    if(error)
    {
        NSLog(@"Error reading from file: %@", filePath);
    }
    
    //restore the dictionary, as it was serialized
    NSDictionary* serializationDictionary =  [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:filePath] options:NSJSONReadingMutableContainers error:&error];
//    
    
    [IconFile setupCoreDataObjectMapping];
//    DLog(@"serializationDictionary: %@",serializationDictionary);
    
    IconFileWrapper* wrapper = [IconFileWrapper object];
    
    NSDictionary *objectAsDictionary;
    RKObjectMapper* mapper;
    error = nil;
    objectAsDictionary= [self.parser objectFromString:stringJSON error:&error];
//     DLog(@"objectAsDictionary: %@",objectAsDictionary);
    if(error)
    {
        DLog(@"error : %@",[error localizedDescription]);
    }
    
    mapper = [RKObjectMapper mapperWithObject:serializationDictionary 
                              mappingProvider:[RKObjectManager sharedManager].mappingProvider];
    //    mapper.targetObject = target;
    RKObjectMappingResult* result = [mapper performMapping];
    
    //top level object within wrapper is  iconfile
    IconFile* iconFile = [result asObject];
    iconFile.wrapper = wrapper;
    
    [[wrapper managedObjectContext]save:nil];
    IconFile* resultIcon = [result asObject];
    DLog(@"%@", resultIcon);
    
    for(ScalableLayer* scalableLayer in resultIcon.layers)
    {
        DLog(@"scalable layer:%@", scalableLayer);
    }
    for(IconImageLocalFile* localFile in resultIcon.localImages)
    {
        DLog(@"local file:%@", localFile);
    }
    
}

-(void)deleteIconWithName:(NSString*)name
{
    DLog(@"Deleted file: %@",name);
    NSPredicate* namePredicate = [NSPredicate predicateWithFormat:@"springBoardName LIKE[cd] %@",name];
    NSArray* results = [IconFile objectsWithPredicate:namePredicate];
    for(IconFile* iconFile in results)
    {
        [iconFile deleteInContext:iconFile.managedObjectContext];
        DLog(@"Deleting: %@", [iconFile description]);
        NSError* error = nil;
        [[IconFile managedObjectContext] save:&error];
        
    }
    

}
-(void)deletedFileAtPath:(NSString *)path
{
    
    NSString* file = [path lastPathComponent];
    DLog(@"%@",path);
    DLog(@"extension:%@",[path pathExtension]);
    if (![path.pathExtension isEqualToString: @"json"])
    {
        //got incorrect file
        return;
    }
    NSString* name = [file stringByReplacingOccurrencesOfString:file.pathExtension
                                                     withString:@""];
    name = [name stringByReplacingOccurrencesOfString:@"." withString:@""];
    
    [self performSelectorOnMainThread:@selector(deleteIconWithName:) withObject:name waitUntilDone:NO];
        
    
}


-(void)showBackgroundProgress
{
    //init the background spinner and add it to the main window
    GLAppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];

        
    
    [appDelegate.window addSubview:self.backgroundProgressViewController.view];
    self.backgroundProgressViewController.view.alpha = 0;
    self.backgroundProgressViewController.view.center = CGPointMake(self.backgroundProgressViewController.view.frame.size.width/2, 424);
    
       
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundProgressViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
       
    }];
    
}
-(void)hideBackgroundProgress
{
    [UIView animateWithDuration:0.3 animations:^{
          self.backgroundProgressViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self.backgroundProgressViewController.view removeFromSuperview];
        self.backgroundProgressViewController = nil;
    }];
 
}

-(BackgroundProgressViewController*)backgroundProgressViewController
{
    if(__backgroundProgressViewController != nil)
    {
        return __backgroundProgressViewController;
    }else 
      
        self.backgroundProgressViewController = [[BackgroundProgressViewController alloc] initWithNibName:@"BackgroundProgressViewController" bundle:nil];
        return __backgroundProgressViewController;
}


@end
