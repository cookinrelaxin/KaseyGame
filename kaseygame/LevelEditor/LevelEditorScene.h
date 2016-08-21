//
//  MyScene.h
//  TileMapADTtest
//

//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "LevelComponent.h"
#import "Palette.h"

//extern NSString* globalLevelName;

typedef NS_ENUM(NSInteger, ZoomLevel) {
   negativeOne, zero, one, two, three};

typedef NS_ENUM(NSInteger, SelectionType) {
    //levelDrag,
    boxSelection,
    tileDrag,
    tileBrush,
    tileEraser
};

typedef NS_ENUM(NSInteger, BoxSelectionType) {
    boxMake,
    cutAndDrag,
    copyAndDrag,
    fill
};

@interface LevelEditorScene : SKScene

@property (nonatomic) NSUndoManager *undoManager;

@property (nonatomic) LevelComponent *currentLevel;
@property (nonatomic) NSString *currentLevelName;
@property (nonatomic) BOOL levelLoaded;


//for moving the map by dragging
@property (nonatomic) BOOL dragEnabled;
@property (nonatomic) CGPoint differenceBetweenInitialTouchPointAndWorldPosition;
@property (nonatomic) UITouch* touchForDragAndZoom;

@property (nonatomic) SKSpriteNode* touchedTile;
@property (nonatomic) CGPoint differenceBetweenInitialTouchPointAndTilePosition;

@property (nonatomic) ZoomLevel currentZoomLevel;
@property (nonatomic) BOOL zoomEnabled;
@property (nonatomic) float originalYDifferenceBetweenPinchTouches;
@property (nonatomic) float previousYDifferenceBetweenPinchTouches;
@property (nonatomic) BOOL zoomInAction;


@property (nonatomic) BOOL boxSelectionEnabled;
@property (nonatomic) SelectionType currentSelectionType;
@property (nonatomic) BoxSelectionType currentBoxSelectionType;
@property (nonatomic) CGPoint differenceBetweenInitialTouchPointAndBoxPosition;

@property (nonatomic) SKShapeNode* selectionAreaNode;
@property (nonatomic) SKSpriteNode* selectionAreaNodeFrameNode;
@property (nonatomic) CGPoint selectionAreaNodePreviousPosition;
@property (nonatomic) NSMutableArray* selectionAreaArray;

@property (nonatomic) Tile* currentlySelectedTileForBrush;
@property (nonatomic) BOOL boxJustFilled;
@property (strong,nonatomic) Palette *masterPalette;


@property (nonatomic) CGPoint startPoint;
//@property (nonatomic, strong) NSMutableArray *shapeLayersToDelete;

@property (nonatomic) NSInteger currentRoundingPoint;
//

/// world nodes
//@property (nonatomic) SKNode* world;
@property (nonatomic) CGPoint initialPosition;
///

/// chunk loading helpers
@property (nonatomic) NSInteger tileAnchorpointOffsetx;
@property (nonatomic) NSInteger tileAnchorpointOffsety;
///

-(void)loadLevel: (LevelComponent*)level;
- (void) adjustWorldPositionToScale:(double)scale;
- (void)deleteSelection;

@end
