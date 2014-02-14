//
//  PageControlExampleViewControl.m
//  PageControlExample
//
//  Created by Chakra on 26/02/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "PageControlExampleViewControl.h"


static NSArray *__pageControlColorList = nil;

@implementation PageControlExampleViewControl
@synthesize imageView;

@synthesize pageNumberLabel;

// Creates the color list the first time this method is invoked. Returns one color object from the list.
+ (UIColor *)pageControlColorWithIndex:(NSUInteger)index {
    if (__pageControlColorList == nil) {
        __pageControlColorList = [[NSArray alloc] initWithObjects:[UIColor redColor], [UIColor greenColor], [UIColor magentaColor],
                                  [UIColor blueColor], [UIColor orangeColor], [UIColor brownColor], [UIColor grayColor], nil];
    }
    // Mod the index by the list length to ensure access remains in bounds.
    return [__pageControlColorList objectAtIndex:index % [__pageControlColorList count]];
}

// Load the view nib and initialize the pageNumber ivar.
- (id)initWithPageNumber:(int)page {
    if (self = [super initWithNibName:@"PageControllerExample" bundle:nil]) {
        pageNumber = page;
    }
    return self;
}


- (id)initWithImageName:(NSString*)imageName
{
    if (self = [super initWithNibName:@"PageControllerExample" bundle:nil]) {
        image = [UIImage imageNamed:imageName];
        
    }
    return self;

}

// Set the label and background color when the view has finished loading.
- (void)viewDidLoad {
    [super viewDidLoad];
    imageView.image = image;
//    pageNumberLabel.text = [NSString stringWithFormat:@"Page %d", pageNumber + 1];
//    self.view.backgroundColor = [PageControlExampleViewControl pageControlColorWithIndex:pageNumber];
}


- (void)viewDidUnload {
    [self setImageView:nil];
    [super viewDidUnload];
}
@end
