//
//  AppStoreCell.m
//  glamourAR
//
//  Created by Alexander Stone on 3/26/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "AppStoreCell.h"

@implementation AppStoreCell
@synthesize previewPanel;
@synthesize imageView;
@synthesize ratingTextField;
@synthesize priceLabel;
@synthesize appStoreNameTextField;
@synthesize companyNameTextField;
@synthesize starLabel;
@synthesize backGroundImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
