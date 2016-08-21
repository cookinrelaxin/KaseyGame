//
//  Tile.h
//  kaseygame
//
//  Created by John Feldcamp on 8/19/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
extern const int TILE_SIZE;


typedef NS_ENUM(NSInteger, TileSpecies) {
    nonObject,
    object
};

@interface Tile : SKSpriteNode

@property (nonatomic) UIImage* image;
@property (nonatomic) NSInteger gid;
//@property (nonatomic) CGPoint positionInChunk;
@property (nonatomic) TileSpecies species;
//@property (nonatomic) SKSpriteNode* spriteNode;

@end
