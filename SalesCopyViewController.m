//
//  SalesCopyViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/22/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "SalesCopyViewController.h"
#import "KeywordCountTableViewController.h"

@interface SalesCopyViewController ()
-(void)updateWordCount;
@end

@implementation SalesCopyViewController
@synthesize salesCopyToolbar;
@synthesize appStorePreviewContainer;
@synthesize salesCopyTextField;
@synthesize textLengthLabel;

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
    
    [self updateWordCount];
    
    //add a view over the text

    [self.appStorePreviewContainer removeFromSuperview];
    [self.salesCopyTextField addSubview:self.appStorePreviewContainer];
    self.appStorePreviewContainer.center = CGPointMake(160,-50);
    
    self.salesCopyTextField.contentOffset = CGPointMake(0,0);   
   
    //add a view to the end
//    CGSize contentSize = self.salesCopyTextField.contentSize;
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setSalesCopyTextField:nil];
    [self setTextLengthLabel:nil];
    [self setAppStorePreviewContainer:nil];
    [self setSalesCopyToolbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
#pragma mark UITextViewDelegate
-(void)checkTextLength
{
    if(self.salesCopyTextField.text.length>4000)
    {
        self.textLengthLabel.textColor = [UIColor redColor];
    }else if(self.salesCopyTextField.text.length>3000) {
        self.textLengthLabel.textColor = [UIColor greenColor];
    }else
    {
         self.textLengthLabel.textColor = [UIColor whiteColor];
    }
}
-(void)updateWordCount
{
    self.textLengthLabel.text = [NSString stringWithFormat:@"%i",self.salesCopyTextField.text.length];
    [self checkTextLength];
}
-(void)textViewDidChange:(UITextView *)textView
{
    
}

-(void)dismissKeyboard:(id)sender
{
    [self.salesCopyTextField resignFirstResponder];
}

- (IBAction)doKeywordAnalysis:(id)sender {
    
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"analyzeKeywords"])
    {
        UINavigationController* navController = segue.destinationViewController;
        KeywordCountTableViewController* keywordCountController = (KeywordCountTableViewController*)navController.topViewController;
        
        [keywordCountController setSalesCopy:self.salesCopyTextField.text];
    }
}
- (IBAction)dismissController:(id)sender {
    [self.presentingViewController dismissModalViewControllerAnimated:YES];
}
@end
