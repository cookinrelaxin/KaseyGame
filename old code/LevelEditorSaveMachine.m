//
//  LevelEditorSaveLevel.m
//  kaseygame
//
//  Created by John Feldcamp on 8/21/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "LevelEditorSaveMachine.h"

NSString* encloseTreeValueWithinXMLTags(Tree* tree, NSString* value) {
    NSString* startTag = [NSString stringWithFormat:@"<%@>", tree.name];
    NSString* endTag = [NSString stringWithFormat:@"</%@>", tree.name];
    
    return [NSString stringWithFormat:@"%@ %@ %@", startTag, value, endTag];
    
}


BOOL firstObjectAlreadyDealtWith;
NSString *recursivelyGenerateLevelFileFromTree(Tree *tree, int i) {
    Tree* tempSubtree = [tree.subTrees objectAtIndex:i];
    
    if (tempSubtree.subTrees == nil) {
        if (tempSubtree == [tree.subTrees lastObject]) {
            return encloseTreeValueWithinXMLTags(tempSubtree, tempSubtree.value);
        }
        NSString* next = encloseTreeValueWithinXMLTags(tempSubtree, tempSubtree.value);
        return [next stringByAppendingString:recursivelyGenerateLevelFileFromTree(tree, i + 1)];
        
    }
    
    if (tempSubtree == [tree.subTrees lastObject]) {
        return encloseTreeValueWithinXMLTags (tempSubtree, recursivelyGenerateLevelFileFromTree(tempSubtree, 0));
    }
    
    if (!firstObjectAlreadyDealtWith) {
        firstObjectAlreadyDealtWith = TRUE;
        return encloseTreeValueWithinXMLTags (tree, recursivelyGenerateLevelFileFromTree(tree, 0));
    }
    
    NSString* next = encloseTreeValueWithinXMLTags (tempSubtree, recursivelyGenerateLevelFileFromTree(tempSubtree, 0));
    return [next stringByAppendingString:recursivelyGenerateLevelFileFromTree(tree, i + 1)];
    
}


@implementation LevelEditorSaveMachine

-(instancetype) init {
    
    _model = [[Tree alloc] init];
    
    return self;
}

-(void)saveLevel:(LevelEditorScene *)level {
    // before we move further, lets implement the "create level from scratch" function of the level editor
    [self outlineModelForLevel:level];
    
    /// do something with this file
    [self writeSaveFileToDrive: [self generateLevelFileForLevelTree:_model]];
}

-(void)outlineModelForLevel:(LevelEditorScene*)level {
    
    _model.name = @"map";
    _model.subTrees = [NSMutableArray array];
    
        ////
        Tree* tileSetsTree = [[Tree alloc] init];
        tileSetsTree.name = @"tilesets";
        tileSetsTree.subTrees = [NSMutableArray array];
    
        for (Tileset* tileset in level.masterPalette.tileSets) {
            Tree* tilesetTree = [[Tree alloc] init];
            tilesetTree.name = @"tileset";
            
                Tree* tilesetTreeName = [[Tree alloc] init];
                tilesetTreeName.name = @"name";
                tilesetTreeName.value = tileset.name;
            
                Tree* tilesetTreeFirstGid = [[Tree alloc] init];
                tilesetTreeFirstGid.name = @"first gid";
                tilesetTreeFirstGid.value = [NSString stringWithFormat:@"%lu", (unsigned long)tileset.gidRange.location];
            
            tilesetTree.subTrees = [NSMutableArray arrayWithObjects:tilesetTreeName, tilesetTreeFirstGid, nil];
            [tileSetsTree.subTrees addObject:tilesetTree];
            
        }
        [_model.subTrees addObject:tileSetsTree];
        ////
    
    
    
        ////
        Tree* gidPropertiesTree = [[Tree alloc] init];
        gidPropertiesTree.name = @"gid properties";
        gidPropertiesTree.subTrees = [NSMutableArray array];
    
        for (Tileset* tileset in level.masterPalette.tileSets) {
            for (Tile* tile in tileset.tiles) {
                Tree* gidTree = [[Tree alloc] init];
                gidTree.name = @"gid";
                
                    Tree* numberTree = [[Tree alloc] init];
                    numberTree.name = @"number";
                    numberTree.value = [NSString stringWithFormat:@"%ld", (long)tile.gid];
                
                    Tree* speciesTree = [[Tree alloc] init];
                    speciesTree.name = @"species";
                    speciesTree.value = [NSString stringWithFormat:@"%ld", (long)tile.currentTileSpecies];
                
                gidTree.subTrees = [NSMutableArray arrayWithObjects:numberTree, speciesTree, nil];
                [gidPropertiesTree.subTrees addObject:gidTree];
                
            }
            
        }
        [_model.subTrees addObject:gidPropertiesTree];
        ////
    
    
    
        ////
        Tree* tilesTree = [[Tree alloc] init];
        tilesTree.name = @"tiles";
        tilesTree.subTrees = [NSMutableArray array];
    
        for (SKSpriteNode* tileNode in level.world.children) {
            Tree* tileTree = [[Tree alloc] init];
            tileTree.name = @"tile";
            
                Tree* gidTree = [[Tree alloc] init];
                gidTree.name = @"gid";
                gidTree.value = [NSString stringWithFormat:@"%@", [tileNode.userData objectForKey:@"gid"]];
                
                Tree* xCoordinateTree = [[Tree alloc] init];
                xCoordinateTree.name = @"x";
                xCoordinateTree.value = [NSString stringWithFormat:@"%f", tileNode.position.x];
            
                Tree* yCoordinateTree = [[Tree alloc] init];
                yCoordinateTree.name = @"y";
                yCoordinateTree.value = [NSString stringWithFormat:@"%f", tileNode.position.y];
            
            tileTree.subTrees = [NSMutableArray arrayWithObjects:gidTree, xCoordinateTree, yCoordinateTree, nil];
            [tilesTree.subTrees addObject:tileTree];
            
        }
        [_model.subTrees addObject:tilesTree];

}

-(NSString*)generateLevelFileForLevelTree:(Tree*)levelTree {
    NSString *file;

    file = recursivelyGenerateLevelFileFromTree(levelTree, 0);
    //NSLog(@"file: %@", file);
    return file;
}

-(void)writeSaveFileToDrive:(NSString*)saveFile {
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *docDir = [paths objectAtIndex: 0];
//    NSString *docFile = [docDir stringByAppendingPathComponent: @"testLevel.xml"];
//    NSURL* url = [NSURL URLWithString:docFile];
//    
//    NSError *error = nil;
//    BOOL ok = [saveFile writeToURL:url atomically:YES
//                        encoding:NSUnicodeStringEncoding error:&error];
//    if (!ok) {
//        NSLog(@"Error writing file at %@\n%@",
//              url, [error localizedFailureReason]);
//    }
}

@end
