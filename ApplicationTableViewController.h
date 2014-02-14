//
//  ApplicationTableViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppStorePreviewViewController;
@class SalesCopyViewController;
@class GLAppDelegate;

@interface ApplicationTableViewController : UITableViewController<UITextViewDelegate>

@property (nonatomic,strong) GLAppDelegate* appDelegate;
@property (nonatomic,strong) AppStorePreviewViewController* appStorePreview;
@property (nonatomic,strong) SalesCopyViewController* salesCopyController;
@end
