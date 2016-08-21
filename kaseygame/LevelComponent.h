//
//  LevelComponent.h
//  ChunkADT
//
//  Created by John Feldcamp on 7/6/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "Tile.h"
#import "Chunk.h"

float RoundDownTo(float number, float to);

@interface LevelComponent : SKNode 

/// chunk grid
@property (nonatomic) Chunk* chunkA;
@property (nonatomic) Chunk* chunkB;
@property (nonatomic) Chunk* chunkC;
@property (nonatomic) Chunk* chunkD;
@property (nonatomic) Chunk* chunkE;
@property (nonatomic) Chunk* chunkF;
@property (nonatomic) Chunk* chunkG;
@property (nonatomic) Chunk* chunkH;
@property (nonatomic) Chunk* chunkI;


///

@property (nonatomic) NSMutableDictionary* tilesets;
//@property (nonatomic) NSMutableDictionary* chunks;

-(id)initLevelFromScratch;
-(id)initLevelWithChunks: (NSMutableDictionary*)chunksDictionary andTilesets: (NSMutableDictionary*)tilesetsDictionary;
- (void) centerChunkGridOnChunk:(Chunk*)chunk;
- (void) updateChunkGrid;
-(Chunk*)getAppropriateChunkForNewTileOrMakeOneUp:(Tile*)theTile;



@end
