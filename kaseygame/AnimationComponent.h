//
//  AnimationComponent.h
//  ChunkADT
//
//  Created by John Feldcamp on 7/11/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "PhysicsComponent.h"



@interface AnimationComponent : NSObject

@property (nonatomic) NSMutableDictionary* animationDictionary;
@property (nonatomic) NSInteger currentIndexInAnimationArray;
@property (nonatomic) NSInteger frameCounter;
@property (nonatomic) NSInteger desiredCountToPresentNextSprite;


//@property (nonatomic) BOOL animationInAction;
//@property (nonatomic) BOOL stateTransitionOccuring;


////////////
@property (nonatomic) NSRange run;
@property (nonatomic) NSRange runLeft;

@property (nonatomic) NSRange stand;
@property (nonatomic) NSRange standLeft;

@property (nonatomic) NSRange standAtEdge;
@property (nonatomic) NSRange standAtEdgeLeft;

@property (nonatomic) NSRange standOnSingleTile;
@property (nonatomic) NSRange standOnSingleTileLeft;

@property (nonatomic) NSRange turnLeft;
@property (nonatomic) NSRange turnRight;

@property (nonatomic) NSRange prone;
@property (nonatomic) NSRange proneLeft;

@property (nonatomic) NSRange crawl;
@property (nonatomic) NSRange crawlLeft;

@property (nonatomic) NSRange jumpHorizontalPreApex;
@property (nonatomic) NSRange jumpHorizontalPostApex;
@property (nonatomic) NSRange jumpHorizontalPreApexLeft;
@property (nonatomic) NSRange jumpHorizontalPostApexLeft;

@property (nonatomic) NSRange jumpVerticalPreApex;
@property (nonatomic) NSRange jumpVerticalPostApex;
@property (nonatomic) NSRange jumpVerticalPreApexLeft;
@property (nonatomic) NSRange jumpVerticalPostApexLeft;

@property (nonatomic) NSRange landOnLedge;
@property (nonatomic) NSRange landOnLedgeLeft;

@property (nonatomic) NSRange hangOnLedge;
@property (nonatomic) NSRange hangOnLedgeLeft;

@property (nonatomic) NSRange climbToCrawl;
@property (nonatomic) NSRange climbToCrawlLeft;

@property (nonatomic) NSRange climbToStand;
@property (nonatomic) NSRange climbToStandLeft;
//////////////




@property (nonatomic) NSRange previousFrameRange;
@property (nonatomic) NSRange currentFrameRange;






- (id) initAnimationDictionary;

- (void) addAnimationWithImage:(NSString*)imageName forSpriteSize:(CGSize)spriteSize;

-(void) animateFor:(SKSpriteNode*)sprite withSpriteSheet:(NSString*)sheetName;

- (void)chooseAppropriateAnimationFor:(SKSpriteNode*)sprite asPhysicsObject:(PhysicsComponent*)physicsObject;


@end
