//
//  MyScene.m
//  TileMapADTtest
//
//  Created by John Feldcamp on 6/20/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "GameplayScene.h"
#import "Chunk.h"
#import "LevelComponent.h"
#import "PhysicsComponent.h"
#import "HudComponent.h"
#import "ControlComponent.h"
#import "AnimationComponent.h"

@implementation GameplayScene{
    
}


//- (id) initWithSize:(CGSize)size {
- (id) initWithLevel:(NSString*)levelName {
    //if (self = [super initWithSize:size])
    // {
         
         
         //////
         // _currentLevel = [[LevelComponent alloc] initLevel];
        //_currentLevel = some core data magic with levelName
        [self addChild:_currentLevel];
         //////
         
         
         //////
         _playerControls = [[ControlComponent alloc] initControlsForChunkSize:CGSizeMake(self.size.width, self.size.height)];
         //////
         
         
         //////
        // _world = [[SKNode alloc] init];
         //[self addChild:_world];
        // _worldObjects = [[SKNode alloc] init];
         //[_world addChild:_worldObjects];
         //////
         
         
         //////
         _hud = [[SKNode alloc] init];
         [self addChild:_hud];
         _hud.position = CGPointMake((self.frame.origin.x - (self.frame.size.width / 2)), (self.frame.origin.y - (self.frame.size.height / 2)));
         _hud.zPosition = 5;
         _playerHud = [[HudComponent alloc] initInGameMenu];
         [_hud addChild:_playerControls.dpadLeft];
         [_hud addChild:_playerControls.dpadRight];
         //////
         
         //////////
         
         
         ///
         _playerAnimations = [[AnimationComponent alloc] initAnimationDictionary];
         [_playerAnimations addAnimationWithImage: @"kaseybare" forSpriteSize:CGSizeMake(90, 90)];
         
         _playerAnimations.run = NSMakeRange(0, 4);
         _playerAnimations.runLeft = NSMakeRange(5, 4);
         
         _playerAnimations.stand = NSMakeRange(10, 6);
         _playerAnimations.standLeft = NSMakeRange(17, 6);
         
         _playerAnimations.standAtEdge = NSMakeRange(24, 6);
         _playerAnimations.standAtEdgeLeft = NSMakeRange(21, 6);
         
         _playerAnimations.standOnSingleTile = NSMakeRange(38, 6);
         _playerAnimations.standOnSingleTileLeft = NSMakeRange(45, 6);
         
         _playerAnimations.turnLeft = NSMakeRange(52, 2);
         _playerAnimations.turnRight = NSMakeRange(55, 2);
         
         _playerAnimations.prone = NSMakeRange(58, 4);
         _playerAnimations.proneLeft = NSMakeRange(63, 4);
         
         _playerAnimations.crawl = NSMakeRange(68, 8);
         _playerAnimations.crawlLeft = NSMakeRange(77, 8);
         
         _playerAnimations.jumpHorizontalPreApex = NSMakeRange(86, 3);
         _playerAnimations.jumpHorizontalPostApex = NSMakeRange(90, 2);
         _playerAnimations.jumpHorizontalPreApexLeft = NSMakeRange(93, 3);
         _playerAnimations.jumpHorizontalPostApexLeft = NSMakeRange(97, 2);
         
         _playerAnimations.jumpVerticalPreApex = NSMakeRange(100, 3);
         _playerAnimations.jumpVerticalPostApex = NSMakeRange(104, 2);
         _playerAnimations.jumpVerticalPreApexLeft = NSMakeRange(107, 3);
         _playerAnimations.jumpVerticalPostApexLeft = NSMakeRange(111, 2);
         
         _playerAnimations.landOnLedge = NSMakeRange(114, 2);
         _playerAnimations.landOnLedgeLeft = NSMakeRange(117, 2);
         
         _playerAnimations.hangOnLedge = NSMakeRange(120, 19);
         _playerAnimations.hangOnLedgeLeft = NSMakeRange(140, 19);
         
         _playerAnimations.climbToCrawl = NSMakeRange(160, 5);
         _playerAnimations.climbToCrawlLeft = NSMakeRange(166, 5);
         
         _playerAnimations.climbToStand = NSMakeRange(172, 6);
         _playerAnimations.climbToStandLeft = NSMakeRange(179, 6);
         
         
         _playerAnimations.previousFrameRange = _playerAnimations.stand;
         _player = [SKSpriteNode spriteNodeWithTexture:[[_playerAnimations.animationDictionary objectForKey:@"kaseybare"] objectAtIndex:_playerAnimations.stand.location]];
         ///
         
         
         _player.position = CGPointMake(([Chunk getChunkSize].width / 8), ([Chunk getChunkSize].height / 2));
         _player.zPosition = 4;
         _playerPhysics = [[PhysicsComponent alloc] init];
         [_currentLevel addChild:_player];
         _playerPhysics.testBoundingBox.zPosition = 5;
         [_currentLevel addChild:_playerPhysics.testBoundingBox];
         //////////
         
         _tileAnchorpointOffsetx = TILE_SIZE / 2;
         _tileAnchorpointOffsety = TILE_SIZE / 2;
         
         //////
         
       //  currentLevel.chunkE.readyToLoad = true;
         [self loadChunk:_currentLevel.chunkE];
         //NSLog(@"chunkE loaded");
         [self centerCameraOnPlayer];
         _cameraInitiallyCentered = true;
         //_currentLevel.chunkE.frame = CGRectMake(0, 0, TILE_SIZE * [Chunk getChunkSize].width, TILE_SIZE * [Chunk getChunkSize].height);
         
         [_currentLevel updateChunkGrid];
         [self chooseChunksToLoad];
       //
         
         self.backgroundColor = [SKColor brownColor];
         self.anchorPoint = CGPointMake (.5,.5);
         self.userInteractionEnabled = YES;
    // }
    
   return self;
}


