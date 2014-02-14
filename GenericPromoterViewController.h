//
//  GenericPromoterViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/27/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "PostcardMakerViewController.h"
@class DragAndDropLabel;

@interface GenericPromoterViewController : PostcardMakerViewController
@property (weak, nonatomic) IBOutlet DragAndDropLabel *iPhoneModel;
@property (weak, nonatomic) IBOutlet AttributedImageView *topCallout;
@property (weak, nonatomic) IBOutlet AttributedImageView *bottomCallout;
@property (weak, nonatomic) IBOutlet AttributedImageView *flagCallout;
@property (weak, nonatomic) IBOutlet AttributedTextView *bottomCalloutText;
@property (weak, nonatomic) IBOutlet AttributedTextView *topCalloutText;
@property (weak, nonatomic) IBOutlet AttributedTextView *flagCalloutText;

@end
