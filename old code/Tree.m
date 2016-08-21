//
//  TreeModel.m
//  kaseygame
//
//  Created by John Feldcamp on 8/21/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "Tree.h"

@implementation Tree

-(instancetype) init {
    _name = [NSString string];
    //_value = [NSString string];
    //_subTrees = [NSMutableArray array];
    
    return self;
}

@end


/*
 
 use this as a model to write level data to file in xml format
 
 necessary nodes:
    tileset info
    format:
 //i guess we need this? lol
 <?xml version="1.0" encoding="UTF-8"?>
    <map>
        <tilesets>
             <tileset>
                <first gid> 1 </firstgid>
                <name> testtileset3x4 </name>
             </tileset>
 
             <tileset>
             <first gid> 13 </firstgid>
             <name> grayscale3x1 </name>
             </tileset>
        </tilesets>

 
        (all tiles of the same gid have identical characteristics)
        <gid properties>
        ...
         <gid>
            <number> 3 </number> 
            <species> non-object </species>
         </gid>
 
         <gid>
            <number> 17 </number>
            <species> object </species>
         </gid>

        ...
        </gid properties>
 
 
        <tiles>
        ...
         <tile>
            <gid> 12 </gid>
            <x> 270 </x>
            <y> 300" </y>
         </tile>
 
         <tile>
         <gid> 16 </gid>
         <x> 540 </x>
         <y> 300" </y>
         </tile>
        ...
 
        </tiles>
 
   </map>
 


 
 
 
 
 
 
 
 
*/
