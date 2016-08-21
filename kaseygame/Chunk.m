//
//  Chunk.m
//  TileMapADTtest
//
//  Created by John Feldcamp on 6/21/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "Chunk.h"


@implementation Chunk

// initialize size here based on user's device screen size
-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    _deviceDependentChunkSize = [aDecoder decodeCGSizeForKey:@"deviceDependentChunkSize"];
    _idealBounds = [aDecoder decodeCGRectForKey:@"idealBounds"];
    _hasBottomEdge = [aDecoder decodeBoolForKey:@"hasBottomEdge"];
    _hasTopEdge = [aDecoder decodeBoolForKey:@"hasTopEdge"];
    _hasLeftEdge = [aDecoder decodeBoolForKey:@"hasLeftEdge"];
    _hasRightEdge = [aDecoder decodeBoolForKey:@"hasRightEdge"];

    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeCGSize:_deviceDependentChunkSize forKey:@"deviceDependentChunkSize"];
    [aCoder encodeCGRect:_idealBounds forKey:@"idealBounds"];
    [aCoder encodeBool:_hasBottomEdge forKey:@"hasBottomEdge"];
    [aCoder encodeBool:_hasTopEdge forKey:@"hasTopEdge"];
    [aCoder encodeBool:_hasLeftEdge forKey:@"hasLeftEdge"];
    [aCoder encodeBool:_hasRightEdge forKey:@"hasRightEdge"];
    //...
}

+(void)setChunkSize {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    DEVICE_DEPENDENT_CHUNK_SIZE = screenSize;
}

+(CGSize)getChunkSize {
    return DEVICE_DEPENDENT_CHUNK_SIZE;
}



@end
