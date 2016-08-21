//
//  TilePaletteCollectionViewController.m
//  kaseygame
//
//  Created by John Feldcamp on 8/18/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "TilePaletteCollectionViewController.h"

@implementation TilePaletteCollectionViewController {
    NSInteger currentIndexInPaletteArray;
    NSInteger currentIndexInThisTileset;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    //_paletteArray = [NSMutableArray array];
    currentIndexInPaletteArray = 0;
    currentIndexInThisTileset = 0;
    [self loadTilesets];
 
}

- (void)loadTilesets {
    
    NSBundle* myBundle = [NSBundle mainBundle];
    NSArray* tilesetPaths = [myBundle pathsForResourcesOfType:@"png" inDirectory:@"art assets/iphone tilesets"];
    int currentGid = 0;
    for (NSString* path in tilesetPaths) {
       // NSLog(@"path:%@",path);
        NSString* chunkPathWithoutExtension = [[path lastPathComponent] stringByDeletingPathExtension];
        UIImage* tilesetImage = [UIImage imageWithContentsOfFile:path];
        Tileset* currentTileset = [[Tileset alloc] initTileset];
        currentTileset.tiles = [currentTileset unpackTiles:tilesetImage startingWithGid:currentGid];
        currentTileset.name = chunkPathWithoutExtension;

        [_palette.tileSets addObject:currentTileset];
        Tile* lastTileInPalette = [currentTileset.tiles lastObject];
        currentGid = lastTileInPalette.gid + 1;
        
    }
    
    
}

-(NSInteger)numberOfSectionsInCollectionView:
(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {

    Tileset* currentTileset = [[Tileset alloc] initTileset];
    currentTileset = [_palette.tileSets objectAtIndex:currentIndexInPaletteArray];
    NSInteger tileCountInCurrentTileset = [currentTileset.tiles count];
    int i;
    for (i = 0; i <= tileCountInCurrentTileset; i ++) {
        NSString *identifier = [NSString stringWithFormat:@"%d", i];
        [self.collectionView registerClass:[TilePaletteViewCell class]forCellWithReuseIdentifier:identifier];
    }
    currentIndexInPaletteArray ++;
         
    return tileCountInCurrentTileset;
    
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
 
    NSString *identifier = [NSString stringWithFormat:@"%d", indexPath.item];
    TilePaletteViewCell* newCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
 
    Tileset* currentTileset = [[Tileset alloc] initTileset];
    currentTileset = [_palette.tileSets objectAtIndex:indexPath.item];
    [newCell formTileMatrixWithTileset:currentTileset];
        return newCell;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
