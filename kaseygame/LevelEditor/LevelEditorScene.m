//
//  MyScene.m
//  TileMapADTtest
//
//  Created by John Feldcamp on 6/20/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//
#import "LevelEditorScene.h"
#import "PhysicsComponent.h"
#import "HudComponent.h"
#import "ControlComponent.h"
#import "AnimationComponent.h"

float RoundTo(float number, float to)
{
    if (number >= 0) {
        return to * floorf(number / to + .5f);
    }
    else {
        return to * ceilf(number / to - .5f);
    }
}

//float RoundDownTo(float number, float to)
//{
//    return to * floorf(number / to);
//
//}

@implementation LevelEditorScene

@synthesize undoManager= _undoManager;


- (id) initWithSize:(CGSize)size {
    if (self = [super initWithSize:size])
     {
         
         
         //////
         //Chunk *newChunk = [[Chunk alloc] init];
         //Palette* newPalette = [[Palette alloc] init];
         //NSMutableDictionary* chunkDict = [NSMutableDictionary dictionary];
         //NSMutableDictionary* tilesetDict = [NSMutableDictionary dictionary];
          _currentLevel = [[LevelComponent alloc] initLevelFromScratch];
         //////
         
                 //////
         //_world = [[SKNode alloc] init];
         [self addChild:_currentLevel];

         
         _tileAnchorpointOffsetx = 15;
         _tileAnchorpointOffsety = 15;
         
         //////

         
         self.backgroundColor = [SKColor grayColor];
         self.anchorPoint = CGPointMake (.5,.5);
         self.userInteractionEnabled = YES;
         
         _currentRoundingPoint = 1;
         
         self.undoManager = [[NSUndoManager alloc] init];
         [self.undoManager setLevelsOfUndo:10];
         [self.undoManager setGroupsByEvent:NO];


     }
    
   return self;
}


// load chunk of a specific letter A - I

