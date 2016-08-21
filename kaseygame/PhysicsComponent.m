//
//  MovementComponent.m
//  ChunkADT
//
//  Created by John Feldcamp on 7/3/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "PhysicsComponent.h"



@implementation PhysicsComponent {
    SKNode *adjacentTileA;
    SKNode *adjacentTileB;
    SKNode *adjacentTileC;
    SKNode *adjacentTileD;
    SKNode *adjacentTileF;
    SKNode *adjacentTileG;
    SKNode *adjacentTileH;
    SKNode *adjacentTileI;
    
    
    
}

- (id)init{
    _velocity = CGPointMake(0, 0);
    _defaultMaxVelocity = CGPointMake(4, 5);
    _defaultMinVelocity = CGPointMake(-4, -5);
    _maxVelocity = _defaultMaxVelocity;
    _minVelocity = _defaultMinVelocity;
    _gravity = CGPointMake(0, -.2);
    _actualThrust = CGPointMake(0, 0);
    _desiredThrust = CGPointMake(0, 0);
    
    _testBoundingBox = [SKSpriteNode spriteNodeWithColor:[SKColor colorWithRed:1 green:0 blue:0 alpha:.2] size:CGSizeMake(30, 30)];
    
    return self;
}

- (CGPoint)calculateVelocity {
    
   CGPoint presentVelocity = _velocity;
    
    ///
    if (_jumpTypeVertical & !_walkInAction) {
        presentVelocity = CGPointMake(0, presentVelocity.y + [self calculateFriction].y + _desiredThrust.y + _gravity.y);
        
      }
    else {
        presentVelocity = CGPointMake(presentVelocity.x + [self calculateFriction].x + _desiredThrust.x + _gravity.x, presentVelocity.y + [self calculateFriction].y + _desiredThrust.y + _gravity.y);
    }
    ///
    
    if (presentVelocity.y > _maxVelocity.y) {
        presentVelocity = CGPointMake(presentVelocity.x, _maxVelocity.y);
    }
    
    if (presentVelocity.y < _minVelocity.y) {
        presentVelocity= CGPointMake(presentVelocity.x, _minVelocity.y);
    }
    
    if (presentVelocity.x > _maxVelocity.x) {
        presentVelocity = CGPointMake(_maxVelocity.x, presentVelocity.y);
    }
    
    if (presentVelocity.x < _minVelocity.x) {
        presentVelocity = CGPointMake(_minVelocity.x, presentVelocity.y);
    }
    
   // CGPoint roundedVelocity = CGPointMake(roundf(presentVelocity.x) , roundf(presentVelocity.y));
    return presentVelocity;
}




- (CGPoint)calculateFriction {

    return CGPointZero;
}


-(CGRect)getBoundingBoxforPhysicsObject:(SKSpriteNode*)physicsObject withVelocity:(CGPoint)velocity {
    CGRect uncutFrame = [physicsObject calculateAccumulatedFrame];
    
    
    
    
    
    if (_jumpInAction & _jumpTypeVertical) {
        
        if (_facingLeft) {
            CGRect boundingBox = CGRectMake(uncutFrame.origin.x + 45, uncutFrame.origin.y, 15, 60);
            return boundingBox;
        }
        else {
            CGRect boundingBox = CGRectMake(uncutFrame.origin.x + 30, uncutFrame.origin.y, 15, 60);
            return boundingBox;
        }
        
        
    }
    
    if (_jumpInAction) {
        
//        if (_facingLeft) {
            CGRect boundingBox = CGRectMake(uncutFrame.origin.x + 30, uncutFrame.origin.y, 30, 45);
            return boundingBox;
//        }
//        else {
//            CGRect boundingBox = CGRectMake(uncutFrame.origin.x + 30, uncutFrame.origin.y, 30, 45);
//            return boundingBox;
//        }
//        
//        
    }
    
    

    
   if (_proneInAction) {
       if (_facingLeft) {

       CGRect boundingBox = CGRectMake(uncutFrame.origin.x, uncutFrame.origin.y, 50, 30);
       return boundingBox;
       }
       else {
        CGRect boundingBox = CGRectMake(uncutFrame.origin.x + 30, uncutFrame.origin.y, 50, 30);
        return boundingBox;
           
       }
       
   }
    
    
    
    if (_facingLeft) {
        CGRect boundingBox = CGRectMake(uncutFrame.origin.x + 10, uncutFrame.origin.y, 50, 31);
        return boundingBox;

    }
    
    else {
        
        CGRect boundingBox = CGRectMake(uncutFrame.origin.x + 30, uncutFrame.origin.y, 50, 31);
        return boundingBox;
        
    }
    
    
    
}

