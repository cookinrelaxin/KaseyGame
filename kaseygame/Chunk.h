//
//  Chunk.h
//  TileMapADTtest
//
//  Created by John Feldcamp on 6/21/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
static CGSize DEVICE_DEPENDENT_CHUNK_SIZE;

@interface Chunk : SKNode


@property (nonatomic) CGSize deviceDependentChunkSize;
@property (nonatomic) BOOL valid;
@property (nonatomic) BOOL readyToLoad;
@property (nonatomic) BOOL readyToDeload;
//@property (nonatomic) NSString* name;
//@property (nonatomic) CGPoint positionInLevel;

// that is, the bounds specified by DEVICE_DEPENDENT_CHUNK_SIZE, not by its contents
@property (nonatomic) CGRect idealBounds;
//@property (nonatomic) CGPoint lowerLeftCorner;
//@property (nonatomic) NSInteger xInLevel;
//@property (nonatomic) NSInteger yInLevel;
//@property (nonatomic) NSInteger tileXModifier;
//@property (nonatomic) NSInteger tileYModifier;
//@property (nonatomic) NSMutableArray* tiles; // of type Tile
//@property (nonatomic) SKNode* layers;
//@property (nonatomic) SKNode* objects;
///

/// relevant data for camera and object bounds control
@property (nonatomic) BOOL hasLeftEdge;
@property (nonatomic) BOOL hasRightEdge;
@property (nonatomic) BOOL hasTopEdge;
@property (nonatomic) BOOL hasBottomEdge;
///


+(CGSize)getChunkSize;
@end
