//
//  DocumenterViewController.h
//  glamourAR
//
//  Created by Mahmood1 on 3/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>

@class PaintingView;
@class SoundEffect;
@class DragAndDropLabel;

@interface DocumenterViewController : UIViewController<UITextViewDelegate, UIGestureRecognizerDelegate,UIImagePickerControllerDelegate,MFMailComposeViewControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    SoundEffect			*erasingSound;
	SoundEffect			*selectSound;
	CFTimeInterval		lastTime;
    bool editing;
    BOOL drawingMode;
    CGRect activeLabelContainerFrame;
}

@property (weak, nonatomic) IBOutlet PaintingView *paintingView;

@property (weak, nonatomic) IBOutlet UIView *toolPanel;

- (IBAction)eraseView:(id)sender;

- (IBAction)handleLongPress:(UILongPressGestureRecognizer*)gesture;
@property (weak, nonatomic) IBOutlet UIView *sampleLabelView;

@property(nonatomic,strong)NSMutableArray* labelViews;


- (IBAction)buttonWillDelete:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *documentPanel;

@property(nonatomic, weak)DragAndDropLabel* activeCompanionLabelView;

@property (weak, nonatomic) IBOutlet UIToolbar *editingToolbar;
- (IBAction)doneEditing:(id)sender;
- (IBAction)clearLabel:(id)sender;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *fontNameButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fontSizeButton;
- (IBAction)changeFont:(id)sender;
- (IBAction)changeFontSize:(id)sender;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *companionLabels;

@property (strong, nonatomic) IBOutlet UILongPressGestureRecognizer *longPressGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIRotationGestureRecognizer *rotationGestureRecognizer;

@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapGestureRecognizer;
@property (strong, nonatomic) IBOutlet UIPinchGestureRecognizer *pinchGestureRecognizer;
- (IBAction)handleTapFrom:(id)sender;
- (IBAction)handleRotationFrom:(id)sender;
- (IBAction)handlePinch:(id)sender;


- (IBAction)activateDrawing:(id)sender;
- (IBAction)activateLabels:(id)sender;

- (IBAction)selectBackground:(id)sender;

@property (nonatomic, retain) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *hideDrawingPanel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSelectorSegmentedControl;
- (IBAction)changeColor:(id)sender;

@property (weak, nonatomic) IBOutlet UIToolbar *componentControlsToolbar;

@property (weak, nonatomic) IBOutlet UIToolbar *paintToolbar;

- (IBAction)emailDocumentation:(id)sender;

- (IBAction)dismissModalDialog:(id)sender;


@property (weak, nonatomic) IBOutlet UIToolbar *fontStyleToolbar;
- (IBAction)showStyleToolbar:(id)sender;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *dismissStyleToolbar;



@property (weak, nonatomic) IBOutlet UIToolbar *fontSizeBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fontSizeBarFontSizeButton;
@property (weak, nonatomic) IBOutlet UISlider *fontSizeSlider;
@property (weak, nonatomic) IBOutlet UIStepper *fontSizeStepper;

- (IBAction)fontSizeChanged:(id)sender;
- (IBAction)hideFontSizeBar:(id)sender;
@property (nonatomic,strong)UIPickerView* fontPicker;
@property(nonatomic,strong)NSArray* fontNames;

-(void)autoHideToolsPanel:(id)sender;

@end
