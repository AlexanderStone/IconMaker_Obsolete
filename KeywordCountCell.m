//
//  KeywordCountCell.m
//  glamourAR
//
//  Created by Alexander Stone on 4/22/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "KeywordCountCell.h"

@implementation KeywordCountCell
@synthesize keyword,keywordCount,image;

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
