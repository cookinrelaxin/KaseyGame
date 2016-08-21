//
//  LevelEditorViewController.h
//  kaseygame
//
//  Created by John Feldcamp on 8/13/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "LevelEditorScene.h"
#import "TilePaletteCollectionViewController.h"
#import "Palette.h"
#import <CloudKit/CloudKit.h>


@interface LevelEditorViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic) NSArray* myLevelNames;
@property (nonatomic) BOOL boxSelectionPopoverOpen;


@property (weak, nonatomic) IBOutlet UILabel *zoomPercentageLabel;
@property (weak, nonatomic) IBOutlet UISlider *selectionModeSlider;
@property (weak, nonatomic) IBOutlet UISlider *boxSelectionModeSlider;
@property (weak, nonatomic) IBOutlet UIButton *undoButton;
@property (weak, nonatomic) IBOutlet UIButton *redoButton;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UIButton *createLevelButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteSelectionButton;
@property (weak, nonatomic) IBOutlet UILabel *boxSelectionAnchor;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutletCollection(id) NSArray *boxSelectionCollection;
@property (weak, nonatomic) IBOutlet UIView *tilePaletteContainerView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedTileView;
@property (weak, nonatomic) IBOutlet UIPickerView *tileSpeciesPicker;
@property (weak, nonatomic) IBOutlet UILabel *pinchAndZoomUnavailableLabel;

@property (nonatomic) CKContainer* container;
@property (nonatomic) CKDatabase* publicDB;
@property (nonatomic) CKDatabase* privateDB;


- (void)tellSceneToLoadLevel:(NSString*)levelName;
//- (void)handleTileSelection:(UIButton *) sender;
@end

