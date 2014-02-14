//
//  BackgroundProgressViewController.h
//  ServiceRecord
//
//  Created by Alexander Stone on 4/20/12.
//  Copyright (c) 2012 Splinter Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackgroundProgressViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *progressView;
@property (strong, nonatomic) IBOutlet UILabel *percentageLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

@end
