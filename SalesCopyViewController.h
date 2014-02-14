//
//  SalesCopyViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/22/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalesCopyViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *salesCopyTextField;
@property (weak, nonatomic) IBOutlet UILabel *textLengthLabel;

-(IBAction)dismissKeyboard:(id)sender;
- (IBAction)doKeywordAnalysis:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *appStorePreviewContainer;
- (IBAction)dismissController:(id)sender;
@property (weak, nonatomic) IBOutlet UIToolbar *salesCopyToolbar;

@end
