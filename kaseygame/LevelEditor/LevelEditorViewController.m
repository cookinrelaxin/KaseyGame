//
//  LevelEditorViewController.m
//  kaseygame
//
//  Created by John Feldcamp on 8/13/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "LevelEditorViewController.h"
#import "LevelSelectionPopoverViewController.h"


@implementation LevelEditorViewController {
    
    BOOL initialTouchLocationAtRightEdgeOfScreen;
    SKView* levelView;
    UIViewController* levelSelectionPopover;
    LevelEditorScene* editorScene;
    TilePaletteCollectionViewController* paletteController;
    NSNumber *yes;
    NSNumber *no;
    CGFloat previousKeyPinchScale;
    NSArray *tileSpeciesPickerData;
    Palette* palette;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    _container = [CKContainer defaultContainer];
    _publicDB = [_container publicCloudDatabase];
    _privateDB = [_container privateCloudDatabase];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
    [self resignFirstResponder];
}

-(void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView.delaysContentTouches = NO;
    
    yes = [NSNumber numberWithBool:YES];
    no = [NSNumber numberWithBool:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleTileSelectionForNotification:)
                                                 name:@"palette tile selected"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateLabelForZoomChange:)
                                                 name:@"zoom changed"
                                               object:nil];
    
    tileSpeciesPickerData = @[@"non object", @"object"];
    
    _tileSpeciesPicker.dataSource = self;
    _tileSpeciesPicker.delegate = self;
    _tileSpeciesPicker.hidden = true;
    

    
    
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    levelView = (SKView *)self.view;
    

    if (!levelView.scene) {
        
        levelView.ignoresSiblingOrder = YES;
        levelView.multipleTouchEnabled = YES;
        
        
        editorScene = [LevelEditorScene sceneWithSize:levelView.bounds.size];
        editorScene.scaleMode = SKSceneScaleModeResizeFill;
        
        [levelView presentScene:editorScene];
        editorScene.currentLevel.xScale = .1;
        editorScene.currentLevel.yScale = .1;
        editorScene.masterPalette = palette;
        
        _myLevelNames = [NSMutableArray array];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self findLevels];
        });
        

    }
    
    
}

- (void)viewDidLayoutSubviews
{
    [_scrollView setContentSize:CGSizeMake(_scrollView.contentSize.width, 1)];
    _scrollView.alpha = .4;
    _scrollView.userInteractionEnabled = NO;
    editorScene.zoomEnabled = false;
    editorScene.dragEnabled = false;
    editorScene.boxSelectionEnabled = false;
    _pinchAndZoomUnavailableLabel.hidden = true;
    _zoomPercentageLabel.hidden = true;
}


-(void)tellSceneToLoadLevel:(NSString *)levelName {
    if (!editorScene.levelLoaded) {
        // gotta fix this or just implement lol
        CKRecord *levelRecord = [[CKRecord alloc] initWithRecordType:@"LevelProduct"];
        NSData *levelData = [levelRecord objectForKey:@"theActualLevel"];
        LevelComponent* theRealMcCoy = [NSKeyedUnarchiver unarchiveObjectWithData:levelData];
        [editorScene loadLevel:theRealMcCoy];
        editorScene.levelLoaded = true;
        editorScene.currentZoomLevel = three;
        
        _zoomPercentageLabel.text = @"10%";
        [self enableScrollViewAndInteraction];

    }
    
    
}


-(void)findLevels {
    
//    NSBundle* myBundle = [NSBundle mainBundle];
//    NSArray* chunkPaths = [myBundle pathsForResourcesOfType:@"tmx" inDirectory:nil];
//    
//    for (NSString* path in chunkPaths) {
//        
//        NSString* chunkPathWithoutExtension = [[path lastPathComponent] stringByDeletingPathExtension];
//        NSString* chunkName = [chunkPathWithoutExtension substringToIndex:[chunkPathWithoutExtension rangeOfString:@"x" options:NSBackwardsSearch].location];
//        if ([_levelNames containsObject:chunkName]) {
//            break;
//        }
//        [_levelNames addObject:chunkName];
//    }
    CKRecord *myLevelNameRecord = [[CKRecord alloc] initWithRecordType:@"LevelNameCollection"];
    _myLevelNames = [myLevelNameRecord objectForKey:@"names"];
}


