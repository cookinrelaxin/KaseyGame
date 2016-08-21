//
//  LevelComponent.m
//  ChunkADT
//
//  Created by John Feldcamp on 7/6/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "LevelComponent.h"

float RoundDownTo(float number, float to)
{
    return to * floorf(number / to);
    
}

@implementation LevelComponent {
    
    
    /// current level
   // NSString* levelNumber;
    ///
    
    
}

-(id)initLevelWithChunks: (NSMutableDictionary*)chunksDictionary andTilesets: (NSMutableDictionary*)tilesetsDictionary {
   // levelNumber = @"0";
    //TMXParseOperation *parseFirstChunkInLevel = [[TMXParseOperation alloc] init];
    //NSURL *initialChunk = [[NSBundle mainBundle]
    //                         URLForResource:[NSString stringWithFormat:@"level%@00", levelNumber]
    //                         withExtension:@"tmx"];
    //[parseFirstChunkInLevel parseDocumentWithURL:initialChunk];
    //_chunkE = parseFirstChunkInLevel.currentChunk;
    //_chunkE.name = [NSString stringWithFormat:@"level%@00", levelNumber];
    //_chunkE.tileXModifier = 0;
    //_chunkE.tileYModifier = 0;
    
    //_chunks = chunksDictionary;
    _tilesets = tilesetsDictionary;
    
  //  _chunkE = [chunksDictionary objectForKey:@"x0y0"];
    
    //TODO: write code to convert that key into a CGPoint, then set _chunkE.positionInLevel to that
//
//    char chunkEXChar = [_chunkE.name characterAtIndex:6];
//    _chunkE.xInLevel = [[NSString stringWithFormat:@"%c", chunkEXChar] intValue];
//    char chunkEYChar = [_chunkE.name characterAtIndex:7];
//    _chunkE.yInLevel = [[NSString stringWithFormat:@"%c", chunkEYChar] intValue];
//    
    
   // _chunkE.tileXModifier = 0;
    //_chunkE.tileYModifier = 0;
    
    
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _tilesets = [aDecoder decodeObjectForKey:@"tilesets"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_tilesets forKey:@"tilesets"];
}

-(id)initLevelFromScratch {
   // _chunks = [NSMutableDictionary dictionary];
    _tilesets = [NSMutableDictionary dictionary];
    //[_chunks setObject:[[Chunk alloc] init] forKey:@"x0y0"];

    //_chunkE.tileXModifier = 0;
   // _chunkE.tileYModifier = 0;
    
    
    
    return self;
}

-(Chunk*)getAppropriateChunkForNewTileOrMakeOneUp:(Tile *)theTile{
    
    CGPoint tilePositionRoundedToChunkSize = CGPointMake(RoundDownTo(theTile.position.x, [Chunk getChunkSize].width), RoundDownTo(theTile.position.y, [Chunk getChunkSize].height));
    NSString* xPos = [NSString stringWithFormat:@"%d",(int)tilePositionRoundedToChunkSize.x];
    NSString* yPos = [NSString stringWithFormat:@"%d",(int)tilePositionRoundedToChunkSize.y];
    NSString* potentialChunkName = [NSString stringWithFormat:@"x%@y%@", xPos, yPos];
    SKNode* potentialChunk = [self childNodeWithName:potentialChunkName];
    if (potentialChunk) {
        return (Chunk*) potentialChunk;
    }
    
    Chunk* newChunk = [[Chunk alloc] init];
    newChunk.name = potentialChunkName;
    [self addChild:newChunk];
    return newChunk;

}

