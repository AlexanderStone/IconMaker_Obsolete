//
//  HelpPageViewController.m
//  IconMaker
//
//  Created by Alex Stone on 5/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelpPageViewController.h"
#import "ContentViewController.h"

@interface HelpPageViewController ()

@end

@implementation HelpPageViewController
@synthesize contentArray;
@synthesize modelArray;


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
	// Do any additional setup after loading the view.
    
    self.dataSource = self;
    self.delegate = self;
    
    self.modelArray = [NSMutableArray arrayWithArray:[NSArray arrayWithObjects:
                                                      [UIImage imageNamed:@"photo 1.PNG"],
                                                      [UIImage imageNamed:@"photo 2.PNG"],
                                                      [UIImage imageNamed:@"photo 3.PNG"],
                                                      [UIImage imageNamed:@"photo 4.PNG"],
                                                      [UIImage imageNamed:@"photo 5.PNG"],
                                                      nil]];
    
    
        
   ContentViewController* contentViewController = [[ContentViewController alloc]initWithNibName:@"ContentViewController" bundle:nil];
    
    NSAssert([self.modelArray objectAtIndex:0]!=nil,@"nil image!");
    contentViewController.image = [[self modelArray] objectAtIndex:0];
  
    NSArray *viewControllers = [NSArray arrayWithObject:contentViewController];
    [self setViewControllers:viewControllers 
                                      direction:UIPageViewControllerNavigationDirectionForward
                                       animated:NO 
                                     completion:nil];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPageViewControllerDataSource Methods

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController 
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.modelArray indexOfObject:[(ContentViewController *)viewController image]];
    if(currentIndex == 0)
    {
        return nil;
    }
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    contentViewController.image = [self.modelArray objectAtIndex:currentIndex - 1];

    return contentViewController;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger currentIndex = [self.modelArray indexOfObject:[(ContentViewController *)viewController image]];
    if(currentIndex == self.modelArray.count-1)
    {
        return nil;
    }
    ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:@"ContentViewController" bundle:nil];
    contentViewController.image = [self.modelArray objectAtIndex:currentIndex + 1];
    
    return contentViewController;
}

#pragma mark - UIPageViewControllerDelegate Methods

- (UIPageViewControllerSpineLocation)pageViewController:(UIPageViewController *)pageViewController
                   spineLocationForInterfaceOrientation:(UIInterfaceOrientation)orientation
{
    if(UIInterfaceOrientationIsPortrait(orientation))
    {
        //Set the array with only 1 view controller
        UIViewController *currentViewController = [self.viewControllers objectAtIndex:0];
        NSArray *viewControllers = [NSArray arrayWithObject:currentViewController];
        [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        //Important- Set the doubleSided property to NO.
        self.doubleSided = NO;
        //Return the spine location
        return UIPageViewControllerSpineLocationMin;
    }
    else
    {
        NSArray *viewControllers = nil;
        ContentViewController *currentViewController = [self.viewControllers objectAtIndex:0];
        
        NSUInteger currentIndex = [self.modelArray indexOfObject:[(ContentViewController *)currentViewController image]];
        if(currentIndex == 0 || currentIndex %2 == 0)
        {
            UIViewController *nextViewController = [self pageViewController:self viewControllerAfterViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:currentViewController, nextViewController, nil];
        }
        else
        {
            UIViewController *previousViewController = [self pageViewController:self viewControllerBeforeViewController:currentViewController];
            viewControllers = [NSArray arrayWithObjects:previousViewController, currentViewController, nil];
        }
        //Now, set the viewControllers property of UIPageViewController
        [self setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:NULL];
        
        return UIPageViewControllerSpineLocationMid;
    }
}


@end
