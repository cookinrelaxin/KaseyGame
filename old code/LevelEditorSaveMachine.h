//
//  LevelEditorSaveLevel.h
//  kaseygame
//
//  Created by John Feldcamp on 8/21/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Tree.h"
#import "LevelEditorScene.h"
#import "Tileset.h"

@interface LevelEditorSaveMachine : NSObject

@property (nonatomic) Tree* model;

-(void)saveLevel:(LevelEditorScene *)level;
@end