-(void)delegateActionsForPhysicsObject:(SKSpriteNode *)physicsObject inObjectNode:(SKNode *)objects forChunk:(Chunk *)chunk {
    
    if (_aboutToLandOnLedgeRight) {
        
        if (_toIntersectCTile) {
            physicsObject.position = CGPointMake(adjacentTileC.position.x, adjacentTileC.position.y + 25);
            _toIntersectCTile = false;
        }
        
       else if (_toIntersectFTile) {
            physicsObject.position = CGPointMake(adjacentTileF.position.x, adjacentTileF.position.y + 25);
            _toIntersectFTile = false;
        }
        else {
            CGPoint potentialNewPosition = CGPointMake(adjacentTileI.position.x, adjacentTileI.position.y + 25);
            if (roundf(potentialNewPosition.x) == 0) {
                _aboutToLandOnLedgeRight = false;
                _toIntersectITile = false;
                return;
            }
            else {
                physicsObject.position = potentialNewPosition;
                _toIntersectITile = false;
            }
            
        }
        
        _forceAnimation = true;

        _aboutToLandOnLedgeRight = false;
        _jumpInAction = false;
        _walkInAction = false;
        _hangingRight = true;

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            _allowClimb = true;
        });
        
        return;
    }
    
    if (_aboutToLandOnLedgeLeft) {
        
        if (_toIntersectATile) {
            physicsObject.position = CGPointMake(adjacentTileA.position.x, adjacentTileA.position.y + 25);
            _toIntersectATile = false;
        }
        
       else if (_toIntersectDTile) {
        physicsObject.position = CGPointMake(adjacentTileD.position.x, adjacentTileD.position.y + 25);
            _toIntersectDTile = false;
        }
        else {
            CGPoint potentialNewPosition = CGPointMake(adjacentTileG.position.x, adjacentTileG.position.y + 25);
            if (roundf(potentialNewPosition.x) == 0) {
                _aboutToLandOnLedgeLeft = false;
                _toIntersectGTile = false;
                return;
            }
            else {
                physicsObject.position = potentialNewPosition;
                _toIntersectGTile = false;
            }

        }
        _forceAnimation = true;
        _aboutToLandOnLedgeLeft = false;
        _jumpInAction = false;
        _walkInAction = false;
        _hangingLeft = true;
  
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, .3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            _allowClimb = true;
        });
        
        return;
    }
    
    
    if (_hangingLeft || _hangingRight) {
  
        return;
    }
    
    if (_letGoFromLeft) {
        physicsObject.position = CGPointMake(physicsObject.position.x + 30, physicsObject.position.y - 30);
        _letGoFromLeft = false;
        return;
    }
    
    if (_letGoFromRight) {
        physicsObject.position = CGPointMake(physicsObject.position.x - 30, physicsObject.position.y - 30);
        _letGoFromRight= false;
        return;
    }
    
    if (_aboutToClimbRight) {
        //physicsObject.position = CGPointMake(adjacentTileF.position.x + chunk.tilewidth, adjacentTileF.position.y + 25);
        _aboutToClimbRight = false;
        _climbingRight = true;
        _velocity = CGPointZero;
        return;
    }
    
    if (_aboutToClimbLeft) {
        //physicsObject.position = CGPointMake(adjacentTileF.position.x + chunk.tilewidth, adjacentTileF.position.y + 25);
        _aboutToClimbLeft = false;
        _climbingLeft = true;
        _velocity = CGPointZero;
        return;
    }
    
    if (_climbingRight || _climbingLeft) {
        _jumpInAction = true;
        return;
    }
    
    if (_climbComplete) {
        _climbComplete = false;
        _jumpInAction = false;
        _allowClimb = false;
        physicsObject.position = CGPointMake(physicsObject.position.x, physicsObject.position.y + 35);
        _climbIntoCrawl = false;
        return;
        
    }
    
    else {
        [self setPositionOfPhysicsObject:physicsObject inObjectNode:objects forChunk:chunk];
    }
    
}



