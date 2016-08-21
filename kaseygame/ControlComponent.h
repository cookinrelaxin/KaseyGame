//
//  ControlComponent.h
//  ChunkADT
//
//  Created by John Feldcamp on 7/6/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "PhysicsComponent.h"
#import "AnimationComponent.h"



@interface ControlComponent : NSObject

@property (nonatomic) SKSpriteNode* dpadLeft;
@property (nonatomic) SKSpriteNode* dpadRight;

@property (nonatomic, readonly) NSInteger thresholdForProne;

@property (nonatomic, readonly) NSInteger thresholdForJump;
@property (nonatomic, readonly) NSInteger horizontalJumpPower;
@property (nonatomic, readonly) NSInteger verticalJumpPower;
//@property (nonatomic, readonly) NSInteger jumpMaxDuration;

@property (nonatomic, readonly) NSInteger walkMaxPower;

@property (nonatomic) CGPoint firstTouchLocationLeft;
@property (nonatomic) CGPoint firstTouchLocationRight;
@property (nonatomic) CGPoint currentTouchLocationLeft;
@property (nonatomic) CGPoint currentTouchLocationRight;

@property (nonatomic) float touchDifferenceToObjectVelocityModifierX;
@property (nonatomic) float touchDifferenceToObjectVelocityModifierY;



- (id) initControlsForChunkSize:(CGSize)levelsize;
- (void) leftDpad:(PhysicsComponent*)physicsObject asSpriteNode:(SKSpriteNode*)node withAnimation:(AnimationComponent*)animation;
//- (void) jump: (PhysicsComponent*)physicsObject asSpriteNode:(SKSpriteNode*)node withAnimation:(AnimationComponent*)animation;

- (void) rightDpad: (PhysicsComponent*)physicsObject asSpriteNode:(SKSpriteNode*)node withAnimation:(AnimationComponent*)animation;
//- (void) goProne: (PhysicsComponent*)physicsObject asSpriteNode:(SKSpriteNode*)node withAnimation:(AnimationComponent*)animation;
//- (void) crawl: (PhysicsComponent*)physicsObject asSpriteNode:(SKSpriteNode*)node withAnimation:(AnimationComponent*)animation;






@end
