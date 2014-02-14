//
//  DeleteViewButton.h
//  glamourAR
//
//  Created by Mahmood1 on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeleteViewButton : UIButton

@property(nonatomic,weak)IBOutlet UIView* view;

-(IBAction)deleteViewActionWithSender:(id)sender;

@end