-(void)updateAdjacentObjectTileGridForPhysicsObject:(SKSpriteNode*)physicsObject inObjectNode:(SKNode *)objects forChunk:(Chunk*)chunk {
    
    
    // calculates collisions with adjacent object tiles one frame in the future
    
    SKSpriteNode *futurePhysicsObject = [[SKSpriteNode alloc] init];
    futurePhysicsObject = [physicsObject copy];
    futurePhysicsObject.hidden = true;
    CGPoint futureVelocity = [self calculateVelocity];
    futurePhysicsObject.position = CGPointMake(futureVelocity.x + physicsObject.position.x, futureVelocity.y + physicsObject.position.y);
    
    
    CGRect physicsObjectBoundingBox = [self getBoundingBoxforPhysicsObject:futurePhysicsObject withVelocity:futureVelocity];
    CGPoint mid = CGPointMake(CGRectGetMidX (physicsObjectBoundingBox), CGRectGetMidY (physicsObjectBoundingBox));
    CGPoint min = CGPointMake(CGRectGetMinX(physicsObjectBoundingBox) - 1, CGRectGetMinY(physicsObjectBoundingBox) - 1);
    CGPoint max = CGPointMake(CGRectGetMaxX(physicsObjectBoundingBox) + 1, CGRectGetMaxY(physicsObjectBoundingBox) + 1);
    
    _testBoundingBox.size = physicsObjectBoundingBox.size;
    _testBoundingBox.position = mid;


    
    adjacentTileA = [objects nodeAtPoint:CGPointMake(min.x, max.y)];
    CGRect adjacentTileABoundingBox = [adjacentTileA calculateAccumulatedFrame];
    if (adjacentTileABoundingBox.size.width != TILE_SIZE){
        adjacentTileABoundingBox = CGRectNull;
    }
    adjacentTileB = [objects nodeAtPoint:CGPointMake(mid.x, max.y)];
    CGRect adjacentTileBBoundingBox = [adjacentTileB calculateAccumulatedFrame];
    if (adjacentTileBBoundingBox.size.width != TILE_SIZE){
        adjacentTileBBoundingBox = CGRectNull;
    }
    
    adjacentTileC = [objects nodeAtPoint:CGPointMake(max.x, max.y)];
    CGRect adjacentTileCBoundingBox = [adjacentTileC calculateAccumulatedFrame];
    if (adjacentTileCBoundingBox.size.width != TILE_SIZE){
        adjacentTileCBoundingBox = CGRectNull;
    }
    
    adjacentTileD = [objects nodeAtPoint:CGPointMake(min.x, mid.y)];
    CGRect adjacentTileDBoundingBox = [adjacentTileD calculateAccumulatedFrame];
    if (adjacentTileDBoundingBox.size.width != TILE_SIZE){
        adjacentTileDBoundingBox = CGRectNull;
    }
    
    adjacentTileF = [objects nodeAtPoint:CGPointMake(max.x, mid.y)];
    CGRect adjacentTileFBoundingBox = [adjacentTileF calculateAccumulatedFrame];
    if (adjacentTileFBoundingBox.size.width != TILE_SIZE){
        adjacentTileFBoundingBox = CGRectNull;
    }
    
    adjacentTileG = [objects nodeAtPoint:CGPointMake(min.x, min.y)];
    CGRect adjacentTileGBoundingBox = [adjacentTileG calculateAccumulatedFrame];
    if (adjacentTileGBoundingBox.size.width != TILE_SIZE){
        adjacentTileGBoundingBox = CGRectNull;
    }
    
    adjacentTileH = [objects nodeAtPoint:CGPointMake(mid.x, min.y)];
    CGRect adjacentTileHBoundingBox = [adjacentTileH calculateAccumulatedFrame];
    if (adjacentTileHBoundingBox.size.width != TILE_SIZE){
        adjacentTileHBoundingBox = CGRectNull;
    }
    
    adjacentTileI = [objects nodeAtPoint:CGPointMake(max.x, min.y)];
    CGRect adjacentTileIBoundingBox = [adjacentTileI calculateAccumulatedFrame];
    if (adjacentTileIBoundingBox.size.width != TILE_SIZE){
        adjacentTileIBoundingBox = CGRectNull;
    }
    

    //////
    if ((CGRectIntersectsRect(physicsObjectBoundingBox, adjacentTileABoundingBox))){
        _toIntersectATile = true;
        //NSLog(@"physics object to intersect A Tile");
    }

    if ((CGRectIntersectsRect(physicsObjectBoundingBox, adjacentTileBBoundingBox))){
        _toIntersectBTile = true;
        //NSLog(@"physics object to intersect B Tile");
    }
    
    if ((CGRectIntersectsRect(physicsObjectBoundingBox, adjacentTileCBoundingBox))){
        _toIntersectCTile = true;
        //NSLog(@"physics object to intersect C Tile");
    }
    
    if ((CGRectIntersectsRect(physicsObjectBoundingBox, adjacentTileDBoundingBox))){
        _toIntersectDTile = true;
        //NSLog(@"physics object to intersect D Tile");
    }
    
    if ((CGRectIntersectsRect(physicsObjectBoundingBox, adjacentTileFBoundingBox))){
        _toIntersectFTile = true;
        //NSLog(@"physics object to intersect F Tile");
    }
    
    if ((CGRectIntersectsRect(physicsObjectBoundingBox, adjacentTileGBoundingBox))) {
        _toIntersectGTile = true;
        //NSLog(@"physics object to intersect G Tile");
    }
    
    if ((CGRectIntersectsRect(physicsObjectBoundingBox, adjacentTileHBoundingBox))) {
        _toIntersectHTile = true;
        //NSLog(@"physics object to intersect H Tile");
    }
    
    if ((CGRectIntersectsRect(physicsObjectBoundingBox, adjacentTileIBoundingBox))) {
        _toIntersectITile = true;
        //NSLog(@"physics object to intersect I Tile");
    }
    
    if (chunk.hasLeftEdge & (physicsObjectBoundingBox.origin.x < chunk.frame.origin.x)) {
        _toIntersectLeftEdge = true;
        //NSLog(@"physics object to intersect LeftEdge");
    }
    
    if (chunk.hasRightEdge & ((physicsObjectBoundingBox.origin.x + physicsObjectBoundingBox.size.width) > (chunk.frame.origin.x + chunk.frame.size.width))) {
        _toIntersectRightEdge = true;
        //NSLog(@"physics object to intersect RightEdge");
    }
    
    if (chunk.hasTopEdge & ((physicsObjectBoundingBox.origin.y + physicsObjectBoundingBox.size.height) > (chunk.frame.origin.y + chunk.frame.size.height))) {
        _toIntersectTopEdge = true;
        //NSLog(@"physics object to intersect TopEdge");
    }
    
    if (chunk.hasBottomEdge & (physicsObjectBoundingBox.origin.y < chunk.frame.origin.y)) {
        _toIntersectBottomEdge = true;
        //NSLog(@"physics object to intersect BottomEdge");
    }
    ///////

    
   else if ((_toIntersectCTile || _toIntersectFTile || _toIntersectITile) & !_letGoFromRight & _jumpInAction & (_velocity.x > 0)) {
       
       if (_toIntersectCTile & _jumpTypeVertical) {
           
           
           SKNode *tileLeftOfCTile= [objects nodeAtPoint:CGPointMake(adjacentTileC.position.x - 30, adjacentTileC.position.y)];
           CGRect tempBoundingBox = [tileLeftOfCTile calculateAccumulatedFrame];
           if (!CGSizeEqualToSize(CGSizeMake(30, 30), tempBoundingBox.size)) {
               
               SKNode *tileAboveCTile= [objects nodeAtPoint:CGPointMake(adjacentTileC.position.x, adjacentTileC.position.y + 40)];
               CGRect tempBoundingBox = [tileAboveCTile calculateAccumulatedFrame];
               if (tempBoundingBox.size.width != TILE_SIZE){
                   _aboutToLandOnLedgeRight = true;
                   //_toIntersectFTile = false;
                   
                   SKNode *tileAboveThat= [objects nodeAtPoint:CGPointMake(adjacentTileC.position.x, adjacentTileC.position.y + 70)];
                   CGRect tempBoundingBox = [tileAboveThat calculateAccumulatedFrame];
                   if (tempBoundingBox.size.width == TILE_SIZE){
                       _climbIntoCrawl = true;
                   }
               }
           }
           return;
       }

       
       
       
       if (_toIntersectFTile) {
           
        
        SKNode *tileLeftOfFTile= [objects nodeAtPoint:CGPointMake(adjacentTileF.position.x - 30, adjacentTileF.position.y)];
        CGRect tempBoundingBox = [tileLeftOfFTile calculateAccumulatedFrame];
        if (!CGSizeEqualToSize(CGSizeMake(30, 30), tempBoundingBox.size)) {
            
            SKNode *tileAboveFTile= [objects nodeAtPoint:CGPointMake(adjacentTileF.position.x, adjacentTileF.position.y + 40)];
            CGRect tempBoundingBox = [tileAboveFTile calculateAccumulatedFrame];
            if (tempBoundingBox.size.width != TILE_SIZE){
                _aboutToLandOnLedgeRight = true;
                //_toIntersectFTile = false;
            
                SKNode *tileAboveThat= [objects nodeAtPoint:CGPointMake(adjacentTileF.position.x, adjacentTileF.position.y + 70)];
                CGRect tempBoundingBox = [tileAboveThat calculateAccumulatedFrame];
                if (tempBoundingBox.size.width == TILE_SIZE){
                    _climbIntoCrawl = true;
                }
            }
        }
         return;
       }
       
      else if (_toIntersectITile & !_jumpTypeVertical) {
           
           
           SKNode *tileLeftOfITile= [objects nodeAtPoint:CGPointMake(adjacentTileI.position.x - 30, adjacentTileI.position.y)];
           CGRect tempBoundingBox = [tileLeftOfITile calculateAccumulatedFrame];
           if (!CGSizeEqualToSize(CGSizeMake(30, 30), tempBoundingBox.size)) {
               
               SKNode *tileAboveITile= [objects nodeAtPoint:CGPointMake(adjacentTileI.position.x, adjacentTileI.position.y + 40)];
               CGRect tempBoundingBox = [tileAboveITile calculateAccumulatedFrame];
               if (tempBoundingBox.size.width != TILE_SIZE){
                   _aboutToLandOnLedgeRight = true;
                   //_toIntersectITile = false;
                   
                   SKNode *tileAboveThat= [objects nodeAtPoint:CGPointMake(adjacentTileI.position.x, adjacentTileI.position.y + 70)];
                   CGRect tempBoundingBox = [tileAboveThat calculateAccumulatedFrame];
                   if (tempBoundingBox.size.width == TILE_SIZE){
                       _climbIntoCrawl = true;
                   }
               }
           }
           return;
       }
    }
    
    
    
    
    
    
   else if ((_toIntersectATile || _toIntersectDTile || _toIntersectGTile) & !_letGoFromLeft & _jumpInAction & (_velocity.x < 0)) {
       
       if (_toIntersectATile & _jumpTypeVertical) {
           
           SKNode *tileRightOfATile= [objects nodeAtPoint:CGPointMake(adjacentTileA.position.x + 30, adjacentTileA.position.y)];
           CGRect tempBoundingBox = [tileRightOfATile calculateAccumulatedFrame];
           if (!CGSizeEqualToSize(CGSizeMake(30, 30), tempBoundingBox.size)) {
               
               SKNode *tileAboveATile= [objects nodeAtPoint:CGPointMake(adjacentTileA.position.x, adjacentTileA.position.y + 40)];
               CGRect tempBoundingBox = [tileAboveATile calculateAccumulatedFrame];
               if (tempBoundingBox.size.width != TILE_SIZE){
                   _aboutToLandOnLedgeLeft = true;
                   //_toIntersectDTile = false;
                   
                   SKNode *tileAboveThat= [objects nodeAtPoint:CGPointMake(adjacentTileA.position.x, adjacentTileA.position.y + 70)];
                   CGRect tempBoundingBox = [tileAboveThat calculateAccumulatedFrame];
                   if (tempBoundingBox.size.width == TILE_SIZE){
                       _climbIntoCrawl = true;
                   }
               }
               
           }
           return;
       }

       
       if (_toIntersectDTile) {
       
       SKNode *tileRightOfDTile= [objects nodeAtPoint:CGPointMake(adjacentTileD.position.x + 30, adjacentTileD.position.y)];
       CGRect tempBoundingBox = [tileRightOfDTile calculateAccumulatedFrame];
       if (!CGSizeEqualToSize(CGSizeMake(30, 30), tempBoundingBox.size)) {
           
           SKNode *tileAboveDTile= [objects nodeAtPoint:CGPointMake(adjacentTileD.position.x, adjacentTileD.position.y + 40)];
           CGRect tempBoundingBox = [tileAboveDTile calculateAccumulatedFrame];
           if (tempBoundingBox.size.width != TILE_SIZE){
               _aboutToLandOnLedgeLeft = true;
               //_toIntersectDTile = false;
           
               SKNode *tileAboveThat= [objects nodeAtPoint:CGPointMake(adjacentTileD.position.x, adjacentTileD.position.y + 70)];
               CGRect tempBoundingBox = [tileAboveThat calculateAccumulatedFrame];
               if (tempBoundingBox.size.width == TILE_SIZE){
                   _climbIntoCrawl = true;
               }
           }
           
       }
       return;
       }
       else if (_toIntersectGTile & !_jumpTypeVertical) {
           
           SKNode *tileRightOfGTile= [objects nodeAtPoint:CGPointMake(adjacentTileG.position.x + 30, adjacentTileG.position.y)];
           CGRect tempBoundingBox = [tileRightOfGTile calculateAccumulatedFrame];
           if (!CGSizeEqualToSize(CGSizeMake(30, 30), tempBoundingBox.size)) {
               
               SKNode *tileAboveGTile= [objects nodeAtPoint:CGPointMake(adjacentTileG.position.x, adjacentTileG.position.y + 40)];
               CGRect tempBoundingBox = [tileAboveGTile calculateAccumulatedFrame];
               if (tempBoundingBox.size.width != TILE_SIZE){
                   _aboutToLandOnLedgeLeft = true;
                   //_toIntersectGTile = false;
                   
                   SKNode *tileAboveThat= [objects nodeAtPoint:CGPointMake(adjacentTileG.position.x, adjacentTileG.position.y + 70)];
                   CGRect tempBoundingBox = [tileAboveThat calculateAccumulatedFrame];
                   if (tempBoundingBox.size.width == TILE_SIZE){
                       _climbIntoCrawl = true;
                   }
               }
               
           }
           return;

           
       }
       
    }
    
    if (_proneInAction & (!CGRectIsNull(adjacentTileABoundingBox) || !CGRectIsNull(adjacentTileBBoundingBox) || !CGRectIsNull(adjacentTileCBoundingBox)) & (!CGRectIsNull(adjacentTileGBoundingBox) || !CGRectIsNull(adjacentTileHBoundingBox) || !CGRectIsNull(adjacentTileIBoundingBox))) {
        _inTunnel = true;
        //_proneInAction = true;
    }
    else {
        _inTunnel = false;
    }

    
}



