//
//  TableViewCell.m
//  Pulse
//
//  Created by Bushra on 7/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TableViewCell.h"


@implementation TableViewCell

@synthesize horizontalTableView;
@synthesize contentArray;

- (NSString *) reuseIdentifier {
    return @"Cell";
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [contentArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.horizontalTableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
	}
    
    //Since we are reusing the cells, old image view needs to be removed form the cell
    for (UIImageView *view in cell.subviews) {
        [view removeFromSuperview];
    }
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 57, 57)];
    imageView.image = [UIImage imageNamed:[contentArray objectAtIndex:indexPath.row]];
    cell.textLabel.text = [contentArray objectAtIndex:indexPath.row];
//    cell.textLabel.alpha = 0;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    imageView.contentMode = UIViewContentModeCenter;
    
    CGAffineTransform rotateImage = CGAffineTransformMakeRotation(M_PI_2);
    imageView.transform = rotateImage;
    
    [cell addSubview:imageView];
//    [imageView release];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 57;
}




@end
