//
//  ContainerScrollView.h
//  glamourAR
//
//  Created by Alexander Stone on 3/21/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttributedView.h"

@interface ContainerScrollView : UIScrollView
@property(nonatomic,strong)AttributedView* attributedView;
@property(nonatomic,strong)UIView* dummyZoomView;
@end
