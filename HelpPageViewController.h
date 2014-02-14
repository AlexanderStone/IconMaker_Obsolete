//
//  HelpPageViewController.h
//  IconMaker
//
//  Created by Alex Stone on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpPageViewController : UIPageViewController<UIPageViewControllerDelegate, UIPageViewControllerDataSource>

@property(nonatomic,strong)NSMutableArray* contentArray;
@property(nonatomic,strong)NSMutableArray* modelArray;
@end
