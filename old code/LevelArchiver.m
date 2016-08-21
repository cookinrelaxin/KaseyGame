//
//  LevelArchiver.m
//  kaseygame
//
//  Created by John Feldcamp on 8/22/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "LevelArchiver.h"

@implementation LevelArchiver

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    _levelName = globalLevelName;
    
    _paletteObject = [aDecoder decodeObjectForKey:[NSString stringWithFormat:@"%@ palette", _levelName]];
    _worldObject = [aDecoder decodeObjectForKey:[NSString stringWithFormat:@"%@ world", _levelName]];
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_paletteObject forKey:[NSString stringWithFormat:@"%@ palette", _levelName]];
    [aCoder encodeObject:_worldObject forKey:[NSString stringWithFormat:@"%@ world", _levelName]];
    
}

-(NSString*)getFilepath:(NSString*)currentLevelName
{
    static NSString* filePath = nil;
    if (!filePath) {
        filePath =
        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
         stringByAppendingPathComponent:[NSString stringWithFormat:@"%@", currentLevelName]];
    }
    return filePath;
}

-(void)saveLevel:(NSString*)currentLevelName
{
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[self getFilepath:currentLevelName] atomically:YES];
}

-(void)loadLevel:(NSString*)currentLevelName
{
    NSData* decodedData = [NSData dataWithContentsOfFile: [self getFilepath:currentLevelName]];
    LevelArchiver* gameData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
    return gameData;
}



@end