// load chunk of a specific letter A - I

- (void) loadChunk: (Chunk*)chunk {
//    
//    chunk.layers = [[SKNode alloc] init];
//    chunk.objects = [[SKNode alloc] init];
//    [_world addChild:chunk.layers];
//    [_worldObjects addChild:chunk.objects];
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
//                currentTile.position = CGPointMake(tilex + _tileAnchorpointOffsetx + _currentLevel.chunkE.frame.origin.x + chunk.tileXModifier, tiley + _tileAnchorpointOffsety + _currentLevel.chunkE.frame.origin.y + chunk.tileYModifier);
//                currentTile.zPosition = zPosition;
//                [chunk.layers addChild:currentTile];
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
//                currentTile.position = CGPointMake(currentObjectxCoordinate + _tileAnchorpointOffsetx + _currentLevel.chunkE.frame.origin.x + chunk.tileXModifier, currentObjectyCoordinate + _tileAnchorpointOffsety + _currentLevel.chunkE.frame.origin.y + chunk.tileYModifier);
//                currentTile.zPosition = zPosition;
//                [chunk.objects addChild:currentTile];
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
//        zPosition ++;
//    }
//
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        for (UITouch *touch in touches) {
            CGPoint touchLocation = [touch locationInNode:_hud];
        
            if ([_playerControls.dpadLeft containsPoint:touchLocation]) {
                //NSLog(@"touch in dpadleft");
                _playerControls.firstTouchLocationLeft = touchLocation;
            }
        
            else if ([_playerControls.dpadRight containsPoint:touchLocation]) {
                //NSLog(@"touch in dpadright");
                _playerControls.firstTouchLocationRight = touchLocation;
                }
        
        }
}
        



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
        for (UITouch *touch in touches) {
            CGPoint touchLocation = [touch locationInNode:_hud];
            CGPoint previousTouchLocation = [touch previousLocationInNode:_hud];
            if (!CGPointEqualToPoint (touchLocation, previousTouchLocation)) {
        
                if ([_playerControls.dpadLeft containsPoint:touchLocation]) {
                    //NSLog(@"touch in dpadleft");
                    _playerControls.currentTouchLocationLeft = touchLocation;
                    [_playerControls leftDpad:_playerPhysics asSpriteNode:_player withAnimation:_playerAnimations];
                
                }
        
                else if ([_playerControls.dpadRight containsPoint:touchLocation]) {
                    //NSLog(@"touch in dpadright");
                    _playerControls.currentTouchLocationRight = touchLocation;
                    [_playerControls rightDpad:_playerPhysics asSpriteNode:_player withAnimation:_playerAnimations];
                }
        }
    }
  
}



