//
//  Tile.m
//  kaseygame
//
//  Created by John Feldcamp on 8/19/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "Tile.h"

const int TILE_SIZE = 30;

@implementation Tile

-(instancetype)init {
    _image = [[UIImage alloc] init];
    
    return  self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    _image = [aDecoder decodeObjectForKey:@"image"];
    _gid = [aDecoder decodeIntegerForKey:@"gid"];
    _species = [aDecoder decodeIntegerForKey:@"species"];
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_image forKey:@"image"];
    [aCoder encodeInteger:_gid forKey:@"gid"];
    [aCoder encodeInteger:_species forKey:@"species"];
}
@end
