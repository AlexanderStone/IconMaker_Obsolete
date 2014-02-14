//
//  PreviewViewController.h
//  glamourAR
//
//  Created by Mahmood1 on 3/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>
@class IconFile;
@class AppStorePreviewViewController;
@class IconPreviewViewController;
@class AppStoreSearchViewController;
@class PreferencesPreviewViewController;


@interface PreviewViewController : UIViewController<UITextFieldDelegate,MFMailComposeViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UIImage* image512;

@property(nonatomic,strong)UIImage* image114;
@property(nonatomic,strong)UIImage* image57;

@property(nonatomic,strong)UIImage* image144;
@property(nonatomic,strong)UIImage* image72;

@property(nonatomic,strong)UIImage* image58;
@property(nonatomic,strong)UIImage* image29;

@property(nonatomic,strong)UIImage* image50;


@property(nonatomic,strong)UIImage* logoImage;
@property(nonatomic,strong)UIImage* cameraImage;

@property(nonatomic)float transparencyValue;
@property(nonatomic)float hueValue;



- (IBAction)emailPhotos:(id)sender;

@property(nonatomic,strong)NSString* interfaceLayoutJSON;
@property(nonatomic,strong)IconFile* iconFile;

-(IBAction)backButtonAction:(id)sender;

//Preview table
@property (weak, nonatomic) IBOutlet UITableView *previewTableView;
@property (nonatomic,strong) AppStoreSearchViewController* appStoreSearchPreview;
@property (nonatomic,strong) AppStorePreviewViewController* appStoreDisplayPreview;
@property (nonatomic,strong) IconPreviewViewController* iconPreviewViewController;
@property (nonatomic,strong) PreferencesPreviewViewController* preferencesPreviewViewController;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;


@end
