//
//  DragAndDropLabel.h
//  glamourAR
//
//  Created by Mahmood1 on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class DeleteViewButton;

@interface DragAndDropLabel : UIView

//external container that has this text view within it
@property(nonatomic,weak)IBOutlet UIView* parentContainerView;
@property(nonatomic,weak)IBOutlet UITextView* textView;

//deletes the container
@property(nonatomic,weak)IBOutlet DeleteViewButton* deleteButton;


@property(nonatomic,weak)IBOutlet UIImageView* imageView;

//remembers the rotation of the control
@property(nonatomic)float savedRotation;

@property(nonatomic,strong)UIImageView* accessoryView;

-(IBAction)addAccessoryView:(id)sender;


@property(nonatomic,strong)NSMutableDictionary* attributes;
@property(nonatomic,strong)UIColor* topGradientColor;
@property(nonatomic,strong)UIColor* bottomGradientColor;
@property (nonatomic,strong)CAGradientLayer* gradientLayer;
@end
