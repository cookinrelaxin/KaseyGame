//
//  ControlComponent.m
//  ChunkADT
//
//  Created by John Feldcamp on 7/6/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "ControlComponent.h"

@implementation ControlComponent

- (id)initControlsForChunkSize:(CGSize)levelsize {
    
    CGSize dpadLeftSize = CGSizeMake(levelsize.width / 4, levelsize.height);
    _dpadLeft = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.30 green:.15 blue:0 alpha:.2] size:dpadLeftSize];
    _dpadLeft.anchorPoint = CGPointMake(0, 0);
    //_dpadLeft.hidden = true;
    
    CGSize dpadRightSize = CGSizeMake(levelsize.width / 4, levelsize.height);
    _dpadRight = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:0.30 green:.15 blue:0 alpha:.2] size:dpadRightSize];
    _dpadRight.anchorPoint = CGPointMake(0, 0);
    _dpadRight.position = CGPointMake(levelsize.width * 3/4, 0);
    //_dpadRight.hidden = true;
    
    _thresholdForJump = 2;
    //_jumpMaxDuration = 3;
    _horizontalJumpPower = 4;
    _verticalJumpPower = 5;
    _walkMaxPower = 5;
    _touchDifferenceToObjectVelocityModifierX = .1;
    _touchDifferenceToObjectVelocityModifierY = 1;
    
    
    return self;
}

- (void) leftDpad:(PhysicsComponent*)physicsObject asSpriteNode:(SKSpriteNode *)node withAnimation:(AnimationComponent *)animation {
 
    //NSLog(@"dpadleft touched");
    NSInteger differenceBetweenTouchesLeft = abs(_currentTouchLocationLeft.x - _firstTouchLocationLeft.x);
    //NSLog(@"differenceBetweenTouchesLeft:%ld", (long)differenceBetweenTouchesLeft);
    
    
    if (_currentTouchLocationLeft.x > _firstTouchLocationLeft.x){
       
       if (physicsObject.hangingRight & physicsObject.allowClimb) {
           physicsObject.aboutToClimbRight = true;
           physicsObject.hangingRight = false;
           return;
       }
       
      if (physicsObject.proneInAction) {
           
           physicsObject.actualThrust = CGPointMake(1, physicsObject.actualThrust.y);
           physicsObject.maxVelocity = CGPointMake(physicsObject.defaultMaxVelocity.x / 2, physicsObject.maxVelocity.y);
           physicsObject.walkInAction = true;
           return;
       }
        
        if (animation.previousFrameRange.location == animation.standLeft.location) {
            animation.currentFrameRange = animation.turnRight;
            animation.previousFrameRange = animation.turnRight;

            //physicsObject.forceAnimation = true;
            return;
        }
        
        if (animation.previousFrameRange.location == animation.jumpVerticalPreApexLeft.location) {
            animation.currentFrameRange = animation.jumpVerticalPreApex;
            animation.previousFrameRange = animation.jumpVerticalPreApex;
            
            switch (animation.currentIndexInAnimationArray) {
                case 107:
                    animation.currentIndexInAnimationArray = 100;
                    break;
                    
                case 108:
                    animation.currentIndexInAnimationArray = 101;
                    break;
                    
                case 109:
                    animation.currentIndexInAnimationArray = 102;
                    break;
                    
                case 110:
                    animation.currentIndexInAnimationArray = 103;
                    break;

                default:
                    break;
            }
            
            
            //physicsObject.forceAnimation = true;
            return;
        }
        
        
        if (differenceBetweenTouchesLeft > 60) {
            physicsObject.maxVelocity  = physicsObject.defaultMaxVelocity;
            animation.desiredCountToPresentNextSprite = 5;
            //NSLog(@"differenceBetweenTouchesLeft > 60");
        }
        
        else if (differenceBetweenTouchesLeft > 45) {
            physicsObject.maxVelocity = CGPointMake(physicsObject.defaultMaxVelocity.x - .5, physicsObject.maxVelocity.y);
            animation.desiredCountToPresentNextSprite = 6;
           // NSLog(@"differenceBetweenTouchesLeft > 45");
        }
        
        else if (differenceBetweenTouchesLeft > 30) {
            physicsObject.maxVelocity = CGPointMake(physicsObject.defaultMaxVelocity.x - 1, physicsObject.maxVelocity.y);
            animation.desiredCountToPresentNextSprite = 6;
            //NSLog(@"differenceBetweenTouchesLeft > 30");
        }
        
        else if (differenceBetweenTouchesLeft > 15) {
            physicsObject.maxVelocity = CGPointMake(physicsObject.defaultMaxVelocity.x - 1.5, physicsObject.maxVelocity.y);
            animation.desiredCountToPresentNextSprite = 7;
            //NSLog(@"differenceBetweenTouchesLeft > 15");
        }
        else {
            return;
        }
        
        //NSLog(@"physicsObject.maxVelocity.x:%f",physicsObject.maxVelocity.x);

        
        physicsObject.actualThrust = CGPointMake(_walkMaxPower, physicsObject.actualThrust.y);
        physicsObject.walkInAction = true;
        
        
    }
    
    else if (_currentTouchLocationLeft.x < _firstTouchLocationLeft.x) {
        
        if (physicsObject.hangingLeft & physicsObject.allowClimb) {
            physicsObject.aboutToClimbLeft = true;
            physicsObject.hangingLeft = false;
            //physicsObject.allowClimb = false;
            return;
        }
        
         if (physicsObject.proneInAction) {
            
            physicsObject.actualThrust = CGPointMake(-1, physicsObject.actualThrust.y);
            physicsObject.minVelocity = CGPointMake(physicsObject.defaultMinVelocity.x / 2, physicsObject.minVelocity.y);
            physicsObject.walkInAction = true;
            return;
        }
        
        if (animation.previousFrameRange.location == animation.stand.location) {
            animation.currentFrameRange = animation.turnLeft;
            animation.previousFrameRange = animation.turnLeft;
            //physicsObject.forceAnimation = true;
            return;
        }
        
        if (animation.previousFrameRange.location == animation.jumpVerticalPreApex.location) {
            animation.currentFrameRange = animation.jumpVerticalPreApexLeft;
            animation.previousFrameRange = animation.jumpVerticalPreApexLeft;
            
            switch (animation.currentIndexInAnimationArray) {
                case 100:
                    animation.currentIndexInAnimationArray = 107;
                    break;
                    
                case 101:
                    animation.currentIndexInAnimationArray = 108;
                    break;
                    
                case 102:
                    animation.currentIndexInAnimationArray = 109;
                    break;
                    
                case 103:
                    animation.currentIndexInAnimationArray = 110;
                    break;
                    
                default:
                    break;
            }
            
            //physicsObject.forceAnimation = true;
            return;
        }

        if (differenceBetweenTouchesLeft > 60) {
            physicsObject.minVelocity  = physicsObject.defaultMinVelocity;
            animation.desiredCountToPresentNextSprite = 5;
            //NSLog(@"differenceBetweenTouchesLeft > 60");
        }
        
        else if (differenceBetweenTouchesLeft > 45) {
            physicsObject.minVelocity = CGPointMake(physicsObject.defaultMinVelocity.x + .5, physicsObject.minVelocity.y);
            animation.desiredCountToPresentNextSprite = 6;
            //NSLog(@"differenceBetweenTouchesLeft > 45");
        }
        
        else if (differenceBetweenTouchesLeft > 30) {
            physicsObject.minVelocity = CGPointMake(physicsObject.defaultMinVelocity.x + 1, physicsObject.minVelocity.y);
            animation.desiredCountToPresentNextSprite = 6;
           // NSLog(@"differenceBetweenTouchesLeft > 30");
        }
        
        else if (differenceBetweenTouchesLeft > 15) {
            physicsObject.minVelocity = CGPointMake(physicsObject.defaultMinVelocity.x + 1.5, physicsObject.minVelocity.y);
            animation.desiredCountToPresentNextSprite = 7;
            //NSLog(@"differenceBetweenTouchesLeft > 15");
        }
        else {
            return;
        }
        
        //NSLog(@"physicsObject.minVelocity.x:%f",physicsObject.minVelocity.x);
        
        physicsObject.actualThrust = CGPointMake(-_walkMaxPower, physicsObject.actualThrust.y);
        physicsObject.walkInAction = true;
        

    }
    
    

    
}

