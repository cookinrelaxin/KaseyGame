//
//  Tileset.h
//  kaseygame
//
//  Created by John Feldcamp on 8/19/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tile.h"

@interface Tileset : NSObject
@property (nonatomic) NSString* name;
@property (nonatomic) NSMutableArray* tiles;
@property (nonatomic) NSRange gidRange;

-(instancetype)initTileset;
-(NSMutableArray*)unpackTiles:(UIImage*)tileset startingWithGid:(NSInteger)gid;

@end
