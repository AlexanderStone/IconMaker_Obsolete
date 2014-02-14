//
//  Demo2ViewController.h
//  GMGridView
//
//  Created by Gulam Moledina on 11-11-10.
//  Copyright (c) 2011 GMoledina.ca. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMGridView;
@interface Demo2ViewController : UIViewController
    @property (nonatomic,strong) GMGridView* gridView1;
    @property (nonatomic,strong) GMGridView* gridView2;
@property(nonatomic,strong) NSMutableArray* labelsText;


@end