-(void)rightDpad:(PhysicsComponent *)physicsObject asSpriteNode:(SKSpriteNode *)node withAnimation:(AnimationComponent *)animation {
    NSInteger differenceBetweenTouchesRight = (_currentTouchLocationRight.y  - _firstTouchLocationRight.y);
    
    
    if (physicsObject.hangingLeft & (differenceBetweenTouchesRight < _thresholdForProne)) {
        physicsObject.hangingLeft = false;
        physicsObject.letGoFromLeft = true;
    }
    
    if (physicsObject.hangingRight & (differenceBetweenTouchesRight < _thresholdForProne)) {
        physicsObject.hangingRight = false;
        physicsObject.letGoFromRight = true;
    }
    
    if ((differenceBetweenTouchesRight < _thresholdForProne) & !physicsObject.proneInAction & (physicsObject.toIntersectGTile || physicsObject.toIntersectHTile || physicsObject.toIntersectITile)) {
        physicsObject.proneInAction = true;
    }
    
    else if ((differenceBetweenTouchesRight > _thresholdForJump) & !physicsObject.inTunnel) {
         if (physicsObject.proneInAction) {
            physicsObject.proneInAction = false;
            return;
         }
        
        if (!physicsObject.jumpInAction & (animation.currentFrameRange.location != animation.prone.location) & (animation.currentFrameRange.location != animation.proneLeft.location) & (animation.currentFrameRange.location != animation.crawl.location) & (animation.currentFrameRange.location != animation.crawlLeft.location)) {
            
            physicsObject.jumpInAction = true;
            
            if (physicsObject.walkInAction) {
                physicsObject.jumpTypeVertical = false;
                physicsObject.actualThrust = CGPointMake(physicsObject.actualThrust.x, _horizontalJumpPower);
            }
            else {
                physicsObject.jumpTypeVertical = true;
                physicsObject.actualThrust = CGPointMake(physicsObject.actualThrust.x, _verticalJumpPower);
                
            }
        }
    }
    
    
    
}


    


@end