-(void)setPositionOfPhysicsObject:(SKSpriteNode *)physicsObject inObjectNode:(SKNode*)objects forChunk:(Chunk *)chunk {
    
    // set the thrust to a consistent amount throughout each set of physics calculations, so that the player cannot alter the thrust while the calculations are being performed
    _desiredThrust = _actualThrust;

    // calculate future position, and set appropriate flags
    [self updateAdjacentObjectTileGridForPhysicsObject:physicsObject inObjectNode:objects forChunk:chunk];
    if (_aboutToLandOnLedgeLeft || _aboutToLandOnLedgeRight) {
        _velocity = CGPointZero;
        [self delegateActionsForPhysicsObject:physicsObject inObjectNode:objects forChunk:chunk];
        return;
    }
    //
    
    
    /////// resolve collisions with object tiles ///////////////
    if (_toIntersectDTile) {
        
        _desiredPosition = CGPointMake(adjacentTileD.position.x + TILE_SIZE, physicsObject.position.y);
        _minVelocity = CGPointMake(0, _minVelocity.y);
        _toIntersectATile = false;
        _toIntersectDTile = false;
        _toIntersectGTile = false;
        
    }
    
    if (_toIntersectFTile) {
        
        _desiredPosition = CGPointMake(adjacentTileF.position.x - TILE_SIZE, physicsObject.position.y);
        _maxVelocity = CGPointMake(0, _maxVelocity.y);
        _toIntersectCTile = false;
        _toIntersectFTile = false;
        _toIntersectITile = false;
    
    }
    
    if (_toIntersectATile || _toIntersectBTile || _toIntersectCTile) {
       
       if (_toIntersectATile) {
           if (!_proneInAction) {
               _minVelocity = CGPointMake(0, _minVelocity.y);
           }
           _desiredPosition = CGPointMake(physicsObject.position.x, adjacentTileA.position.y - TILE_SIZE);
       }
       else if (_toIntersectBTile) {
           _desiredPosition = CGPointMake(physicsObject.position.x, adjacentTileB.position.y - TILE_SIZE);
       }
       else if (_toIntersectCTile) {
           if (!_proneInAction) {
               _maxVelocity = CGPointMake(0, _maxVelocity.y);
           }
           _desiredPosition = CGPointMake(physicsObject.position.x, adjacentTileC.position.y - TILE_SIZE);
       }
       _maxVelocity = CGPointMake(_maxVelocity.x, 0);
       _toIntersectATile = false;
       _toIntersectBTile = false;
       _toIntersectCTile = false;
    }
    
    if (_toIntersectGTile || _toIntersectHTile || _toIntersectITile) {
        
        if (_toIntersectGTile & !_toIntersectHTile & (physicsObject.position.y < (adjacentTileG.position.y + TILE_SIZE))) {
            _desiredPosition = CGPointMake(adjacentTileG.position.x + TILE_SIZE, physicsObject.position.y);
            _minVelocity = CGPointMake(0, _minVelocity.y);
    
            _toIntersectGTile = false;
        }
        
       else if (_toIntersectITile & !_toIntersectHTile & (physicsObject.position.y < (adjacentTileI.position.y + TILE_SIZE))) {
            _desiredPosition = CGPointMake(adjacentTileI.position.x - TILE_SIZE, physicsObject.position.y);
            _maxVelocity = CGPointMake(0, _maxVelocity.y);
            
            _toIntersectITile = false;
        }
       else if (_toIntersectGTile) {
            _desiredPosition = CGPointMake(physicsObject.position.x, adjacentTileG.position.y + TILE_SIZE);
             _toIntersectGTile = false;
        }
        else if (_toIntersectHTile) {
            _desiredPosition = CGPointMake(physicsObject.position.x, adjacentTileH.position.y + TILE_SIZE);
            _toIntersectHTile = false;
        }
        else if (_toIntersectITile) {
            _desiredPosition = CGPointMake(physicsObject.position.x, adjacentTileI.position.y + TILE_SIZE);
            _toIntersectITile = false;
        }
           
        
        _minVelocity = CGPointMake(_minVelocity.x, 0);

        if (_jumpInAction & (_velocity.y < 0)) {
            _jumpInAction = false;
            //_forceAnimation = true;
        }
        
        if (!_walkInAction) {
            [self endWalk];
        }
           
        
       }
    
    ///////
    
    //// resolve collisions with map edges
    if (_toIntersectLeftEdge) {
        _desiredPosition = CGPointMake(chunk.frame.origin.x, physicsObject.position.y);
        _minVelocity = CGPointMake(0, _minVelocity.y);
        _toIntersectLeftEdge = false;
    }
    
    if (_toIntersectRightEdge) {
        _desiredPosition = CGPointMake(chunk.frame.origin.x + chunk.frame.size.width, physicsObject.position.y);
        _maxVelocity = CGPointMake(0, _maxVelocity.y);
        _toIntersectRightEdge = false;
    }
    
    if (_toIntersectTopEdge) {
        _desiredPosition = CGPointMake(physicsObject.position.x, chunk.frame.origin.y + chunk.frame.size.height);
        _maxVelocity = CGPointMake(_maxVelocity.x, 0);
        _toIntersectTopEdge = false;
    }
    
    if (_toIntersectBottomEdge) {
        _desiredPosition = CGPointMake(physicsObject.position.x, chunk.frame.origin.y);
        _minVelocity = CGPointMake(_minVelocity.x, 0);
        _toIntersectBottomEdge = false;
    }
    ////
    

    else {
        _desiredPosition = physicsObject.position;
    }
    
    _velocity = [self calculateVelocity];
    //NSLog(@"_velocity:%f, %f", _velocity.x, _velocity.y);
    physicsObject.position = CGPointMake(roundf(_velocity.x + _desiredPosition.x), roundf(_velocity.y + _desiredPosition.y));
   // NSLog(@"player.position after setting:%f, %f", physicsObject.position.x, physicsObject.position.y);
    
    // reset
    _desiredThrust = CGPointZero;
    _actualThrust = CGPointZero;
    _maxVelocity = _defaultMaxVelocity;
    _minVelocity = _defaultMinVelocity;
    //
    
}

-(void)endWalk {
    _velocity = CGPointMake(0, _velocity.y);
    _walkInAction = false;
    
}

-(void)endJump {
    if (_velocity.y > 0) {
            _velocity = (CGPointMake(_velocity.x, 0));
    }
    //_velocity = (CGPointMake(_velocity.x, 0));
    //_jumpInAction = false;
}

@end
