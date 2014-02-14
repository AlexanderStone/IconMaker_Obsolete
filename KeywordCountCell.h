//
//  KeywordCountCell.h
//  glamourAR
//
//  Created by Alexander Stone on 4/22/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeywordCountCell : UITableViewCell
@property (nonatomic,strong)IBOutlet UILabel* keyword;
@property (nonatomic,strong)IBOutlet UILabel* keywordCount;
@property (nonatomic,strong)IBOutlet UIImage* image;
@end