//the modifier specifies how far from the origin the current chunk is
//- (void) loadChunk: (Chunk*)chunk withModifier: (CGPoint)modifier {
//    
//    NSInteger mapWidthInPixels = (chunk.mapwidth * chunk.tilewidth);
//    NSInteger mapHeightInPixels = (chunk.mapheight * chunk.tileheight);
//    NSUInteger numberOfLayersAndObjectgroups = [chunk.layersAndObjectgroups count];
//    NSInteger currentLayerOrObjectIndex = 0;
//    CGFloat zPosition = 0;
//    
//    while (currentLayerOrObjectIndex < numberOfLayersAndObjectgroups) {
//        
//        NSInteger tilex = 0;
//        NSInteger tiley = (chunk.mapheight * chunk.tileheight) - chunk.tileheight;
//        NSMutableArray *currentLayerOrObjectgroup = [chunk.layersAndObjectgroups objectAtIndex:currentLayerOrObjectIndex];
//        //NSLog(@"%@ is a(n) %@", [currentLayerOrObjectgroup objectAtIndex:0], [currentLayerOrObjectgroup objectAtIndex:1]);
//        NSInteger numberOfTilesinCurrentLayerOrObjectGroup = [currentLayerOrObjectgroup count];
//        
//        if ([[currentLayerOrObjectgroup objectAtIndex:1]  isEqual: @"layer"])
//        {
//            
//            for (int i = 2; tiley >= 0; i ++)
//            {
//                
//                if (i >= numberOfTilesinCurrentLayerOrObjectGroup)
//                {
//                    //NSLog(@"break from initializing %@", [currentLayerOrObjectgroup objectAtIndex:0]);
//                    break;
//                }
//                
//                
//                if (tilex == mapWidthInPixels)
//                {
//                    tilex = 0;
//                    tiley -= chunk.tileheight;
//                    i --;
//                    continue;
//                }
//                
//                NSInteger currentGid = [[currentLayerOrObjectgroup objectAtIndex:i] integerValue];
//                
//                if (currentGid == 0)
//                {
//                    tilex += chunk.tilewidth;
//                    continue;
//                }
//                
//                SKSpriteNode *currentTile = [SKSpriteNode spriteNodeWithTexture:[chunk.tilesets objectAtIndex:currentGid]];
//                
//                if (currentTile.size.width != chunk.tilewidth)
//                {
//                    //NSLog(@"incorrect tilesize");
//                    break;
//                }
//    
//                
//                currentTile.position = CGPointMake(tilex + _tileAnchorpointOffsetx + modifier.x, tiley + _tileAnchorpointOffsety + modifier.y);
//                currentTile.zPosition = zPosition;
//                currentTile.name = @"tile";
//                //[chunk.layers addChild:currentTile];
//                [_world addChild:currentTile];
//                tilex += chunk.tilewidth;
//                
//                //NSLog(@"gid for current tile: %d", currentGid);
//                //NSLog(@"currentTile.position: %f, %f", currentTile.position.x,currentTile.position.y);
//                
//            }
//        }
//        
//        else if ([[currentLayerOrObjectgroup objectAtIndex:1]  isEqual: @"objectgroup"])
//        {
//            
//            for (int i = 2; tiley > 0; i ++)
//            {
//                
//                if (i >= numberOfTilesinCurrentLayerOrObjectGroup)
//                {
//                    //NSLog(@"break from initializing %@", [currentLayerOrObjectgroup objectAtIndex:0]);
//                    break;
//                    
//                }
//                
//                NSDictionary *currentObject = [currentLayerOrObjectgroup objectAtIndex:i];
//                NSInteger currentObjectxCoordinate = [[currentObject objectForKey:@"x"] integerValue];
//                NSInteger currentObjectyCoordinate = [[currentObject objectForKey:@"y"] integerValue];
//                NSInteger currentObjectGid = [[currentObject objectForKey:@"gid"] integerValue];
//                
//                //convert to bottom-left-origin coordinate system
//                currentObjectyCoordinate = (mapHeightInPixels - currentObjectyCoordinate);
//                
//                
//                SKSpriteNode *currentTile = [SKSpriteNode spriteNodeWithTexture:[chunk.tilesets objectAtIndex:currentObjectGid]];
//                
//                if (currentTile.size.width != chunk.tilewidth)
//                {
//                    //NSLog(@"incorrect tilesize");
//                    break;
//                }
//                
//              //  currentTile.anchorPoint = CGPointMake(0, 0);
//                
//                currentTile.position = CGPointMake(currentObjectxCoordinate + _tileAnchorpointOffsetx +  modifier.x, currentObjectyCoordinate + _tileAnchorpointOffsety + modifier.y);
//                currentTile.zPosition = zPosition;
//                currentTile.name = @"tile";
//                //[chunk.objects addChild:currentTile];
//                [_world addChild:currentTile];
//            
//                //NSLog(@"gid for current tile: %d", currentObjectGid);
//                //NSLog(@"currentTile.position: %f, %f", currentTile.position.x,currentTile.position.y);
//                
//                
//                
//            }
//        }
//        
//        currentLayerOrObjectIndex ++;
//        //zPosition ++;
//    }
//    
//}

-(void)loadLevel:(LevelComponent *)level{
    _currentLevel = level;
   // _currentLevelName = levelName;
    _initialPosition = CGPointMake(0 - self.view.bounds.size.width / 2, 0);
    _currentLevel.position = _initialPosition;
    
   // _saveState = self;
    
}

// this is pretty fucked up, lol. fix it some time
- (void)undoWorldEdit:(LevelComponent*)world{
    //NSLog(@"%ld", (long)self.undoManager.groupingLevel);
    if (_currentLevel) {
        [self storeWorldState];
        CGPoint currentWorldPosition = _currentLevel.position;
        [_currentLevel removeFromParent];
        _currentLevel = nil;
        _currentLevel = [[LevelComponent alloc] initLevelFromScratch];
        _currentLevel = world;
        _currentLevel.position = currentWorldPosition;
        [self addChild:_currentLevel];
        [_selectionAreaArray removeAllObjects];

    }
    
}

- (void)storeWorldState {
    NSLog(@"%ld", (long)self.undoManager.groupingLevel);
    [self.undoManager beginUndoGrouping];
    SKNode* world = [SKNode node];
    [_currentLevel enumerateChildNodesWithName:@"tile" usingBlock:^(SKNode *node, BOOL *stop) {
        [world addChild:[node copy]];
    }];
    world.xScale = _currentLevel.xScale;
    world.yScale = _currentLevel.yScale;
    [world removeFromParent];
    [self.undoManager registerUndoWithTarget:self
                                    selector:@selector(undoWorldEdit:)
                                      object:world];
    [self.undoManager endUndoGrouping];
    
}


