//
//  TextFieldCell.m
//  IconMaker
//
//  Created by Alexander Stone on 5/6/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "TextFieldCell.h"

@implementation TextFieldCell
@synthesize textField;

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
