//
//  Tileset.m
//  kaseygame
//
//  Created by John Feldcamp on 8/19/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "Tileset.h"

@implementation Tileset

-(instancetype) initTileset {
    _name = [NSString string];
    _tiles = [NSMutableArray array];
    
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    _name = [aDecoder decodeObjectForKey:@"name"];
    _tiles = [aDecoder decodeObjectForKey:@"tiles"];
    _gidRange = [[aDecoder decodeObjectForKey:@"gidRange"] rangeValue];
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_tiles forKey:@"tiles"];
    [aCoder encodeObject:[NSValue valueWithRange:_gidRange] forKey:@"range"];
    
}


-(NSMutableArray*)unpackTiles:(UIImage*)tileSet startingWithGid:(NSInteger)gid {
    NSMutableArray *tileArray = [NSMutableArray array];
    
    float xPos = 0;
    float yPos = tileSet.size.height - 30;
        
    while (yPos >= 0) {
        
        if (xPos == tileSet.size.width)
        {
            xPos = 0;
            yPos -= 30;
            
            continue;
        }
        
        //NSLog(@"sx: %f, sy: %f", sx, sy);
        
        
        CGRect cutter = CGRectMake (xPos, yPos , 30 , 30 );
        
        
        CGImageRef imageRef = CGImageCreateWithImageInRect([tileSet CGImage], cutter);
        
        Tile *currentTile = [[Tile alloc] init];
        currentTile.image = [UIImage imageWithCGImage:imageRef];
        currentTile.gid = gid;
        [tileArray addObject:currentTile];
        
        
        xPos += 30;
        gid ++;
        
    }
    
    self.gidRange = NSMakeRange(gid, [tileArray indexOfObject:[tileArray lastObject]]);
    return tileArray;
}


@end