-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
        for (UITouch *touch in touches) {
            CGPoint touchLocation = [touch locationInNode:_hud];
            if ([_playerControls.dpadLeft containsPoint:touchLocation]) {
                    _playerPhysics.actualThrust = CGPointMake(0, _playerPhysics.actualThrust.y);
                    _playerPhysics.walkInAction = false;
            }
            else if ([_playerControls.dpadRight containsPoint:touchLocation]) {
            }
        
            else {
                    _playerPhysics.actualThrust = CGPointMake(0, _playerPhysics.actualThrust.y);
                    _playerPhysics.walkInAction = false;
            
            }

    }

}


-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}

-(void)update:(CFTimeInterval)currentTime {

        [self checkForChunkGridUpdate];
    // possibly a huge problem. the system was not build for _currentLevel, but for the now-obselete _worldObjects
    // but it removes the red, so fuck it
        [_playerPhysics delegateActionsForPhysicsObject:_player inObjectNode:_currentLevel forChunk:_currentLevel.chunkE];
        [_playerAnimations chooseAppropriateAnimationFor:_player asPhysicsObject:_playerPhysics];
        [self centerCameraOnPlayer];
        return;
}



- (void) checkForChunkGridUpdate {
    
    if (CGRectContainsPoint(_currentLevel.chunkE.frame, _player.position)) {
        return;
    }
    
    else if (CGRectContainsPoint(_currentLevel.chunkA.frame, _player.position)) {
        
        [_currentLevel.chunkC removeAllChildren];
        [_currentLevel.chunkF removeAllChildren];
        [_currentLevel.chunkG removeAllChildren];
        [_currentLevel.chunkH removeAllChildren];
        [_currentLevel.chunkI removeAllChildren];
        
        [_currentLevel centerChunkGridOnChunk:_currentLevel.chunkA];
        [self chooseChunksToLoad];
        
        return;
    }
    
    else if (CGRectContainsPoint(_currentLevel.chunkB.frame, _player.position)) {
        
        [_currentLevel.chunkG removeAllChildren];
        [_currentLevel.chunkH removeAllChildren];
        [_currentLevel.chunkI removeAllChildren];
        
        [_currentLevel centerChunkGridOnChunk:_currentLevel.chunkB];
        [self chooseChunksToLoad];
        
        return;
        
    }
    
    else if (CGRectContainsPoint(_currentLevel.chunkC.frame, _player.position)) {
        
        [_currentLevel.chunkA removeAllChildren];
        [_currentLevel.chunkD removeAllChildren];
        [_currentLevel.chunkG removeAllChildren];
        [_currentLevel.chunkH removeAllChildren];
        [_currentLevel.chunkI removeAllChildren];

        [_currentLevel centerChunkGridOnChunk:_currentLevel.chunkC];
        [self chooseChunksToLoad];
        
        return;
        
        
    }
    
    else if (CGRectContainsPoint(_currentLevel.chunkD.frame, _player.position)) {
        
        [_currentLevel.chunkC removeAllChildren];
        [_currentLevel.chunkF removeAllChildren];
        [_currentLevel.chunkI removeAllChildren];

        [_currentLevel centerChunkGridOnChunk:_currentLevel.chunkD];
        [self chooseChunksToLoad];
        
        return;
    }
    
    else if (CGRectContainsPoint(_currentLevel.chunkF.frame, _player.position)) {
        
        [_currentLevel.chunkA removeAllChildren];
        [_currentLevel.chunkD removeAllChildren];
        [_currentLevel.chunkG removeAllChildren];
        
        [_currentLevel centerChunkGridOnChunk:_currentLevel.chunkF];
        [self chooseChunksToLoad];
        
        return;
    }
    
    else if (CGRectContainsPoint(_currentLevel.chunkG.frame, _player.position)) {
        
        [_currentLevel.chunkA removeAllChildren];
        [_currentLevel.chunkB removeAllChildren];
        [_currentLevel.chunkC removeAllChildren];
        [_currentLevel.chunkF removeAllChildren];
        [_currentLevel.chunkI removeAllChildren];
        
        [_currentLevel centerChunkGridOnChunk:_currentLevel.chunkG];
        [self chooseChunksToLoad];
        
        return;
    }
    
    else if (CGRectContainsPoint(_currentLevel.chunkH.frame, _player.position)) {
        
        [_currentLevel.chunkA removeAllChildren];
        [_currentLevel.chunkB removeAllChildren];
        [_currentLevel.chunkC removeAllChildren];

        [_currentLevel centerChunkGridOnChunk:_currentLevel.chunkH];
        [self chooseChunksToLoad];
        
        return;
    }
    
    else if (CGRectContainsPoint(_currentLevel.chunkI.frame, _player.position)) {
        
        [_currentLevel.chunkA removeAllChildren];
        [_currentLevel.chunkB removeAllChildren];
        [_currentLevel.chunkC removeAllChildren];
        [_currentLevel.chunkD removeAllChildren];
        [_currentLevel.chunkF removeAllChildren];
        
        [_currentLevel centerChunkGridOnChunk:_currentLevel.chunkI];
        [self chooseChunksToLoad];
        
        return;
    }
    
}

