//
//  AppStorePreviewViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReflectionView;

@interface AppStorePreviewViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *appStoreName;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UITextField *reviewCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *installAppButton;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *appIconButton;
- (IBAction)appIconButtonAction:(id)sender;

@property (weak, nonatomic) IBOutlet ReflectionView *reflectionView;
@property (weak, nonatomic) IBOutlet ReflectionView *starReflectionView;

@end
