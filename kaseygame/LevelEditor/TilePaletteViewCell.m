//
//  TilePaletteViewCell.m
//  kaseygame
//
//  Created by John Feldcamp on 8/19/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "TilePaletteViewCell.h"

@implementation TilePaletteViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)formTileMatrixWithTileset:(Tileset *)currentTileset {
    
    UILabel* nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 180, 21)];
    nameLabel.text = currentTileset.name;
    nameLabel.numberOfLines = 1;
    nameLabel.adjustsFontSizeToFitWidth = YES;
    nameLabel.minimumScaleFactor = .7f;
    nameLabel.clipsToBounds = YES;
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor blackColor];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:nameLabel];
    
    CGPoint minInCell = CGPointMake(10, 40);
    CGPoint maxInCell = CGPointMake(170, 170);
    
    int xPos = minInCell.x;
    int yPos = minInCell.y;
    
    Tile *tile = [[Tile alloc] init];
    int currentIndex = 0;
    
    while (1) {

        if (xPos > maxInCell.x) {
            xPos = minInCell.x;
            yPos += 40;
            continue;
        }
        tile = [currentTileset.tiles objectAtIndex:currentIndex];
        
        UIButton *thisButton = [UIButton buttonWithType:UIButtonTypeCustom];
        thisButton.frame = CGRectMake(xPos, yPos, 30, 30);
        [thisButton setImage:tile.image forState:UIControlStateNormal];
        [thisButton setTitle:[NSString stringWithFormat:@"%d", tile.gid] forState:UIControlStateNormal];
        
        [thisButton addTarget:self action:@selector(handleTileSelection:) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:thisButton];
        
        if ([tile isEqual:[currentTileset.tiles lastObject]]) {
            return;
        }
        
        xPos += 40;
        currentIndex ++;
    }
    
    
}

- (void)handleTileSelection:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"palette tile selected" object:nil userInfo:[NSDictionary dictionaryWithObject:sender forKey:@"tile"]];
}




@end
