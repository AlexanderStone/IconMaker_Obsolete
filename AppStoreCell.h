//
//  AppStoreCell.h
//  glamourAR
//
//  Created by Alexander Stone on 3/26/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconFileTextField.h"

@interface AppStoreCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *previewPanel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImage;

@property (weak, nonatomic) IBOutlet IconFileTextField *ratingTextField;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *starLabel;

@property (weak, nonatomic) IBOutlet IconFileTextField *appStoreNameTextField;
@property (weak, nonatomic) IBOutlet IconFileTextField *companyNameTextField;

@end
