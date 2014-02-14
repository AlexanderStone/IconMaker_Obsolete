//
//  DragAndDropLabel.m
//  glamourAR
//
//  Created by Mahmood1 on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DragAndDropLabel.h"

@implementation DragAndDropLabel

@synthesize parentContainerView;
@synthesize deleteButton;
@synthesize savedRotation;
@synthesize textView;
@synthesize imageView;
@synthesize accessoryView;
@synthesize attributes;
@synthesize topGradientColor;
@synthesize bottomGradientColor;
@synthesize gradientLayer;

-(IBAction)addAccessoryView:(id)sender
{
    //prevent views from autoresizing
    self.autoresizesSubviews = NO;
    
    //become fatter
    self.frame = CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width+60,self.frame.size.height);
    
    if(accessoryView !=nil)
    {
        accessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,60,60)];
        accessoryView.image = [UIImage imageNamed:@"Red.png"];
        [self addSubview:accessoryView];
        accessoryView.center = CGPointMake(30,30);
    }
    
    [self layoutSubviews];
    
}



@end
