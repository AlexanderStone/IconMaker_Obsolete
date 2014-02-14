//
//  LengthWidgetViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/23/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LengthWidgetViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lengthIndicator;
@property (weak, nonatomic) IBOutlet UILabel *limitIndicator;

-(void)updateLength:(int)length;
@property(nonatomic)int limit;
@end
