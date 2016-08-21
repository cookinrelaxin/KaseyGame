//
//  MovementComponent.h
//  ChunkADT
//
//  Created by John Feldcamp on 7/3/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Tile.h"
#import "Chunk.h"

@interface PhysicsComponent : NSObject

@property (nonatomic) SKSpriteNode* testBoundingBox;

//
@property (nonatomic) CGPoint velocity;
@property (nonatomic, readonly) CGPoint defaultMaxVelocity;
@property (nonatomic, readonly) CGPoint defaultMinVelocity;
@property (nonatomic) CGPoint maxVelocity;
@property (nonatomic) CGPoint minVelocity;
@property (nonatomic, readonly) CGPoint gravity;
@property (nonatomic) CGPoint actualThrust;
//desired thrust should never be used outside of this class
@property (nonatomic) CGPoint desiredThrust;
//

//
@property (nonatomic) CGPoint desiredPosition;
//


//
@property (nonatomic) BOOL toIntersectATile;
@property (nonatomic) BOOL toIntersectBTile;
@property (nonatomic) BOOL toIntersectCTile;
@property (nonatomic) BOOL toIntersectDTile;
@property (nonatomic) BOOL toIntersectFTile;
@property (nonatomic) BOOL toIntersectGTile;
@property (nonatomic) BOOL toIntersectHTile;
@property (nonatomic) BOOL toIntersectITile;

@property (nonatomic) BOOL toIntersectLeftEdge;
@property (nonatomic) BOOL toIntersectRightEdge;
@property (nonatomic) BOOL toIntersectTopEdge;
@property (nonatomic) BOOL toIntersectBottomEdge;
//


//
@property (nonatomic) BOOL proneInAction;
@property (nonatomic) BOOL jumpInAction;
@property (nonatomic) BOOL jumpTypeVertical;
@property (nonatomic) BOOL walkInAction;
@property (nonatomic) BOOL onSingleTile;
@property (nonatomic) BOOL atEdge;
@property (nonatomic) BOOL inTunnel;
@property (nonatomic) BOOL positionAdjusted;


//

///
@property (nonatomic) BOOL aboutToLandOnLedgeRight;
@property (nonatomic) BOOL aboutToLandOnLedgeLeft;


@property (nonatomic) BOOL hangingLeft;
@property (nonatomic) BOOL hangingRight;

@property (nonatomic) BOOL letGoFromLeft;
@property (nonatomic) BOOL letGoFromRight;

@property (nonatomic) BOOL aboutToClimbRight;
@property (nonatomic) BOOL aboutToClimbLeft;

@property (nonatomic) BOOL climbIntoCrawl;

@property (nonatomic) BOOL climbingRight;
@property (nonatomic) BOOL climbingLeft;

@property (nonatomic) BOOL climbComplete;

@property (nonatomic) BOOL allowClimb;

@property (nonatomic) BOOL facingLeft;

///

@property (nonatomic) BOOL forceAnimation;




- (id)init;

- (void)updateAdjacentObjectTileGridForPhysicsObject:(SKSpriteNode*)physicsObject inObjectNode:(SKNode*)objects forChunk:(Chunk*)chunk;

//- (CGPoint)calculatePositionOfPhysicsObject:(SKSpriteNode*)physicsObject forChunk:(Chunk*)chunk;

- (void)setPositionOfPhysicsObject:(SKSpriteNode*)physicsObject inObjectNode:(SKNode*)objects forChunk:(Chunk*)chunk;

- (void)delegateActionsForPhysicsObject:(SKSpriteNode*)physicsObject inObjectNode:(SKNode*)objects forChunk:(Chunk*)chunk;

- (void)endWalk;
- (void)endJump;



@end
