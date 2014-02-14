//
//  HelpOverlay.h
//  glamourAR
//
//  Created by Mahmood1 on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpOverlay : UIViewController<UIScrollViewDelegate>
{
    
    BOOL pageControlUsed;
}
- (IBAction)dismissController:(id)sender;

@property(nonatomic) BOOL mandatoryView;
@property(nonatomic,strong)IBOutlet UIBarButtonItem* rightButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)nextButtonAction:(id)sender;
@property(nonatomic,strong) NSMutableArray *viewControllers;
@property(nonatomic,strong )NSMutableArray* instructionImages;
@end
