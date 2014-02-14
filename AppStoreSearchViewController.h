//
//  AppStoreSearchViewController.h
//  IconMaker
//
//  Created by Alexander Stone on 5/5/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReflectionView.h"

@interface AppStoreSearchViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *icon114;
@property (weak, nonatomic) IBOutlet UITextField *companyName;
@property (weak, nonatomic) IBOutlet UITextField *appStoreName;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UITextField *ratingsCount;

@end
