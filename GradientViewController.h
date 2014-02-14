//
//  GradientViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 3/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "ColorPickerViewController.h"

@class AttributedView;

@interface GradientViewController : UIViewController<ColorPickerViewControllerDelegate>

{
    CGPoint gradientStartPoint;
    CGPoint gradientEndPoint;
}

@property(nonatomic,strong)UIColor* topColor;
@property(nonatomic,strong)UIColor* bottomColor;
@property(nonatomic,strong)UIColor* activeColor;

@property (weak, nonatomic) IBOutlet UIButton *gradientTopButton;
@property (weak, nonatomic) IBOutlet UIButton *gradientBottomButton;


@property(nonatomic,strong)UIViewController* parentContainerController;

@property (weak, nonatomic) IBOutlet UIView *gradientControl;



@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *gradientSliders;

- (IBAction) draggedOut: (UIControl *) c withEvent: (UIEvent *) ev;

- (IBAction)pickGradientTopColor:(id)sender;

- (IBAction)pickGradientBottomColor:(id)sender;

-(void)setupGradient;

@property (weak, nonatomic) IBOutlet UIView *gradientContainer;

@property (weak, nonatomic) IBOutlet UIView *gradientContainer1;

@property (weak, nonatomic) IBOutlet UIView *gradientContainer3;

@property (nonatomic,strong)CAGradientLayer* gradientLayer;
@property(nonatomic,strong)AttributedView* activeGradientView;

@property (nonatomic,strong)CAGradientLayer* gradientLayer1;
@property (nonatomic,strong)CAGradientLayer* gradientLayer2;
@property (nonatomic,strong)CAGradientLayer* gradientLayer3;



@property (weak, nonatomic) IBOutlet UIButton *gradientLayerStyle1;
@property (weak, nonatomic) IBOutlet UIButton *gradientLayerStyle2;
@property (weak, nonatomic) IBOutlet UIButton *gradientLayerStyle3;

- (IBAction)changeGradientStyleAction:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *roundedCornerViews;


@end
