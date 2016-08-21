//
//  HudComponent.m
//  ChunkADT
//
//  Created by John Feldcamp on 7/4/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "HudComponent.h"

@implementation HudComponent

- (id) initInGameMenu {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        _inGameMenu = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.30 green:.15 blue:0 alpha:1] size:CGSizeMake(300, 400)];
        _restartCurrentLevel = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.15 green:.15 blue:.5 alpha:1] size:CGSizeMake(75, 200)];
        _returnToMainMenu = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.15 green:.15 blue:.5 alpha:1] size:CGSizeMake(75, 200)];
        
        
        [_inGameMenu addChild:_restartCurrentLevel];
        [_inGameMenu addChild:_returnToMainMenu];
        
        _restartCurrentLevel.position = CGPointMake(80, 0);
        _returnToMainMenu.position = CGPointMake(-80, 0);
    }
    
    return self;
}

- (void) unpackMenuButtons: (NSString*)imageName forButtonSize:(CGSize)buttonSize {
    
    NSMutableArray *spriteArray = [[NSMutableArray alloc] init];
    
    SKTexture *spriteSheet = [SKTexture textureWithImageNamed:imageName];
    spriteSheet.filteringMode = SKTextureFilteringNearest;
    
    int sx = 0;
    int sy = (spriteSheet.size.height - buttonSize.height);
    
    while (sy >= 0) {
        //NSLog(@"sx = %d", sx);
        //NSLog(@"sy = %d", sy);
        
        if (sx == spriteSheet.size.width)
        {
            sx = 0;
            sy -= buttonSize.height;
            if (sy < 0) {
                //NSLog(@"sy is negative");
                break;
            }
            continue;
        }
        
        CGRect cutter = CGRectMake ((sx / spriteSheet.size.width), (sy / spriteSheet.size.height), (buttonSize.width / spriteSheet.size.width), (buttonSize.height / spriteSheet.size.height));
        SKTexture *temp = [SKTexture textureWithRect:cutter inTexture:spriteSheet];
        
        [spriteArray addObject:temp];
        
        sx += buttonSize.width;
        
    }
    
    [_buttonDictionary setObject:spriteArray forKey:imageName];
    
}



@end