// the idea is to keep the node on which the user is centered the same, despite changes in scale
// we have to find the nodes at the center point (origin), then make sure they dont move by time traveling into the future and adjusting beforehand
- (void) adjustWorldPositionToScale:(double)scale {
    CGPoint anchorPoint = [_touchForDragAndZoom locationInNode:self];

    CGPoint anchorPointInWorld = [_currentLevel convertPoint:anchorPoint fromNode:self];
    
    [_currentLevel setScale:scale];
    
    CGPoint worldAnchorPointInScene = [self convertPoint:anchorPointInWorld fromNode:_currentLevel];
    CGPoint translationOfAnchorInScene = CGPointMake(anchorPoint.x - worldAnchorPointInScene.x, anchorPoint.y - worldAnchorPointInScene.y);

    switch (_currentZoomLevel) {
        case three:
            _currentRoundingPoint = 30;
            break;
        case two:
            _currentRoundingPoint = 30;
            break;
        case one:
            _currentRoundingPoint = 30;
            break;
        case zero:
            _currentRoundingPoint = 30;
            break;
            
        case negativeOne:
            _currentRoundingPoint = 30;
            break;
            
    }
        
        _currentLevel.position = CGPointMake(RoundTo((_currentLevel.position.x + translationOfAnchorInScene.x), _currentRoundingPoint), RoundTo((_currentLevel.position.y + translationOfAnchorInScene.y), _currentRoundingPoint));
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"zoom changed" object:nil];
    
}

- (void)deleteSelection {
    
    if (_selectionAreaNode) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self storeWorldState];
        });
        
        if (!_selectionAreaNodeFrameNode) {
            
            CGRect areaNodeBoundingBox = CGPathGetBoundingBox(_selectionAreaNode.path);
            CGPoint areaNodeBoundingBoxMidPoint = CGPointMake(CGRectGetMidX(areaNodeBoundingBox), CGRectGetMidY(areaNodeBoundingBox));
            _selectionAreaNodeFrameNode = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:areaNodeBoundingBox.size];
            [_currentLevel addChild:_selectionAreaNodeFrameNode];
            _selectionAreaNodeFrameNode.position = areaNodeBoundingBoxMidPoint;
        }
        
        int xPos = CGRectGetMinX(_selectionAreaNodeFrameNode.frame);
        int yPos = CGRectGetMaxY(_selectionAreaNodeFrameNode.frame) - 30;
        
        while (yPos >= _selectionAreaNodeFrameNode.frame.origin.y) {
            
            if (xPos >= CGRectGetMaxX(_selectionAreaNodeFrameNode.frame)) {
                xPos = CGRectGetMinX(_selectionAreaNodeFrameNode.frame);
                yPos -= 30;
                continue;
            }
            
            [_currentLevel enumerateChildNodesWithName:@"tile" usingBlock:^(SKNode *node, BOOL *stop) {
                if ([_selectionAreaNodeFrameNode containsPoint:node.position]) {
                    if (![_selectionAreaArray containsObject:node]) {
                        [node removeFromParent];
                    }
                }
                
            }];
            xPos += 30;

        }
    }
    
    
}

-(void)handleDoubleTouchForBeganTouches:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!_zoomEnabled || !_dragEnabled) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    if (!_touchForDragAndZoom) {
        _touchForDragAndZoom = touch;
        
    }
    touchLocation = [_touchForDragAndZoom locationInNode:self];
    _differenceBetweenInitialTouchPointAndWorldPosition = CGPointMake(touchLocation.x - _currentLevel.position.x, touchLocation.y - _currentLevel.position.y);
    
    UITouch* thisTouch = touch;
    for (UITouch* touch in [[event touchesForView:self.view] allObjects]) {
        if (![touch isEqual:thisTouch]) {
            UITouch* thatTouch = touch;
            _originalYDifferenceBetweenPinchTouches = fabsf([thisTouch locationInNode:self].y - [thatTouch locationInNode:self].y);
            _previousYDifferenceBetweenPinchTouches = _originalYDifferenceBetweenPinchTouches;
            return;
        }
    }
    
}

