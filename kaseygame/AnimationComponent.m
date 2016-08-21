//
//  AnimationComponent.m
//  ChunkADT
//
//  Created by John Feldcamp on 7/11/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "AnimationComponent.h"

@implementation AnimationComponent {
    
}

- (id)initAnimationDictionary {
    
    _animationDictionary = [[NSMutableDictionary alloc] init];
    _currentIndexInAnimationArray = 0;
//    _animationFrameRateDefault = .085;
//    _climbingFrameRate = .07;
//    _animationFrameRate = _animationFrameRateDefault;
    _frameCounter = 0;
    _desiredCountToPresentNextSprite = 0;
    
    return self;
}

- (void) addAnimationWithImage: (NSString*)imageName forSpriteSize:(CGSize)spriteSize {
        
    NSMutableArray *spriteArray = [[NSMutableArray alloc] init];
        
    SKTexture *spriteSheet = [SKTexture textureWithImageNamed:imageName];
    spriteSheet.filteringMode = SKTextureFilteringNearest;
   
    int sx = 0;
    int sy = (spriteSheet.size.height - spriteSize.height);
            
    while (sy >= 0) {
        //NSLog(@"sx = %d", sx);
        //NSLog(@"sy = %d", sy);
                
        if (sx == spriteSheet.size.width)
            {
                sx = 0;
                sy -= spriteSize.height;
                if (sy < 0) {
                    //NSLog(@"sy is negative");
                    break;
                }
                continue;
            }
        
        CGRect cutter = CGRectMake ((sx / spriteSheet.size.width), (sy / spriteSheet.size.height), (spriteSize.width / spriteSheet.size.width), (spriteSize.height / spriteSheet.size.height));
        SKTexture *temp = [SKTexture textureWithRect:cutter inTexture:spriteSheet];
        
        [spriteArray addObject:temp];
        
        sx += spriteSize.width;
        
    }
    
    [_animationDictionary setObject:spriteArray forKey:imageName];
    
}





- (void) animateFor:(SKSpriteNode*)sprite withSpriteSheet:(NSString *)sheetName {
    
    
    if ((_currentIndexInAnimationArray >= (_currentFrameRange.location + _currentFrameRange.length)) || (_currentIndexInAnimationArray < _currentFrameRange.location)) {
        _currentIndexInAnimationArray = _currentFrameRange.location;
        }
    
    else {
        _currentIndexInAnimationArray ++;
    }

    sprite.texture = [[_animationDictionary objectForKey: sheetName] objectAtIndex:_currentIndexInAnimationArray];
    _frameCounter = 0;
    _desiredCountToPresentNextSprite = 7;
            
        
        


    
    
    

}




