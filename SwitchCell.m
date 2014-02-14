//
//  SwitchCell.m
//  IconMaker
//
//  Created by Alexander Stone on 5/8/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "SwitchCell.h"

@implementation SwitchCell
@synthesize toggleSwitch;

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
