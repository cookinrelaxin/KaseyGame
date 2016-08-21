//
//  HudComponent.h
//  ChunkADT
//
//  Created by John Feldcamp on 7/4/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>


@interface HudComponent : NSObject


//
@property (nonatomic) NSMutableDictionary* buttonDictionary;

@property (nonatomic) SKNode* inGameMenu;
@property (nonatomic) SKNode* returnToMainMenu;
@property (nonatomic) SKNode* restartCurrentLevel;
//

-(id)initInGameMenu;



@end