-(void)handleDoubleTouchForMovedTouches:(NSSet *)touches withEvent:(UIEvent *)event{
    if (!_zoomEnabled || !_dragEnabled) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    ////for zoom
    UITouch* thisTouch = touch;
    for (UITouch* touch in [[event touchesForView:self.view] allObjects]) {
        if (![touch isEqual:thisTouch]) {
            UITouch* thatTouch = touch;
            float currentYdifferenceBetweenTouches = fabsf([thisTouch locationInNode:self].y - [thatTouch locationInNode:self].y);
            
            float differenceOfDifferences = fabsf(currentYdifferenceBetweenTouches - _previousYDifferenceBetweenPinchTouches);
            BOOL differenceLargerEnoughToExpand = (differenceOfDifferences > (_originalYDifferenceBetweenPinchTouches / 1)) & (_originalYDifferenceBetweenPinchTouches != 0);
            BOOL differenceLargerEnoughToShrink = (differenceOfDifferences > (_originalYDifferenceBetweenPinchTouches / 4)) & (_originalYDifferenceBetweenPinchTouches != 0);
            
            BOOL positiveDifference = currentYdifferenceBetweenTouches > _previousYDifferenceBetweenPinchTouches;
            
            if ((differenceLargerEnoughToExpand || differenceLargerEnoughToShrink) & (differenceOfDifferences > 50)) {
                //NSLog(@"(_originalYDifferenceBetweenPinchTouches / 1): %f", (_originalYDifferenceBetweenPinchTouches / 1));
                //NSLog(@"differenceOfDifferences: %f", differenceOfDifferences);
                
                
                _zoomInAction = true;
                
                
                switch (_currentZoomLevel) {
                    case three:
                        if (positiveDifference & differenceLargerEnoughToExpand) {
                            _currentZoomLevel = two;
                            [self adjustWorldPositionToScale:.2];
                            _previousYDifferenceBetweenPinchTouches = currentYdifferenceBetweenTouches;
                        }
                        return;
                    case two:
                        if (!positiveDifference & differenceLargerEnoughToShrink) {
                            _currentZoomLevel = three;
                            [self adjustWorldPositionToScale:.1];
                            _previousYDifferenceBetweenPinchTouches = currentYdifferenceBetweenTouches;
                            return;
                        }
                        if (positiveDifference & differenceLargerEnoughToExpand) {
                            _currentZoomLevel = one;
                            [self adjustWorldPositionToScale:.5];
                            _previousYDifferenceBetweenPinchTouches = currentYdifferenceBetweenTouches;
                            return;
                        }
                    case one:
                        if (!positiveDifference & differenceLargerEnoughToShrink) {
                            _currentZoomLevel = two;
                            [self adjustWorldPositionToScale:.2];
                            _previousYDifferenceBetweenPinchTouches = currentYdifferenceBetweenTouches;
                            return;
                        }
                        if (positiveDifference & differenceLargerEnoughToExpand) {
                            _currentZoomLevel = zero;
                            [self adjustWorldPositionToScale:1];
                            _previousYDifferenceBetweenPinchTouches = currentYdifferenceBetweenTouches;
                            return;
                        }
                        
                    case zero:
                        if (!positiveDifference & differenceLargerEnoughToShrink) {
                            _currentZoomLevel = one;
                            [self adjustWorldPositionToScale:.5];
                            _previousYDifferenceBetweenPinchTouches = currentYdifferenceBetweenTouches;
                            return;
                        }
                        
                        if (positiveDifference & differenceLargerEnoughToExpand) {
                            _currentZoomLevel = negativeOne;
                            [self adjustWorldPositionToScale:2];
                            _previousYDifferenceBetweenPinchTouches = currentYdifferenceBetweenTouches;
                            return;
                        }
                        
                    case negativeOne:
                        if (!positiveDifference & differenceLargerEnoughToShrink) {
                            _currentZoomLevel = zero;
                            [self adjustWorldPositionToScale:1];
                            _previousYDifferenceBetweenPinchTouches = currentYdifferenceBetweenTouches;
                        }
                        return;
                        
                }
                
            }
        }
    }
    
    if (!_zoomInAction) {
        ////for drag
        touchLocation = [_touchForDragAndZoom locationInNode:self];
        
        _currentLevel.position = CGPointMake(touchLocation.x - _differenceBetweenInitialTouchPointAndWorldPosition.x, touchLocation.y - _differenceBetweenInitialTouchPointAndWorldPosition.y);
        
        _currentLevel.position = CGPointMake(RoundTo(_currentLevel.position.x, _currentRoundingPoint), RoundTo(_currentLevel.position.y, _currentRoundingPoint));
        return;
    }
    
    
    
}

-(void)handleBoxSelectionForBeganTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    if (!_boxSelectionEnabled) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    switch (_currentBoxSelectionType) {
        case boxMake:
        {
            //NSLog(@"[[event touchesForView:self.view] count]: %d", [[event touchesForView:self.view] count]);
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .015 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                if ([[event touchesForView:self.view] count] == 1) {
                    
                    if (_selectionAreaNode) {
                        [_selectionAreaNode removeFromParent];
                        _selectionAreaNode = nil;
                        if (_selectionAreaNodeFrameNode) {
                            [_selectionAreaNodeFrameNode removeFromParent];
                            _selectionAreaNodeFrameNode = nil;
                        }
                    }
                    
                    CGPoint touchLocationInWorld = [self convertPoint:touchLocation toNode:_currentLevel];
                    _startPoint = CGPointMake(RoundTo(touchLocationInWorld.x, _currentRoundingPoint), RoundTo(touchLocationInWorld.y, _currentRoundingPoint));
                    _selectionAreaNode = [SKShapeNode node];
                    _selectionAreaNode.zPosition = 100;
                    _selectionAreaNode.lineWidth = 1.0;
                    _selectionAreaNode.strokeColor = [SKColor blackColor];
                    SKColor *fillColor = [[SKColor blueColor] colorWithAlphaComponent:.1];
                    _selectionAreaNode.fillColor = fillColor;
                    [_currentLevel addChild:_selectionAreaNode];
                    
                    return;
                }
                
            });
            break;
        }
            
        case cutAndDrag:
        case copyAndDrag:
            if (_selectionAreaNode) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self storeWorldState];
                    });
                if (!_selectionAreaNodeFrameNode || _boxJustFilled) {
                    if (!_boxJustFilled) {
                        
                        CGPoint touchLocationInWorld = [self convertPoint:touchLocation toNode:_currentLevel];
                        
                        _differenceBetweenInitialTouchPointAndBoxPosition = CGPointMake(touchLocationInWorld.x - _selectionAreaNode.position.x, touchLocationInWorld.y - _selectionAreaNode.position.y);
                        _selectionAreaNodePreviousPosition = _selectionAreaNode.position;
                        
                        CGRect areaNodeBoundingBox = CGPathGetBoundingBox(_selectionAreaNode.path);
                        CGPoint areaNodeBoundingBoxMidPoint = CGPointMake(CGRectGetMidX(areaNodeBoundingBox), CGRectGetMidY(areaNodeBoundingBox));
                        _selectionAreaNodeFrameNode = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:areaNodeBoundingBox.size];
                        [_currentLevel addChild:_selectionAreaNodeFrameNode];
                        _selectionAreaNodeFrameNode.position = areaNodeBoundingBoxMidPoint;
                    }
                    else {
                        _boxJustFilled = false;
                    }
                    
                    
                    _selectionAreaArray = [NSMutableArray array];
                    if (_currentBoxSelectionType == cutAndDrag) {
                        
                        [_currentLevel enumerateChildNodesWithName:@"tile" usingBlock:^(SKNode *node, BOOL *stop) {
                            if ([_selectionAreaNodeFrameNode containsPoint:node.position]) {
                                node.zPosition = 1;
                                [_selectionAreaArray addObject:node];
                            }
                        }];
                    }
                    else if (_currentBoxSelectionType == copyAndDrag) {
                        [_currentLevel enumerateChildNodesWithName:@"tile" usingBlock:^(SKNode *node, BOOL *stop) {
                            if ([_selectionAreaNodeFrameNode containsPoint:node.position]) {
                                SKNode *copyNode = [node copy];
                                [node.parent addChild:copyNode];
                                copyNode.zPosition = 1;
                                [_selectionAreaArray addObject:copyNode];
                            }
                        }];
                        
                    }
                        return;
                }
                
                else {
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .015 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                        if ([[event touchesForView:self.view] count] == 1) {
                            
                            if (_selectionAreaNodeFrameNode) {
                                
                                CGPoint touchLocationInWorld = [self convertPoint:touchLocation toNode:_currentLevel];
                                BOOL boxContainsPoint = false;
                                for (SKSpriteNode* node in _selectionAreaArray) {
                                    node.zPosition = 0;
                                    if ([node containsPoint:touchLocationInWorld]) {
                                        boxContainsPoint = true;
                                        break;
                                    }
                                }
                                
                                if (!boxContainsPoint) {
                                    [_currentLevel enumerateChildNodesWithName:@"tile" usingBlock:^(SKNode *node, BOOL *stop) {
                                        if ([_selectionAreaNodeFrameNode containsPoint:node.position]) {
                                            if (![_selectionAreaArray containsObject:node]) {
                                                [node removeFromParent];
                                            }
                                        }
                                        
                                    }];
                                    [_selectionAreaNode removeFromParent];
                                    _selectionAreaNode = nil;
                                    [_selectionAreaNodeFrameNode removeFromParent];
                                    _selectionAreaNodeFrameNode = nil;
                                    [_selectionAreaArray removeAllObjects];
                                    
                                }
                                
                            }
                        }
                    });
                    
                }
                return;
            }
            case fill:
                if (_currentlySelectedTileForBrush.image) {
                    if (_selectionAreaNode) {
                            
                            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                [self storeWorldState];
                            });
                        
                            if (!_selectionAreaNodeFrameNode) {
                                
                                CGRect areaNodeBoundingBox = CGPathGetBoundingBox(_selectionAreaNode.path);
                                CGPoint areaNodeBoundingBoxMidPoint = CGPointMake(CGRectGetMidX(areaNodeBoundingBox), CGRectGetMidY(areaNodeBoundingBox));
                                _selectionAreaNodeFrameNode = [SKSpriteNode spriteNodeWithColor:[UIColor clearColor] size:areaNodeBoundingBox.size];
                                [_currentLevel addChild:_selectionAreaNodeFrameNode];
                                _selectionAreaNodeFrameNode.position = areaNodeBoundingBoxMidPoint;
                            }
                            CGPoint touchLocationInWorld = [self convertPoint:touchLocation toNode:_currentLevel];
                            if ([_selectionAreaNodeFrameNode containsPoint:touchLocationInWorld]) {
                        
                                int xPos = CGRectGetMinX(_selectionAreaNodeFrameNode.frame);
                                int yPos = CGRectGetMaxY(_selectionAreaNodeFrameNode.frame) - 30;
                            
                                [_currentLevel enumerateChildNodesWithName:@"tile" usingBlock:^(SKNode *node, BOOL *stop) {
                                    if ([_selectionAreaNodeFrameNode containsPoint:node.position]) {
                                        if (![_selectionAreaArray containsObject:node]) {
                                            [node removeFromParent];
                                        }
                                    }
                                    
                                }];
                            
                                while (yPos >= _selectionAreaNodeFrameNode.frame.origin.y) {
                                    
                                    if (xPos >= CGRectGetMaxX(_selectionAreaNodeFrameNode.frame)) {
                                        xPos = CGRectGetMinX(_selectionAreaNodeFrameNode.frame);
                                        yPos -= 30;
                                        continue;
                                    }
                                    
                                    SKTexture* brushTexture = [SKTexture textureWithImage:_currentlySelectedTileForBrush.image];
                                    brushTexture.filteringMode = SKTextureFilteringNearest;
                                    Tile* node = [Tile spriteNodeWithTexture:brushTexture];
                                    node.anchorPoint = CGPointZero;
                                    node.position = CGPointMake(RoundTo(xPos, _currentRoundingPoint), RoundTo(yPos, _currentRoundingPoint));
                                   // NSNumber *currentGid = [NSNumber numberWithInt:_currentlySelectedTileForBrush.gid];
                                    //[node.userData setObject:currentGid forKey:@"gid"];
                                    node.gid = _currentlySelectedTileForBrush.gid;
                                    node.name = @"tile";
                                    [_currentLevel addChild:node];
                                    
                                    xPos += 30;
                                    
                                }
                                _boxJustFilled = true;
                                return;
                            }
                            else {
                                [_selectionAreaNode removeFromParent];
                                _selectionAreaNode = nil;
                                [_selectionAreaNodeFrameNode removeFromParent];
                                _selectionAreaNodeFrameNode = nil;
                                [_selectionAreaArray removeAllObjects];
                            }
                        }
                    
        }

            
    }

    
}

-(void)handleBoxSelectionForMovedTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    if (!_boxSelectionEnabled) {
        return;
    }
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
        
    switch (_currentBoxSelectionType) {
        case boxMake:
        {
            
            CGPoint touchLocationInWorld = [self convertPoint:touchLocation toNode:_currentLevel];
            
            CGPoint point = CGPointMake(RoundTo(touchLocationInWorld.x, _currentRoundingPoint), RoundTo(touchLocationInWorld.y, _currentRoundingPoint));
            
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, _startPoint.x, _startPoint.y);
            CGPathAddLineToPoint(path, NULL, _startPoint.x, point.y);
            CGPathAddLineToPoint(path, NULL, point.x, point.y);
            CGPathAddLineToPoint(path, NULL, point.x, _startPoint.y);
            CGPathCloseSubpath(path);
            
            // set the shape layer's path
            
            _selectionAreaNode.path = path;
            
            CGPathRelease(path);
            return;
            
        }
            
        case cutAndDrag:
        case copyAndDrag:
            
            if (_selectionAreaNode) {
                
                CGPoint touchLocationInWorld = [self convertPoint:touchLocation toNode:_currentLevel];
                _selectionAreaNode.position = CGPointMake(touchLocationInWorld.x - _differenceBetweenInitialTouchPointAndBoxPosition.x, touchLocationInWorld.y - _differenceBetweenInitialTouchPointAndBoxPosition.y);
                _selectionAreaNode.position = CGPointMake(RoundTo(_selectionAreaNode.position.x, _currentRoundingPoint), RoundTo(_selectionAreaNode.position.y, _currentRoundingPoint));
                
                CGPoint differenceBetweenCurrentAndPreviousPositions = CGPointMake(_selectionAreaNode.position.x - _selectionAreaNodePreviousPosition.x, _selectionAreaNode.position.y - _selectionAreaNodePreviousPosition.y);
                
                for (SKSpriteNode* node in _selectionAreaArray) {
                    node.position = CGPointMake(node.position.x + differenceBetweenCurrentAndPreviousPositions.x, node.position.y + differenceBetweenCurrentAndPreviousPositions.y);
                }
                
                _selectionAreaNodeFrameNode.position = CGPointMake(_selectionAreaNodeFrameNode.position.x + differenceBetweenCurrentAndPreviousPositions.x, _selectionAreaNodeFrameNode.position.y + differenceBetweenCurrentAndPreviousPositions.y);
                
                _selectionAreaNodePreviousPosition = _selectionAreaNode.position;
                
                
                
            }
        case fill:
        break;
            
    }
    return;
    
    
    
}

