//
//  ViewController.h
//  UIPageViewControllerDemo
//
//  Created by Uppal'z on 11/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContentViewController.h"

@interface ViewController : UIViewController<UIPageViewControllerDelegate,UIPageViewControllerDataSource>

@property (nonatomic, strong) UIPageViewController *pageViewController;
@property (nonatomic, strong) NSMutableArray *modelArray;
@end
