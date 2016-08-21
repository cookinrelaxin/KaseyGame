//
//  LevelArchiver.h
//  kaseygame
//
//  Created by John Feldcamp on 8/22/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Palette.h"
#import "LevelEditorScene.h"
#import <SpriteKit/SpriteKit.h>

@interface LevelArchiver : NSObject <NSCoding>

@property (nonatomic) NSString *levelName;

@property (strong,nonatomic) Palette *paletteObject;
@property (nonatomic) SKNode* worldObject;

-(void)saveLevel;

@end
