//
//  TilePaletteCollectionViewController.h
//  kaseygame
//
//  Created by John Feldcamp on 8/18/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tileset.h"
#import "TilePaletteViewCell.h"
#import "Palette.h"

@interface TilePaletteCollectionViewController : UICollectionViewController
<UICollectionViewDataSource, UICollectionViewDelegate>


// an array of tilesets
@property (strong,nonatomic) Palette *palette;

@end
