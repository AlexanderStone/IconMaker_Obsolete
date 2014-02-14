//
//  DeleteViewButton.m
//  glamourAR
//
//  Created by Mahmood1 on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DeleteViewButton.h"

@implementation DeleteViewButton
@synthesize view;


-(IBAction)deleteViewActionWithSender:(id)sender;
{
    
    if(self.view)
    {
        [UIView animateWithDuration:0.4 animations:^{
            self.view.alpha = 0;
        } completion:^(BOOL finished) {
            [self.view removeFromSuperview];
        }];
    }
}

@end