- (IBAction)buttonPressed:(UIButton *)sender {
    
    if (sender.tag == 202) {
        editorScene.currentLevel.position = editorScene.initialPosition;
        return;
    }
    
    if (sender == _undoButton) {
        //NSLog(@"editorScene.undoManager.canRedo: %hhd",editorScene.undoManager.canRedo);
        _undoButton.enabled = false;
        [editorScene.undoManager undo];
        _undoButton.enabled = true;
        return;
     }
    if (sender == _redoButton) {
        _redoButton.enabled = false;
        [editorScene.undoManager redo];
        _redoButton.enabled = true;
        return;
    }
    
    if (sender == _saveButton) {
        [self saveLevelToCloud];

    }
    
    if (sender == _createLevelButton) {
        editorScene = [LevelEditorScene sceneWithSize:levelView.bounds.size];
        editorScene.scaleMode = SKSceneScaleModeResizeFill;
        
        [levelView presentScene:editorScene];
        [editorScene adjustWorldPositionToScale:2];
        _zoomPercentageLabel.text = @"200%";
        editorScene.masterPalette = palette;
        [self enableScrollViewAndInteraction];
        return;
    }
    
    if (sender == _deleteSelectionButton) {
        [editorScene deleteSelection];
        return;
    }
    
}

-(void)saveLevelToCloud{
    CKRecord *levelRecord = [[CKRecord alloc] initWithRecordType:@"LevelProduct"];
    [levelRecord setObject:editorScene.currentLevel.name forKey:@"name"];
    NSData *levelData = [NSKeyedArchiver archivedDataWithRootObject:editorScene.currentLevel];
    [levelRecord setObject:levelData forKey:@"theActualLevel"];
    
    [self.publicDB saveRecord:levelRecord completionHandler:^(CKRecord *savedRecord, NSError *error){
        if(error) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"choose existing level"]) {
        LevelSelectionPopoverViewController *destination = segue.destinationViewController;
        levelSelectionPopover = destination;
        destination.senderViewController = self;
        destination.levelNames = _myLevelNames;
        
        return;
        
    }
    
    if ([segue.identifier isEqualToString:@"show tile palette"]) {
        paletteController = segue.destinationViewController;
        palette = [[Palette alloc] init];
        paletteController.palette = palette;
    }
    
}

- (void)handleTileSelectionForNotification:(NSNotification*)notificationOfPress {
    NSDictionary *dict = [notificationOfPress userInfo];
    UIButton *selectedButton = [dict objectForKey:@"tile"];

    Tile* selectedTile = [[Tile alloc] init];
    selectedTile.gid = [selectedButton.titleLabel.text integerValue];
    for (Tileset* tileset in paletteController.palette.tileSets) {
        if (tileset.gidRange.location >= selectedTile.gid) {
            for (Tile* tile in tileset.tiles) {
                if (tile.gid == selectedTile.gid) {
                    selectedTile.image = tile.image;
                    if (!editorScene.currentlySelectedTileForBrush) {
                        editorScene.currentlySelectedTileForBrush = [[Tile alloc] init];
                    }
                    editorScene.currentlySelectedTileForBrush = selectedTile;
                    _selectedTileView.image = tile.image;
                    _tileSpeciesPicker.hidden = false;
                    [self setPickerRowAccordingToCurrentTileSpecies:_tileSpeciesPicker];
                    return;
                }
            }
        }
    }
    
}

