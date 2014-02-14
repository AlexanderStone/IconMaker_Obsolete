//
//  KeywordCountTableViewController.m
//  glamourAR
//
//  Created by Alexander Stone on 4/22/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "KeywordCountTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "KeywordCountCell.h"

@interface KeywordCountTableViewController ()
-(void)parseKeywords;
-(void)parseSalesCopy;
-(void)countKeywords;
-(int)findNumberOfKeyword:(NSString*)keyword;
@end

@implementation KeywordCountTableViewController
@synthesize keywordsTextView;
@synthesize tableView;
@synthesize keywordsLengthLabel;
@synthesize keywordsContainer;
@synthesize keywordsLengthContainer;
@synthesize keywordsArray;
@synthesize salesCopy;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.keywordsContainer.layer.cornerRadius = 10;
    self.keywordsLengthContainer.layer.cornerRadius = 10;
    
    self.keywordsContainer.layer.masksToBounds = YES;
    self.keywordsLengthContainer.layer.masksToBounds = YES;
    
    self.keywordsLengthLabel.text = [NSString stringWithFormat:@"%i/100", self.keywordsTextView.text.length];
    
    [self parseKeywords];
//    [self parseSalesCopy];
//    [self countKeywords];
    
    for(NSString* keyword in self.keywordsArray)
    {
        [self findNumberOfKeyword:keyword];
    }
    
    
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setKeywordsTextView:nil];
    [self setTableView:nil];
    [self setKeywordsLengthLabel:nil];
    [self setKeywordsContainer:nil];
    [self setKeywordsLengthContainer:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    int count =keywordsArray.count;
    // Return the number of rows in the section.
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"keywordCountCell";
    KeywordCountCell *cell = (KeywordCountCell *)[tableView_ dequeueReusableCellWithIdentifier:CellIdentifier];
    NSString* keyword = [self.keywordsArray objectAtIndex:indexPath.row]; 
    cell.keyword.text = keyword;
    cell.keywordCount.text = [NSString stringWithFormat:@"%i",[self findNumberOfKeyword:keyword]];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView_ didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    [tableView_ deselectRowAtIndexPath:indexPath animated:YES];
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"Keywords detected in your sales copy";
}

- (IBAction)dismissController:(id)sender {
   [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
   }];
}

- (IBAction)save:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(void)checkTextLength
{
    if(self.keywordsTextView.text.length>100)
    {
        self.keywordsLengthLabel.textColor = [UIColor redColor];
    }else if(self.keywordsTextView.text.length>80) {
        self.keywordsLengthLabel.textColor = [UIColor greenColor];
    }else
    {
        self.keywordsLengthLabel.textColor = [UIColor whiteColor];
    }
}
-(void)textViewDidChange:(UITextView *)textView
{
    self.keywordsLengthLabel.text = [NSString stringWithFormat:@"%i/100", self.keywordsTextView.text.length];
    [self checkTextLength];
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        [self parseKeywords];
        [self.tableView reloadData];
        return NO;
    }
    
    return YES;
}
-(void)parseKeywords
{
    self.keywordsArray = [self.keywordsTextView.text componentsSeparatedByString:@","];
}

-(int)findNumberOfKeyword:(NSString*)keyword
{
    NSString* lowercaseKeyword = [keyword lowercaseString];
    NSRange r = NSMakeRange(0, self.salesCopy.length);
    int count = 0;
    for (;;) {
        r = [self.salesCopy rangeOfString:lowercaseKeyword options:NSCaseInsensitiveSearch range:r];
        if (r.location == NSNotFound) {
            break;
        }
        count++;
        r.location++;
        r.length = self.salesCopy.length - r.location;
    }
    NSLog(@"keyword: %@ count: %d",keyword, count);
    return count;
}

-(void)countKeywords
{
    NSArray* components = [self.salesCopy componentsSeparatedByString:@"lucid dreaming"];
    
    NSLog(@"lucid dreaming: %i",components.count);
    
     components = [self.salesCopy componentsSeparatedByString:@"Singularity Experience"];
    
    NSLog(@"Singularity Experience: %i",components.count);
}


-(void)parseSalesCopy
{
    if(self.salesCopy!=nil)
    {
        NSMutableDictionary* keywordsDictionary = [[NSMutableDictionary alloc] initWithCapacity:1024];
        NSString* key = nil;
        NSLog(@"%@",self.salesCopy);
        
         NSLog(@"Started parsing: %@",[[NSDate date] description]);
        
        CFStringRef salesCopyCF =  (__bridge_retained CFStringRef) self.salesCopy;
        CFRange range =  CFRangeMake (0,CFStringGetLength(salesCopyCF));
        CFLocaleRef locale =CFLocaleCopyCurrent();
        CFStringTokenizerRef tokenizer = CFStringTokenizerCreate(kCFAllocatorDefault,
                                                             salesCopyCF, 
                                                            range, kCFStringTokenizerUnitWord, locale);
        
        unsigned tokensFound = 0; // or the desired number of tokens
        
        CFStringTokenizerTokenType tokenType = kCFStringTokenizerTokenNone;
        
        while(kCFStringTokenizerTokenNone != (tokenType = CFStringTokenizerAdvanceToNextToken(tokenizer)) ) {
            CFRange tokenRange = CFStringTokenizerGetCurrentTokenRange(tokenizer);
            CFStringRef tokenValue = CFStringCreateWithSubstring(kCFAllocatorDefault, salesCopyCF, tokenRange);
            
            // Do something with the token
            key =(__bridge NSString*)tokenValue;
            
            NSNumber* count = [keywordsDictionary objectForKey:key];
            if(count!=nil)
            {
                 [keywordsDictionary setValue:[NSNumber numberWithInt:1] forKey:key];
            }else {
                [keywordsDictionary setValue:[NSNumber numberWithInt:count.intValue+1] forKey:key];
            }
                
           
            CFRelease(tokenValue);
            
            ++tokensFound;
        }
        NSLog(@"Ended parsingtokens Found: %d, %@",tokensFound,[[NSDate date] description]);
        NSLog(@"%@",[keywordsDictionary description]);
        // Clean up
        CFRelease(tokenizer);
        CFRelease(locale);
        CFRelease(salesCopyCF);      
    }
    
    
}

-(void)setSalesCopy:(NSString *)salesCopy_
{
    salesCopy = [salesCopy_ lowercaseString];
    
}
@end
