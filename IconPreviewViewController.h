//
//  IconPreviewViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IconPreviewViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *icon57;
@property (weak, nonatomic) IBOutlet UIImageView *icon114;
@property (weak, nonatomic) IBOutlet UIImageView *icon72;
@property (weak, nonatomic) IBOutlet UIImageView *icon144;

@property (weak, nonatomic) IBOutlet UILabel *appName57;
@property (weak, nonatomic) IBOutlet UILabel *appName114;
@property (weak, nonatomic) IBOutlet UILabel *appName72;
@property (weak, nonatomic) IBOutlet UILabel *appName144;

@end
