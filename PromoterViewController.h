//
//  PromoterViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 3/28/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "DocumenterViewController.h"

@interface PromoterViewController : DocumenterViewController<UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *iPhoneContentImage;
- (IBAction)pickScreenshot:(id)sender;


@property (strong, nonatomic) IBOutletCollection(UIToolbar) NSArray *topToolbars;

@property (weak, nonatomic) IBOutlet UIToolbar *bottomToolbar;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;


@end