- (void)centerChunkGridOnChunk:(Chunk *)chunk {
    
    
    if (chunk == _chunkA) {
        
        _chunkI = _chunkE;
        
        _chunkE = _chunkA;
        _chunkF = _chunkB;
        _chunkH = _chunkD;
        
        _chunkA = nil;
        _chunkB = nil;
        _chunkC = nil;
        _chunkD = nil;
        _chunkG = nil;
        
        [self updateChunkGrid];
    }
    
    else if (chunk == _chunkB) {
        
        _chunkG = _chunkD;
        _chunkH = _chunkE;
        _chunkI = _chunkF;
        
        _chunkD = _chunkA;
        _chunkE = _chunkB;
        _chunkF = _chunkC;
        
        _chunkA = nil;
        _chunkB = nil;
        _chunkC = nil;
        
        [self updateChunkGrid];
        return;
    }
    
    else if (chunk == _chunkC) {
        
        _chunkG = _chunkE;
        
        _chunkD = _chunkB;
        _chunkE = _chunkC;
        _chunkH = _chunkF;
        
        _chunkA = nil;
        _chunkB = nil;
        _chunkC = nil;
        _chunkF = nil;
        _chunkI = nil;
        
        [self updateChunkGrid];
        return;
    }
    
    else if (chunk == _chunkD) {
        
        _chunkC = _chunkB;
        _chunkF = _chunkE;
        _chunkI = _chunkH;
        
        _chunkB = _chunkA;
        _chunkE = _chunkD;
        _chunkH = _chunkG;
        
        _chunkA = nil;
        _chunkD = nil;
        _chunkG = nil;
        
        [self updateChunkGrid];
        return;
    }
    
    else if (chunk == _chunkF) {
        
        _chunkA = _chunkB;
        _chunkB = _chunkC;
        _chunkD = _chunkE;
        _chunkE = _chunkF;
        _chunkG = _chunkH;
        _chunkH = _chunkI;
        
        _chunkC = nil;
        _chunkF = nil;
        _chunkI = nil;
        
        [self updateChunkGrid];
        return;
    }
    
    else if (chunk == _chunkG) {
        
        _chunkB = _chunkD;
        _chunkC = _chunkE;
        _chunkE = _chunkG;
        _chunkF = _chunkH;
        
        _chunkA = nil;
        _chunkD = nil;
        _chunkG = nil;
        _chunkH = nil;
        _chunkI = nil;
        
        [self updateChunkGrid];
        return;
    }
    
    else if (chunk == _chunkH) {
        
        _chunkA = _chunkD;
        _chunkB = _chunkE;
        _chunkC = _chunkF;
        _chunkD = _chunkG;
        _chunkE = _chunkH;
        _chunkF = _chunkI;
        
        _chunkG = nil;
        _chunkH = nil;
        _chunkI = nil;
        
        [self updateChunkGrid];
        return;
    }
    
    else if (chunk == _chunkI) {
        
        _chunkA = _chunkE;
        _chunkB = _chunkF;
        _chunkD = _chunkH;
        _chunkE = _chunkI;
        
        
        _chunkC = nil;
        _chunkF = nil;
        _chunkI = nil;
        _chunkH = nil;
        _chunkG = nil;
        
        [self updateChunkGrid];
        return;
    }

}


