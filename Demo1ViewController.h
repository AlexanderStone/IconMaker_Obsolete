//
//  ViewController.h
//  GMGridView
//
//  Created by Gulam Moledina on 11-10-09.
//  Copyright (c) 2011 GMoledina.ca. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GMGridView;
@class IconFile;

@interface Demo1ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *springBoardPanel;


@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *toolButtons;
@property (nonatomic,strong) IconFile* iconFile;
@property(nonatomic,strong) NSMutableArray* iconFiles;

- (IBAction)presentInfo:(id)sender;

@property(nonatomic,strong)NSFetchedResultsController* fetchedResultsController;


@end
