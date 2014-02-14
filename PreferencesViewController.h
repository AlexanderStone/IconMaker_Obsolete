//
//  PreferencesViewController.h
//  glamourAR
//
//  Created by Mahmood1 on 1/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface PreferencesViewController : UITableViewController<UITextFieldDelegate, ADBannerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    bool bannerIsVisible;
}



- (IBAction)searchEnginePrefChanged:(id)sender;
- (IBAction)saveLargeIconSwitchAction:(id)sender;


- (IBAction)dismissController:(id)sender;

@end
