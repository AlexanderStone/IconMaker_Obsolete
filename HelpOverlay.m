 //
//  HelpOverlay.m
//  glamourAR
//
//  Created by Mahmood1 on 3/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpOverlay.h"
#import "PageControlExampleViewControl.h"



@interface HelpOverlay (PrivateMethods)

- (void)loadScrollViewWithPage:(int)page;
- (void)scrollViewDidScroll:(UIScrollView *)sender;

@end

@implementation HelpOverlay
@synthesize pageControl;
@synthesize scrollView;

@synthesize viewControllers;
@synthesize instructionImages;
@synthesize mandatoryView;
@synthesize rightButton;
@synthesize leftButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < self.instructionImages.count; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
    
    // a page is the width of the scroll view
    scrollView.pagingEnabled = YES;
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * self.instructionImages.count, scrollView.frame.size.height);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
	
    pageControl.numberOfPages = self.instructionImages.count;
    pageControl.currentPage = 0;
	
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    

    if(self.mandatoryView)
    {
        self.leftButton.enabled = NO;
        self.leftButton = nil;
    }

    
}


- (void)viewDidUnload
{
    [self setPageControl:nil];
    [self setScrollView:nil];
    [self setLeftButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= self.instructionImages.count) return;
	
    // replace the placeholder if necessary
    PageControlExampleViewControl *controller = [viewControllers objectAtIndex:page];
    if ((NSNull *)controller == [NSNull null]) {
        
        
        NSString* imageName = [instructionImages objectAtIndex:page];
        
        controller = [[PageControlExampleViewControl alloc] initWithImageName:imageName];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
        
    }
	
    // add the controller's view to the scroll view
    if (nil == controller.view.superview) {
        CGRect frame = scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [scrollView addSubview:controller.view];
    }
}

-(void)checkLastPageWithPage:(int)page
{
    if(page >self.instructionImages.count-2)
    {
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey: @"initialHelpDone"];
        self.rightButton.title= @"Done";
        self.rightButton.action = @selector(dismissController:);
        
       
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    [self checkLastPageWithPage:page];  
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
    
        [self checkLastPageWithPage:page];
}


- (IBAction)dismissController:(id)sender {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}
- (IBAction)nextButtonAction:(id)sender {
    
    pageControl.currentPage = pageControl.currentPage+1;
    [self changePage:pageControl];
}
@end