- (void) updateChunkGrid {
    
    
    /* the general format for each of these should be
     
     _chunkA = [_chunks objectForKey:@"APPROPRIATECOORDINATESTRING";
     etc...
     
     
     */
    
    /*
    //////
    if (!_chunkA) {
        TMXParseOperation *parseChunkA = [[TMXParseOperation alloc] init];
        _chunkA = parseChunkA.currentChunk;
       _chunkA.name = [NSString stringWithFormat:@"level%@%d%d" ,levelNumber, _chunkE.xInLevel - 1, _chunkE.yInLevel + 1];
        //NSLog(@"chunkA.name:%@", _chunkA.name);
        NSURL *ChunkAURL = [[NSBundle mainBundle]
                              URLForResource:_chunkA.name
                              withExtension:@"tmx"];
        [parseChunkA parseDocumentWithURL:ChunkAURL];
        if (parseChunkA.currentChunk.validChunk) {
            //NSLog(@"chunkA valid");
            _chunkA = parseChunkA.currentChunk;
            _chunkA.tileXModifier = -(_chunkA.mapwidth * _chunkA.tilewidth);
            _chunkA.tileYModifier = (_chunkA.mapheight * _chunkA.tileheight);
            _chunkA.frame = CGRectMake(_chunkE.frame.origin.x + _chunkA.tileXModifier, _chunkE.frame.origin.y + _chunkA.tileYModifier, _chunkE.frame
                                        .size.width, _chunkE.frame.size.height);
            _chunkA.readyToLoad = true;
        }
        else {
            _chunkA = nil;
        }
    }
    //////
    
    
    //////
    if (!_chunkB) {
        TMXParseOperation *parseChunkB = [[TMXParseOperation alloc] init];
        _chunkB = parseChunkB.currentChunk;
        _chunkB.name = [NSString stringWithFormat:@"level%@%d%d" ,levelNumber, _chunkE.xInLevel, _chunkE.yInLevel + 1];
        //NSLog(@"chunkB.name:%@", _chunkB.name);
        NSURL *ChunkBURL = [[NSBundle mainBundle]
                              URLForResource:_chunkB.name
                              withExtension:@"tmx"];
        [parseChunkB parseDocumentWithURL:ChunkBURL];
        if (parseChunkB.currentChunk.validChunk) {
            //NSLog(@"chunkB valid");
            _chunkB = parseChunkB.currentChunk;
            _chunkB.tileXModifier = 0;
            _chunkB.tileYModifier = (_chunkB.mapheight * _chunkB.tileheight);
            _chunkB.frame = CGRectMake(_chunkE.frame.origin.x + _chunkB.tileXModifier, _chunkE.frame.origin.y + _chunkB.tileYModifier, _chunkE.frame
                                        .size.width, _chunkE.frame.size.height);
            _chunkB.readyToLoad = true;
            _chunkE.hasTopEdge = false;
        }
        else {
            _chunkB = nil;
            _chunkE.hasTopEdge = true;
        }
    }
    //////
    
    //////
    if (!_chunkC) {
        TMXParseOperation *parseChunkC = [[TMXParseOperation alloc] init];
        _chunkC = parseChunkC.currentChunk;
        _chunkC.name = [NSString stringWithFormat:@"level%@%d%d" ,levelNumber, _chunkE.xInLevel + 1, _chunkE.yInLevel + 1];
        //NSLog(@"chunkC.name:%@", _chunkC.name);
        NSURL *ChunkCURL = [[NSBundle mainBundle]
                              URLForResource:_chunkC.name
                              withExtension:@"tmx"];
        [parseChunkC parseDocumentWithURL:ChunkCURL];
        if (parseChunkC.currentChunk.validChunk) {
            //NSLog(@"chunkC valid");
            _chunkC = parseChunkC.currentChunk;
            _chunkC.tileXModifier = (_chunkC.mapwidth * _chunkC.tilewidth);
            _chunkC.tileYModifier = (_chunkC.mapheight * _chunkC.tileheight);
            _chunkC.frame = CGRectMake(_chunkE.frame.origin.x + _chunkC.tileXModifier, _chunkE.frame.origin.y + _chunkC.tileYModifier, _chunkE.frame
                                        .size.width, _chunkE.frame.size.height);
            _chunkC.readyToLoad = true;
        }
        else {
            _chunkC = nil;
        }
    }
    //////
    
    //////
    if (!_chunkD) {
        TMXParseOperation *parseChunkD = [[TMXParseOperation alloc] init];
        _chunkD = parseChunkD.currentChunk;
        _chunkD.name = [NSString stringWithFormat:@"level%@%d%d" ,levelNumber, _chunkE.xInLevel - 1, _chunkE.yInLevel];
        //NSLog(@"chunkD.name:%@", _chunkD.name);
        NSURL *ChunkDURL = [[NSBundle mainBundle]
                              URLForResource:_chunkD.name
                              withExtension:@"tmx"];
        [parseChunkD parseDocumentWithURL:ChunkDURL];
        if (parseChunkD.currentChunk.validChunk) {
            //NSLog(@"chunkD valid");
            _chunkD = parseChunkD.currentChunk;
            _chunkD.tileXModifier = -(_chunkD.mapwidth * _chunkD.tilewidth);
            _chunkD.tileYModifier = 0;
            _chunkD.frame = CGRectMake(_chunkE.frame.origin.x + _chunkD.tileXModifier, _chunkE.frame.origin.y + _chunkD.tileYModifier, _chunkE.frame
                                        .size.width, _chunkE.frame.size.height);
            _chunkD.readyToLoad = true;
            _chunkE.hasLeftEdge = false;
        }
        else {
            _chunkD = nil;
            _chunkE.hasLeftEdge = true;
        }
    }
    //////
    
    //////
    if (!_chunkF) {
        TMXParseOperation *parseChunkF = [[TMXParseOperation alloc] init];
        _chunkF = parseChunkF.currentChunk;
        _chunkF.name = [NSString stringWithFormat:@"level%@%d%d" ,levelNumber, _chunkE.xInLevel + 1, _chunkE.yInLevel];
        //NSLog(@"chunkF.name:%@", _chunkF.name);
        NSURL *ChunkFURL = [[NSBundle mainBundle]
                              URLForResource:_chunkF.name
                              withExtension:@"tmx"];
        [parseChunkF parseDocumentWithURL:ChunkFURL];
        if (parseChunkF.currentChunk.validChunk) {
            //NSLog(@"chunkF valid");
            _chunkF = parseChunkF.currentChunk;
            _chunkF.tileXModifier = (_chunkF.mapwidth * _chunkF.tilewidth);
            _chunkF.tileYModifier = 0;
            _chunkF.frame = CGRectMake(_chunkE.frame.origin.x + _chunkF.tileXModifier, _chunkE.frame.origin.y, _chunkE.frame
                                        .size.width, _chunkE.frame.size.height);
            _chunkF.readyToLoad = true;
            _chunkE.hasRightEdge = false;
        }
        else {
            _chunkF = nil;
            _chunkE.hasRightEdge = true;
        }
    }
    //////
    
    //////
    if (!_chunkG) {
        TMXParseOperation *parseChunkG = [[TMXParseOperation alloc] init];
        _chunkG = parseChunkG.currentChunk;
        _chunkG.name = [NSString stringWithFormat:@"level%@%d%d" ,levelNumber, _chunkE.xInLevel - 1, _chunkE.yInLevel - 1];
        //NSLog(@"chunkG.name:%@", _chunkG.name);
        NSURL *ChunkGURL = [[NSBundle mainBundle]
                              URLForResource:_chunkG.name
                              withExtension:@"tmx"];
        [parseChunkG parseDocumentWithURL:ChunkGURL];
        if (parseChunkG.currentChunk.validChunk) {
            //NSLog(@"chunkG valid");
            _chunkG = parseChunkG.currentChunk;
            _chunkG.tileXModifier = -(_chunkG.mapwidth * _chunkG.tilewidth);
            _chunkG.tileYModifier = -(_chunkG.mapheight * _chunkG.tileheight);
            _chunkG.frame = CGRectMake(_chunkE.frame.origin.x + _chunkG.tileXModifier, _chunkE.frame.origin.y + _chunkG.tileYModifier, _chunkE.frame
                                        .size.width, _chunkE.frame.size.height);
            _chunkG.readyToLoad = true;
        }
        else {
            _chunkG = nil;
        }
    }
    //////
    
    //////
    if (!_chunkH) {
        TMXParseOperation *parseChunkH = [[TMXParseOperation alloc] init];
        _chunkH = parseChunkH.currentChunk;
        _chunkH.name = [NSString stringWithFormat:@"level%@%d%d" ,levelNumber, _chunkE.xInLevel, _chunkE.yInLevel - 1];
        //NSLog(@"chunkH.name:%@", _chunkH.name);
        NSURL *ChunkHURL = [[NSBundle mainBundle]
                              URLForResource:_chunkH.name
                              withExtension:@"tmx"];
        [parseChunkH parseDocumentWithURL:ChunkHURL];
        if (parseChunkH.currentChunk.validChunk) {
            //NSLog(@"chunkH valid");
            _chunkG = parseChunkH.currentChunk;
            _chunkH.tileXModifier = 0;
            _chunkH.tileYModifier = -(_chunkH.mapheight * _chunkH.tileheight);
            _chunkH.frame = CGRectMake(_chunkE.frame.origin.x + _chunkH.tileXModifier, _chunkE.frame.origin.y + _chunkH.tileYModifier, _chunkE.frame
                                        .size.width, _chunkE.frame.size.height);
            _chunkH.readyToLoad = true;
            _chunkE.hasBottomEdge = false;
        }
        else {
            _chunkH = nil;
            _chunkE.hasBottomEdge = true;
        }
    }
    //////
    
    //////
    if (!_chunkI) {
        TMXParseOperation *parseChunkI = [[TMXParseOperation alloc] init];
        _chunkI = parseChunkI.currentChunk;
        _chunkI.name = [NSString stringWithFormat:@"level%@%d%d" ,levelNumber, _chunkE.xInLevel + 1, _chunkE.yInLevel - 1];
        //NSLog(@"chunkI.name:%@", _chunkI.name);
        NSURL *ChunkIURL = [[NSBundle mainBundle]
                              URLForResource:_chunkI.name
                              withExtension:@"tmx"];
        [parseChunkI parseDocumentWithURL:ChunkIURL];
        if (parseChunkI.currentChunk.validChunk) {
            //NSLog(@"chunkI valid");
            _chunkI = parseChunkI.currentChunk;
            _chunkI.tileXModifier = (_chunkI.mapwidth * _chunkI.tilewidth);
            _chunkI.tileYModifier = -(_chunkI.mapheight * _chunkI.tileheight);
            _chunkI.frame = CGRectMake(_chunkE.frame.origin.x + _chunkI.tileXModifier, _chunkE.frame.origin.y + _chunkI.tileYModifier, _chunkE.frame
                                        .size.width, _chunkE.frame.size.height);
            _chunkI.readyToLoad = true;
        }
        else {
            _chunkI = nil;
        }
    }
    //////
     
     */
    
    
}


@end
