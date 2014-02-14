//
//  MagnifierView.h
//  SimplerMaskTest
//

#import <UIKit/UIKit.h>

@interface MagnifierView : UIView {
	UIView *viewToMagnify;
	CGPoint touchPoint;
}

@property (nonatomic, strong)IBOutlet UIView *viewToMagnify;
//@property (assign) CGPoint touchPoint;

@end
