//
//  GenericDocumenterViewController.h
//  glamourAR
//
//  Created by Alexander Stone on 4/7/12.
//  Copyright (c) 2012 Pfizer. All rights reserved.
//

#import "PostcardMakerViewController.h"
#import "DragAndDropLabel.h"
@class PaintingView;

@interface GenericDocumenterViewController : PostcardMakerViewController
@property (weak, nonatomic) IBOutlet DragAndDropLabel *stickyNote1;
@property (weak, nonatomic) IBOutlet DragAndDropLabel *stickyNote2;
@property (weak, nonatomic) IBOutlet UIView *previewContainer;
@property (weak, nonatomic) IBOutlet PaintingView *paintingView;
@property (strong, nonatomic) IBOutlet UIPanGestureRecognizer *panGestureRecognizer;
- (IBAction)handlePan:(id)sender;
- (IBAction)erasePaintingView:(id)sender;

- (IBAction)changePaintColor:(id)sender;
@property (weak, nonatomic) IBOutlet UIToolbar *paintControl;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *paintBrushColor;
- (IBAction)hidePaintingViewControls:(id)sender;

@end