-(void)handleTileDragForBeganTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       // [self.undoManager setGroupsByEvent:NO];
       // [self.undoManager beginUndoGrouping];
        [self storeWorldState];
        //[self.undoManager endUndoGrouping];
        //[self.undoManager setGroupsByEvent:YES];
    });
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    NSArray* touchedTiles = [self nodesAtPoint:touchLocation];

    
    for (SKSpriteNode* node in touchedTiles) {
        if (CGSizeEqualToSize(node.frame.size, CGSizeMake(30, 30))) {
            _touchedTile = node;
            break;
        }
        
    }
    if (_touchedTile) {
        CGPoint touchedTilePositionInScene = [self convertPoint:_touchedTile.position fromNode:[_touchedTile parent]];
        _differenceBetweenInitialTouchPointAndTilePosition = CGPointMake(touchLocation.x - touchedTilePositionInScene.x, touchLocation.y - touchedTilePositionInScene.y);
        
    }
    
}

-(void)handleTileDragForMovedTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    
    _touchedTile.anchorPoint = CGPointZero;
    _touchedTile.position = [self convertPoint:CGPointMake(touchLocation.x - _differenceBetweenInitialTouchPointAndTilePosition.x, touchLocation.y - _differenceBetweenInitialTouchPointAndTilePosition.y) toNode:[_touchedTile parent]];
    _touchedTile.position = CGPointMake(RoundTo(_touchedTile.position.x, _currentRoundingPoint), RoundTo(_touchedTile.position.y, _currentRoundingPoint));
    return;

    
}

-(void)handleTileDragForEndedTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    
    NSArray* touchedTiles = [self nodesAtPoint:[self convertPoint:[_touchedTile calculateAccumulatedFrame].origin fromNode:[_touchedTile parent]]];
    for (SKSpriteNode* node in touchedTiles) {
        if ((CGSizeEqualToSize(node.frame.size, CGSizeMake(30, 30))) & !(_touchedTile == node)) {
            [node removeFromParent];
            continue;
        }
        
    }
    
}


