//
//  SelectColorViewController.m
//  TrackerFactoryNew
//
//  Created by Alexander Stone on 2/27/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "SelectColorViewController.h"
//#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface SelectColorViewController ()

@end

@implementation SelectColorViewController
@synthesize selectColorView;
@synthesize tapGestureRecognizer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self.view addGestureRecognizer:tapGestureRecognizer];
    tapGestureRecognizer.cancelsTouchesInView = NO;  
}

- (void)viewDidUnload
{
    [self setTapGestureRecognizer:nil];
    [self setSelectColorView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (UIColor *) colorOfPoint:(CGPoint)point
{
    unsigned char pixel[4] = {0};
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGContextTranslateCTM(context, -point.x, -point.y);
    
    [self.view.layer renderInContext:context];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    NSLog(@"pixel: %d %d %d %d", pixel[0], pixel[1], pixel[2], pixel[3]);
    float red = pixel[0]/255.0;
    float green = pixel[1]/255.0;
    float blue = pixel[2]/255.0;
    float alpha = pixel[3]/255.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
    [[NSUserDefaults standardUserDefaults] setFloat:red forKey:@"navBarRed"];
    [[NSUserDefaults standardUserDefaults] setFloat:green forKey:@"navBarGreen"];
    [[NSUserDefaults standardUserDefaults] setFloat:blue forKey:@"navBarBlue"];    
    [[NSUserDefaults standardUserDefaults] setFloat:alpha forKey:@"navBarAlpha"];
    
    
 
    return color;
}

- (UIColor *) getPixelColorAtPoint:(CGPoint)point {
    //- (UIColor*) getPixelColorAtLocationX:(float)pointX locationY:(float) pointY imageName:(NSString *)imageName {
    // from  http://stackoverflow.com/questions/448125/how-to-get-pixel-data-from-a-uiimage-cocoa-touch-or-cgimage-core-graphics
    
    UIImage *tempImage = [UIImage imageNamed:@"colored_pencils.png"]; 
    
    // First get the image into your data buffer
    CGImageRef imageRef = [tempImage CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * point.y) + point.x * bytesPerPixel;
    /*    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
     CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
     CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
     CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
     
     NSInteger mycolor = rawData[byteIndex]*1000000 + rawData[byteIndex + 1]*1000 + rawData[byteIndex + 2]*1;
     
     NSLog(@"At %f,%f colors: RGB A %f %f %f %f %i",pointX,pointY,red,green,blue,alpha,mycolor);
     free(rawData);
     
     return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
     */
    
    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
    CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
    CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
    CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
    free(rawData);
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
//    return [NSString stringWithFormat:@"%i,%i,%i",rawData[byteIndex],rawData[byteIndex + 1],rawData[byteIndex + 2]];
}

- (NSString *) getPixelColorAtLocationX:(float)pointX locationY:(float) pointY imageName:(NSString *)imageName {
    //- (UIColor*) getPixelColorAtLocationX:(float)pointX locationY:(float) pointY imageName:(NSString *)imageName {
    // from  http://stackoverflow.com/questions/448125/how-to-get-pixel-data-from-a-uiimage-cocoa-touch-or-cgimage-core-graphics
    
    UIImage *tempImage = [UIImage imageNamed:imageName]; 
    
    // First get the image into your data buffer
    CGImageRef imageRef = [tempImage CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char *rawData = malloc(height * width * 4);
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    NSUInteger bitsPerComponent = 8;
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
                                                 bitsPerComponent, bytesPerRow, colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * pointY) + pointX * bytesPerPixel;
    /*    CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
     CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
     CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
     CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
     
     NSInteger mycolor = rawData[byteIndex]*1000000 + rawData[byteIndex + 1]*1000 + rawData[byteIndex + 2]*1;
     
     NSLog(@"At %f,%f colors: RGB A %f %f %f %f %i",pointX,pointY,red,green,blue,alpha,mycolor);
     free(rawData);
     
     return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
     */
    return [NSString stringWithFormat:@"%i,%i,%i",rawData[byteIndex],rawData[byteIndex + 1],rawData[byteIndex + 2]];
}

#pragma mark -
#pragma mark GestureRecognizers
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    return YES;
}


- (IBAction)handleTapFrom:(id)sender {
    
    if([sender isKindOfClass:[UITapGestureRecognizer class]])
    {
        
        
        CGPoint location = [tapGestureRecognizer locationInView:self.view];

        //remember color preferences
       UIColor* navBarColor = [self colorOfPoint:location];
        selectColorView.center = location;
        
        
        self.navigationController.navigationBar.tintColor = navBarColor;
//        [self.navigationController.navigationBar setNeedsDisplay];
    }
    
  
    
}




@end
