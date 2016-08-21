//
//  TilePaletteViewCell.h
//  kaseygame
//
//  Created by John Feldcamp on 8/19/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tileset.h"
//#import "LevelEditorViewController.h"

@interface TilePaletteViewCell : UICollectionViewCell

- (void)formTileMatrixWithTileset:(Tileset*)currentTileset;

@end
