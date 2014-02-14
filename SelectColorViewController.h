//
//  SelectColorViewController.h
//  TrackerFactoryNew
//
//  Created by Alexander Stone on 2/27/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectColorViewController : UIViewController


@property (weak, nonatomic) IBOutlet UIView *selectColorView;

- (IBAction)handleTapFrom:(id)sender;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;

- (UIColor *) colorOfPoint:(CGPoint)point;
- (UIColor *) getPixelColorAtPoint:(CGPoint)point;
@end
