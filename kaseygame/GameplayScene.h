//
//  MyScene.h
//  TileMapADTtest
//

//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#import "Chunk.h"
#import "LevelComponent.h"
#import "PhysicsComponent.h"
#import "HudComponent.h"
#import "ControlComponent.h"
#import "AnimationComponent.h"

//@class Chunk;

@interface GameplayScene : SKScene

@property (nonatomic) LevelComponent *currentLevel;

/// world nodes
//@property (nonatomic) SKNode* world;
//@property (nonatomic) SKNode* worldObjects;
@property (nonatomic) CGPoint worldMinPosition;
@property (nonatomic) CGPoint worldMaxPosition;
///

/// hud and in game menu and controls
@property (nonatomic) SKNode* hud;
@property (nonatomic) HudComponent *playerHud;
@property (nonatomic) ControlComponent *playerControls;
///





/// the player
@property (nonatomic) AnimationComponent *playerAnimations;
@property (nonatomic) SKSpriteNode* player;
@property (nonatomic) PhysicsComponent *playerPhysics;
///

/// chunk loading helpers
@property (nonatomic) NSInteger tileAnchorpointOffsetx;
@property (nonatomic) NSInteger tileAnchorpointOffsety;
///

/// to center the camera
@property (nonatomic) BOOL cameraInitiallyCentered;
@property (nonatomic) NSInteger cameraSpeedX;
@property (nonatomic) NSInteger cameraSpeedY;
///


//- (void) loadChunk: (Chunk*)chunk;

@end