- (void)chooseChunksToLoad {
    
    if (_currentLevel.chunkA.readyToLoad) {
        [self loadChunk:_currentLevel.chunkA];
        //NSLog(@"chunkA loaded");
        _currentLevel.chunkA.readyToLoad = false;
    }
//    else {
//        [ChunkGenerator generateFilledChunkWithTilesize:(CGSize)CGSizeMake(currentLevel.chunkE.tilewidth, currentLevel.chunkE.tileheight) andFrame:(CGRect)currentLevel.chunkA.frame];
//        
//    }
    if (_currentLevel.chunkB.readyToLoad) {
        [self loadChunk:_currentLevel.chunkB];
        //NSLog(@"chunkB loaded");
        _currentLevel.chunkB.readyToLoad = false;
    }
    if (_currentLevel.chunkC.readyToLoad) {
        [self loadChunk:_currentLevel.chunkC];
        //NSLog(@"chunkC loaded");
        _currentLevel.chunkC.readyToLoad = false;
    }
    if (_currentLevel.chunkD.readyToLoad) {
        [self loadChunk:_currentLevel.chunkD];
        //NSLog(@"chunkD loaded");
        _currentLevel.chunkD.readyToLoad = false;
    }
    if (_currentLevel.chunkF.readyToLoad) {
        [self loadChunk:_currentLevel.chunkF];
        //NSLog(@"chunkF loaded");
        _currentLevel.chunkF.readyToLoad = false;
    }
    if (_currentLevel.chunkG.readyToLoad) {
        [self loadChunk:_currentLevel.chunkG];
        //NSLog(@"chunkG loaded");
        _currentLevel.chunkG.readyToLoad = false;
    }
    if (_currentLevel.chunkH.readyToLoad) {
        [self loadChunk:_currentLevel.chunkH];
        //NSLog(@"chunkH loaded");
        _currentLevel.chunkH.readyToLoad = false;
    }
    if (_currentLevel.chunkI.readyToLoad) {
        [self loadChunk:_currentLevel.chunkI];
        //NSLog(@"chunkI loaded");
        _currentLevel.chunkI.readyToLoad = false;
    }
    
}

