//
//  MagnifierView.m
//  SimplerMaskTest
//

#import "MagnifierView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MagnifierView
@synthesize viewToMagnify;

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:CGRectMake(0, 0, 120, 80)]) {
		// make the circle-shape outline with a nice border.
		self.layer.borderColor = [[UIColor lightGrayColor] CGColor];
		self.layer.borderWidth = 3;
		self.layer.cornerRadius = 20;
		self.layer.masksToBounds = YES;
	}
	return self;
}

//- (void)setTouchPoint:(CGPoint)pt {
//	touchPoint = pt;
//	// whenever touchPoint is set, 
//	// update the position of the magnifier (to just above what's being magnified)
//	self.center = CGPointMake(pt.x, pt.y-60);
//}

- (void)drawRect:(CGRect)rect {
	// here we're just doing some transforms on the view we're magnifying,
	// and rendering that view directly into this view,
	// rather than the previous method of copying an image.
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(context,1*(self.frame.size.width*0.5),1*(self.frame.size.height*0.5));
	CGContextScaleCTM(context, 1.5, 1.5);
	CGContextTranslateCTM(context,-1*(self.center.x),-1*(self.center.y));
	[self.viewToMagnify.layer renderInContext:context];
    
    for(UIView* v in  self.viewToMagnify.subviews)
    {
        if(![v isEqual:self])
        {
            [v.layer renderInContext:context];
        }
        
    }
}




@end