-(void)handleTileBrushForBeganTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    NSArray* touchedTiles = [self nodesAtPoint:touchLocation];
    
    for (SKSpriteNode* node in touchedTiles) {
        if ((CGSizeEqualToSize(node.frame.size, CGSizeMake(30, 30))) & !(_touchedTile == node)) {
            [node removeFromParent];
            continue;
        }
        
    }
    
    SKTexture* brushTexture = [SKTexture textureWithImage:_currentlySelectedTileForBrush.image];
    brushTexture.filteringMode = SKTextureFilteringNearest;
    Tile* brushSprite = [Tile spriteNodeWithTexture:brushTexture];
    
    CGPoint touchLocationInWorld = [self convertPoint:touchLocation toNode:_currentLevel];
    brushSprite.anchorPoint = CGPointZero;
    brushSprite.position = CGPointMake(RoundDownTo(touchLocationInWorld.x, 30), RoundDownTo(touchLocationInWorld.y, 30));
    brushSprite.name = @"tile";
    brushSprite.gid = _currentlySelectedTileForBrush.gid;

//    
//    Chunk theChunk = [[Chunk alloc] init];
//    [theEChunk addChild:brushSprite];
//    theChunk.lowerLeftCorner = brushSprite.position;
//    theChunk.name = @"x0y0";
//    [_currentLevel addChild:theChunk];
   Chunk* theRightChunk = [_currentLevel getAppropriateChunkForNewTileOrMakeOneUp:brushSprite];
    [theRightChunk addChild:brushSprite];
    
    
        
    
    
}

-(void)handleTileBrushForMovedTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    [self handleTileBrushForBeganTouches:touches withEvent:event];

}

-(void)handleTileEraserForBeganTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    NSArray* touchedTiles = [self nodesAtPoint:touchLocation];

    
    for (SKSpriteNode* node in touchedTiles) {
        if (CGSizeEqualToSize(node.frame.size, CGSizeMake(30, 30))) {
            [node removeFromParent];
            break;
        }
    }
}

-(void)handleTileEraserForMovedTouches: (NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self];
    NSArray* touchedTiles = [self nodesAtPoint:touchLocation];
    
    for (SKSpriteNode* node in touchedTiles) {
        if (CGSizeEqualToSize(node.frame.size, CGSizeMake(30, 30))) {
            [node removeFromParent];
            break;
        }
    }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if ([[event touchesForView:self.view] count] == 2) {
        [self handleDoubleTouchForBeganTouches:touches withEvent:event];
        return;
    }
    
    switch (_currentSelectionType) {
            
        case boxSelection:
            [self handleBoxSelectionForBeganTouches:touches withEvent:event];
            return;
            
        case tileDrag:
            [self handleTileDragForBeganTouches:touches withEvent:event];
            return;
            
        case tileBrush:
            
            if (_currentlySelectedTileForBrush.image) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [self storeWorldState];
                });
                [self handleTileBrushForBeganTouches:touches withEvent:event];
            }
            return;
            
        case tileEraser:
        {
            [self handleTileEraserForBeganTouches:touches withEvent:event];
            return;
        
        }
    }

  
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if ([[event touchesForView:self.view] count] == 2) {
        [self handleDoubleTouchForMovedTouches:touches withEvent:event];
        return;

    }

    switch (_currentSelectionType) {
            
        case boxSelection:
            [self handleBoxSelectionForMovedTouches:touches withEvent:event];
            return;

            
        case tileDrag:
            
            if (_touchedTile) {
                [self handleTileDragForMovedTouches:touches withEvent:event];
                //return;
            }
            return;
            
        case tileBrush: //some stuff
            if (_currentlySelectedTileForBrush.image) {
                [self handleTileBrushForMovedTouches:touches withEvent:event];
                //return;
            }
            return;
            
        case tileEraser: //some stuff
            [self handleTileEraserForMovedTouches:touches withEvent:event];
            return;

            
    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_touchForDragAndZoom) {
        _touchForDragAndZoom = nil;
    }
    

    switch (_currentSelectionType) {

        case boxSelection: ;//some stuff
        {
            switch (_currentBoxSelectionType) {
                case boxMake:
                case cutAndDrag:
                case copyAndDrag:
                case fill:

                    break;
            }
        }
            break;
        case tileDrag: ;//some stuff
            
            if (_touchedTile) {
                [self handleTileDragForEndedTouches:touches withEvent:event];
            }
            break;
            
        case tileBrush:
            break;
            
        case tileEraser:
            break;
            
    }
        
    _differenceBetweenInitialTouchPointAndWorldPosition = CGPointZero;
    _differenceBetweenInitialTouchPointAndTilePosition = CGPointZero;
    _originalYDifferenceBetweenPinchTouches = 0;
    _previousYDifferenceBetweenPinchTouches = 0;
    _touchedTile = nil;
    _zoomInAction = false;

        return;

}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

@end