- (void)chooseAppropriateAnimationFor:(SKSpriteNode*)sprite asPhysicsObject:(PhysicsComponent*)physicsObject {
//dynamically construct the range of frames for a sprite's continuous animation (it doesnt stop)
    
    _frameCounter ++;

    if ((_frameCounter >= _desiredCountToPresentNextSprite) || physicsObject.forceAnimation) {
        physicsObject.forceAnimation = false;
        
        //NSLog(@"animation.framerate: %f", _animationFrameRate);
        
        if (physicsObject.hangingRight) {
            _currentFrameRange = _hangOnLedge;
            physicsObject.facingLeft = false;
        }
        
        else if (physicsObject.hangingLeft) {
            _currentFrameRange = _hangOnLedgeLeft;
            physicsObject.facingLeft = true;
        }
        
       else if (physicsObject.climbingRight & (_currentIndexInAnimationArray != (_climbToStand.location + _climbToStand.length)) & (_currentIndexInAnimationArray != (_climbToCrawl.location + _climbToCrawl.length))) {
           if (physicsObject.climbIntoCrawl) {
               _currentFrameRange = _climbToCrawl;
               physicsObject.proneInAction = true;
           }
           
           else {
               _currentFrameRange = _climbToStand;
           }
           physicsObject.facingLeft = false;
       }
        
       else if (physicsObject.climbingLeft & (_currentIndexInAnimationArray != (_climbToStandLeft.location + _climbToStandLeft.length)) & (_currentIndexInAnimationArray != (_climbToCrawlLeft.location + _climbToCrawlLeft.length))) {
           if (physicsObject.climbIntoCrawl) {
               _currentFrameRange = _climbToCrawlLeft;
               physicsObject.proneInAction = true;
           }
           
           else {
               _currentFrameRange = _climbToStandLeft;
           }
           physicsObject.facingLeft = true;
       }

        

        
        
       else if ((physicsObject.velocity.x == 0) & (physicsObject.velocity.y == 0) & physicsObject.proneInAction
            & ((_previousFrameRange.location == _run.location) || (_previousFrameRange.location == _jumpHorizontalPostApex.location) || (_previousFrameRange.location == _crawl.location) || (_previousFrameRange.location == _stand.location) || (_previousFrameRange.location == _prone.location) || (_previousFrameRange.location == _climbToCrawl.location)))
        {
            
            if ((_previousFrameRange.location == _climbToCrawl.location) & physicsObject.climbingRight) {
                physicsObject.climbingRight = false;
                physicsObject.climbComplete = true;
                return;
                
            }
            _currentFrameRange = _prone;
            physicsObject.facingLeft= false;
        }
        
        
        else if ((physicsObject.velocity.x == 0) & (physicsObject.velocity.y == 0) & physicsObject.proneInAction
                 & ((_previousFrameRange.location == _runLeft.location) || (_previousFrameRange.location == _jumpHorizontalPostApexLeft.location) || (_previousFrameRange.location == _crawlLeft.location) || (_previousFrameRange.location == _standLeft.location) || (_previousFrameRange.location == _proneLeft.location) || (_previousFrameRange.location == _climbToCrawlLeft.location)))
        {
            
            if ((_previousFrameRange.location == _climbToCrawlLeft.location) & physicsObject.climbingLeft) {
                physicsObject.climbingLeft = false;
                physicsObject.climbComplete = true;
                return;
                
            }
            _currentFrameRange = _proneLeft;
            physicsObject.facingLeft = true;
        }
        
        else if (((physicsObject.velocity.x < 0) & (physicsObject.velocity.y == 0) || (_previousFrameRange.location == _turnLeft.location))
                 & ((_previousFrameRange.location == _run.location) || (_previousFrameRange.location == _stand.location) || (_previousFrameRange.location == _turnLeft.location))  &(_currentIndexInAnimationArray != (_turnLeft.location + _turnLeft.length)))
        {
            _currentFrameRange = _turnLeft;
            physicsObject.facingLeft = true;
        }
        
        
        else if (((physicsObject.velocity.x > 0) & (physicsObject.velocity.y == 0) || (_previousFrameRange.location == _turnRight.location))
                 & ((_previousFrameRange.location == _runLeft.location) || (_previousFrameRange.location == _standLeft.location) || (_previousFrameRange.location == _turnRight.location))  &(_currentIndexInAnimationArray != (_turnRight.location + _turnRight.length)))
        {
            _currentFrameRange = _turnRight;
            physicsObject.facingLeft = false;
        }
        
        
       else if ((physicsObject.velocity.x == 0) & (physicsObject.velocity.y == 0)
            & ((_previousFrameRange.location == _run.location) || (_previousFrameRange.location == _jumpHorizontalPreApex.location) || (_previousFrameRange.location == _jumpHorizontalPostApex.location) || (_previousFrameRange.location == _jumpVerticalPostApex.location) || (_previousFrameRange.location == _crawl.location) || (_previousFrameRange.location == _turnRight.location) || (_previousFrameRange.location == _stand.location) || (_previousFrameRange.location == _standOnSingleTile.location) || (_previousFrameRange.location == _standAtEdge.location) || (_previousFrameRange.location == _prone.location))
                || (_previousFrameRange.location == _climbToStand.location))
        {
            if ((_previousFrameRange.location == _climbToStand.location) & physicsObject.climbingRight) {
                physicsObject.climbingRight = false;
                physicsObject.climbComplete = true;
                physicsObject.facingLeft = false;
                return;
                
            }
            
            if (physicsObject.onSingleTile) {
                _currentFrameRange = _standOnSingleTile;
             }
            
            else {
            _currentFrameRange = _stand;
            }

            physicsObject.jumpInAction = false;
            physicsObject.facingLeft = false;
        }
        
        
       else if ((physicsObject.velocity.x == 0) & (physicsObject.velocity.y == 0)
            & ((_previousFrameRange.location == _runLeft.location) || (_previousFrameRange.location == _jumpHorizontalPreApexLeft.location) || (_previousFrameRange.location == _jumpHorizontalPostApexLeft.location) || (_previousFrameRange.location == _jumpVerticalPostApexLeft.location) || (_previousFrameRange.location == _crawlLeft.location) || (_previousFrameRange.location == _turnLeft.location) || (_previousFrameRange.location == _standLeft.location) || (_previousFrameRange.location == _proneLeft.location))
                || (_previousFrameRange.location == _climbToStandLeft.location))
        {
            
            if ((_previousFrameRange.location == _climbToStandLeft.location) & physicsObject.climbingLeft) {
                physicsObject.climbingLeft = false;
                physicsObject.climbComplete = true;
                physicsObject.facingLeft = true;
                return;
                
            }
            
            _currentFrameRange = _standLeft;
            physicsObject.jumpInAction = false;
            physicsObject.facingLeft = true;
        }
        
       else if ((physicsObject.velocity.x > 0) & (physicsObject.velocity.y == 0) & physicsObject.proneInAction) {
           _currentFrameRange = _crawl;
           physicsObject.facingLeft = false;
       }
        
       else if ((physicsObject.velocity.x < 0) & (physicsObject.velocity.y == 0) & physicsObject.proneInAction) {
           _currentFrameRange = _crawlLeft;
           physicsObject.facingLeft = true;
       }
    
       else if ((physicsObject.velocity.x > 0) & (physicsObject.velocity.y == 0)) {
            _currentFrameRange = _run;
           physicsObject.facingLeft = false;
        }
        
       else if ((physicsObject.velocity.x < 0) & (physicsObject.velocity.y == 0)) {
            _currentFrameRange = _runLeft;
           physicsObject.facingLeft = true;
        }
        
       else if ( (physicsObject.velocity.x > 0) & (physicsObject.velocity.y > 0) & (_currentIndexInAnimationArray != (_jumpHorizontalPreApex.location + _jumpHorizontalPreApex.length))
                & !((_previousFrameRange.location == _jumpVerticalPreApex.location) || (_previousFrameRange.location == _jumpVerticalPostApex.location) || (_previousFrameRange.location == _jumpVerticalPreApexLeft.location) || (_previousFrameRange.location == _jumpVerticalPostApexLeft.location) )) {
           _currentFrameRange = _jumpHorizontalPreApex;
           physicsObject.facingLeft = false;
       }
        
       else if ( (physicsObject.velocity.x > 0) & (physicsObject.velocity.y <= 0) & (_currentIndexInAnimationArray != (_jumpHorizontalPostApex.location + _jumpHorizontalPostApex.length))
                & !((_previousFrameRange.location == _jumpVerticalPreApex.location) || (_previousFrameRange.location == _jumpVerticalPostApex.location) || (_previousFrameRange.location == _jumpVerticalPreApexLeft.location) || (_previousFrameRange.location == _jumpVerticalPostApexLeft.location))) {
           _currentFrameRange = _jumpHorizontalPostApex;
           physicsObject.facingLeft = false;
       }
        
       else if ((physicsObject.velocity.x < 0) & (physicsObject.velocity.y > 0) & (_currentIndexInAnimationArray != (_jumpHorizontalPreApexLeft.location + _jumpHorizontalPreApexLeft.length))
                & !((_previousFrameRange.location == _jumpVerticalPreApex.location) || (_previousFrameRange.location == _jumpVerticalPostApex.location) || (_previousFrameRange.location == _jumpVerticalPreApexLeft.location) || (_previousFrameRange.location == _jumpVerticalPostApexLeft.location))) {
           _currentFrameRange = _jumpHorizontalPreApexLeft;
           physicsObject.facingLeft = true;
       }
        
       else if ( (physicsObject.velocity.x < 0) & (physicsObject.velocity.y <= 0) & (_currentIndexInAnimationArray != (_jumpHorizontalPostApexLeft.location + _jumpHorizontalPostApexLeft.length))
                & !((_previousFrameRange.location == _jumpVerticalPreApex.location) || (_previousFrameRange.location == _jumpVerticalPostApex.location) || (_previousFrameRange.location == _jumpVerticalPreApexLeft.location) || (_previousFrameRange.location == _jumpVerticalPostApexLeft.location))) {
           _currentFrameRange = _jumpHorizontalPostApexLeft;
           physicsObject.facingLeft = true;
       }
        
       else if (((_previousFrameRange.location == _stand.location) || (_previousFrameRange.location == _run.location) || (_previousFrameRange.location == _turnRight.location) || (_currentFrameRange.location == _jumpVerticalPreApex.location)) & (physicsObject.velocity.y > 0) & (_currentIndexInAnimationArray != (_jumpVerticalPreApex.location + _jumpVerticalPreApex.length))) {
           
           _currentFrameRange = _jumpVerticalPreApex;
           physicsObject.facingLeft = false;
       }
        
       else if (((_previousFrameRange.location == _jumpVerticalPreApex.location) || (_previousFrameRange.location == _jumpVerticalPostApex.location)) & (physicsObject.velocity.y <= 0) & (_currentIndexInAnimationArray != (_jumpVerticalPostApex.location + _jumpVerticalPostApex.length))) {
           _currentFrameRange = _jumpVerticalPostApex;
           physicsObject.facingLeft = false;
       }
        
       else if (((_previousFrameRange.location == _standLeft.location) || (_previousFrameRange.location == _runLeft.location) || (_previousFrameRange.location == _turnLeft.location) || (_currentFrameRange.location == _jumpVerticalPreApexLeft.location)) & (physicsObject.velocity.y > 0) & (_currentIndexInAnimationArray != (_jumpVerticalPreApexLeft.location + _jumpVerticalPreApexLeft.length))) {
           _currentFrameRange = _jumpVerticalPreApexLeft;
           physicsObject.facingLeft = true;
           
       }
        
       else if (((_previousFrameRange.location == _jumpVerticalPreApexLeft.location) || (_previousFrameRange.location == _jumpVerticalPostApexLeft.location)) & (physicsObject.velocity.y <= 0) & (_currentIndexInAnimationArray != (_jumpVerticalPostApexLeft.location + _jumpVerticalPostApexLeft.length))) {
           _currentFrameRange = _jumpVerticalPostApexLeft;
           physicsObject.facingLeft = true;
       }
        
       else {
           return;
       }
        
        [self animateFor:sprite withSpriteSheet:@"kaseybare"];
        _previousFrameRange = _currentFrameRange;
        return;
        
        
        
    }
        

}
    




@end