- (void)setPickerRowAccordingToCurrentTileSpecies:(UIPickerView*)picker {
    
    for (Tileset* tileset in editorScene.masterPalette.tileSets) {
        if (tileset.gidRange.location >= editorScene.currentlySelectedTileForBrush.gid) {
            for (Tile* tile in tileset.tiles) {
                if (tile.gid == editorScene.currentlySelectedTileForBrush.gid) {
                    [picker selectRow:tile.species inComponent:0 animated:YES];
                    return;
                }
            }
        }
    }
    
    
}

- (IBAction)sliderValueChanged:(UISlider *)sender {
    sender.value = lroundf(sender.value);
    
    if (sender == _selectionModeSlider) {
        
        switch ((int)_selectionModeSlider.value) {

            case 0:
                editorScene.currentSelectionType =  boxSelection;
                //editorScene.currentBoxSelectionType = boxMake;
                [_boxSelectionCollection setValue:no forKey:@"hidden"];

                break;
                
            case 1:
                editorScene.currentSelectionType = tileDrag;
                [_boxSelectionCollection setValue:yes forKey:@"hidden"];
                break;
                
            case 2:
                editorScene.currentSelectionType = tileBrush;
                [_boxSelectionCollection setValue:yes forKey:@"hidden"];
                [self brushOrEraserSelected];
                return;
                
            case 3:
                editorScene.currentSelectionType = tileEraser;
                [_boxSelectionCollection setValue:yes forKey:@"hidden"];
                [self brushOrEraserSelected];
                return;

            }
        editorScene.zoomEnabled = true;
        editorScene.dragEnabled = true;
        _pinchAndZoomUnavailableLabel.hidden = true;

            return;
    }
    
    else if (sender == _boxSelectionModeSlider) {
        
        switch ((int)_boxSelectionModeSlider.value) {
            case 0:
                editorScene.currentBoxSelectionType = boxMake;
                break;
                
            case 1:
                editorScene.currentBoxSelectionType =  cutAndDrag;
                break;
                
            case 2:
                editorScene.currentBoxSelectionType =  copyAndDrag;
                break;
            case 3:
                editorScene.currentBoxSelectionType =  fill;
                break;
                
        }
        return;

    }


}

-(void)brushOrEraserSelected {
    _pinchAndZoomUnavailableLabel.hidden = false;
    editorScene.zoomEnabled = false;
    editorScene.dragEnabled = false;
}

-(void)enableScrollViewAndInteraction {
    editorScene.zoomEnabled = true;
    editorScene.dragEnabled = true;
    editorScene.boxSelectionEnabled = true;
    _pinchAndZoomUnavailableLabel.hidden = true;
    
    _scrollView.alpha = 1;
    _scrollView.userInteractionEnabled = YES;
    _zoomPercentageLabel.hidden = false;
    
}

- (void)updateLabelForZoomChange:(NSNotification*)notificationOfZoomChange {
    
   switch (editorScene.currentZoomLevel) {
       case three:
           _zoomPercentageLabel.text = @"10% zoom";
           break;
       case two:
           _zoomPercentageLabel.text = @"20% zoom";
           break;
       case one:
           _zoomPercentageLabel.text = @"50% zoom";
            break;
       case zero:
           _zoomPercentageLabel.text = @"100% zoom";
            break;
       case negativeOne:
            _zoomPercentageLabel.text = @"200% zoom";
            break;
    }
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [tileSpeciesPickerData count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return tileSpeciesPickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    void (^setTileSpecies)(TileSpecies) = ^(TileSpecies relevantSpecies){
        
        for (Tileset* tileset in editorScene.masterPalette.tileSets) {
            if (tileset.gidRange.location >= editorScene.currentlySelectedTileForBrush.gid) {
                for (Tile* tile in tileset.tiles) {
                    if (tile.gid == editorScene.currentlySelectedTileForBrush.gid) {
                        tile.species = relevantSpecies;
                        return;
                    }
                }
            }
        }
    };
    
    
    switch (row) {
        case 0:
            setTileSpecies(nonObject);
            break;
        case 1:
            setTileSpecies(object);
            break;
    }
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