- (void)centerCameraOnPlayer {
    
    CGPoint playerPositionInScene = [self convertPoint:_player.position  fromNode:_currentLevel];
    //NSLog(@"playerPositionInScene:%f, %f", playerPositionInScene.x, playerPositionInScene.y);
    CGPoint chunkEPositionInScene = [self convertPoint:CGPointMake(_currentLevel.chunkE.frame.origin.x, _currentLevel.chunkE.frame.origin.y)  fromNode:_currentLevel];
    //NSLog(@"chunkEPositionInScene:%f, %f", chunkEPositionInScene.x, chunkEPositionInScene.y);
    //CGSize chunkESizeInPixels = CGSizeMake(([Chunk getChunkSize].width * TILE_SIZE), ([Chunk getChunkSize].height * TILE_SIZE));
    //NSLog(@"chunkEPositionInScene + half chunk width:%f, %f", (chunkEPositionInScene.x + (chunkESizeInPixels.width / 2)), chunkEPositionInScene.y);
    //NSLog(@"world position:%f, %f", world.position.x, world.position.y);
    CGSize chunkSize = [Chunk getChunkSize];
    
    // keep the camera within world bounds
    if (_currentLevel.chunkE.hasLeftEdge) {
            _worldMaxPosition = CGPointMake(_currentLevel.position.x - (chunkEPositionInScene.x + (chunkSize.width / 2)), _worldMaxPosition.y);
        }
    else {
            _worldMaxPosition = CGPointMake(_currentLevel.position.x + 999999, _worldMaxPosition.y);
    }
    
    
    if (_currentLevel.chunkE.hasRightEdge) {
            _worldMinPosition = CGPointMake(_currentLevel.position.x - (chunkEPositionInScene.x + (chunkSize.width / 2)), _worldMinPosition.y);
        }
    else {
            _worldMinPosition = CGPointMake(_currentLevel.position.x - 999999, _worldMinPosition.y);
    }
    
    if (_currentLevel.chunkE.hasTopEdge) {
            _worldMinPosition = CGPointMake(_worldMinPosition.x, _currentLevel.position.y - (chunkEPositionInScene.y + (chunkSize.height / 2)));
    }
    else {
            _worldMinPosition = CGPointMake(_worldMinPosition.x, _currentLevel.position.y - 999999);
    }
    
    if (_currentLevel.chunkE.hasBottomEdge) {
            _worldMaxPosition = CGPointMake(_worldMaxPosition.x, _currentLevel.position.y - (chunkEPositionInScene.y + (chunkSize.height / 2)));
    }
    else {
            _worldMaxPosition = CGPointMake(_worldMaxPosition.x, _currentLevel.position.y + 999999);
    }
  
    CGPoint  _worldDesiredPosition = CGPointMake(_currentLevel.position.x - playerPositionInScene.x, _currentLevel.position.y - playerPositionInScene.y);
    
    
    //////
    if (_worldDesiredPosition.x > _worldMaxPosition.x) {
            _worldDesiredPosition.x = _worldMaxPosition.x;
    }
    
    if (_worldDesiredPosition.x < _worldMinPosition.x) {
            _worldDesiredPosition.x = _worldMinPosition.x;
    }
    
    if (_worldDesiredPosition.y > _worldMaxPosition.y) {
            _worldDesiredPosition.y = _worldMaxPosition.y;
    }
    
    if (_worldDesiredPosition.y < _worldMinPosition.y) {
            _worldDesiredPosition.y = _worldMinPosition.y;
    }
    //////
    
    if (_cameraInitiallyCentered) {
        
        if (_playerPhysics.velocity.y == 0) {
            _cameraSpeedY = 1;
        }
        else {
            _cameraSpeedY = abs(_playerPhysics.velocity.y);
        }
        
        if (_playerPhysics.velocity.x == 0) {
            _cameraSpeedX = 1;
        }
        else {
            _cameraSpeedX = abs(_playerPhysics.velocity.x);
        }
        
    
        if (_currentLevel.position.y < _worldDesiredPosition.y) {
            _currentLevel.position = CGPointMake(_currentLevel.position.x, _currentLevel.position.y + _cameraSpeedY);
        }
    
        if (_currentLevel.position.y > _worldDesiredPosition.y) {
            _currentLevel.position = CGPointMake(_currentLevel.position.x, _currentLevel.position.y - 1);
        }
    
        if (_currentLevel.position.x < _worldDesiredPosition.x) {
            _currentLevel.position = CGPointMake(_currentLevel.position.x + _cameraSpeedX, _currentLevel.position.y);
        }
    
        if (_currentLevel.position.x > _worldDesiredPosition.x) {
            _currentLevel.position = CGPointMake(_currentLevel.position.x - _cameraSpeedX, _currentLevel.position.y);
        }
        
        
        
    }
    else {
        _currentLevel.position = CGPointMake(-285, -165);
    }
    
    

}



@end
