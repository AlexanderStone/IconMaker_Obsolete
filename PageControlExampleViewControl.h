//
//  PageControlExampleViewControl.h
//  PageControlExample
//
//  Created by Chakra on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PageControlExampleViewControl : UIViewController {

	IBOutlet UILabel *pageNumberLabel;
    int pageNumber;
    UIImage* image;
}

@property (nonatomic, retain) UILabel *pageNumberLabel;

- (id)initWithPageNumber:(int)page;
- (id)initWithImageName:(NSString*)imageName;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
	


@end
