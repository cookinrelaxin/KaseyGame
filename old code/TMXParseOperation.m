//
//  TMXParseOperation.m
//  TileMapADTtest
//
//  Created by John Feldcamp on 6/21/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "TMXParseOperation.h"
#import "Tilemap.h"

@implementation TMXParseOperation
{
    NSString* currentTMXFile;
    NSMutableArray *currentLayerOrObjectgroup;
    
}


- (id) init{
    self = [super init];
    if (self) {
        ///
        currentLayerOrObjectgroup = [[NSMutableArray alloc] init];
        _currentTilemap = [[Tilemap alloc] init];
        _currentTilemap.tilesets = [[NSMutableArray alloc] init];
        _currentTilemap.layersAndObjectgroups= [[NSMutableArray alloc] init];
        ///
        
        
        
        ///
        _currentTilemap.name = [[NSString alloc] init];
        ///
        
        
    }
   return self;
    
}


-(BOOL)parseDocumentWithURL:(NSURL *)url {
    if (url == nil)
    {
        _currentTilemap.validTilemap = false;
        return NO;
    }
    _currentTilemap.validTilemap = true;
    
    
    // this is the parsing machine
    NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    // this class will handle the events
    [xmlparser setDelegate:self];
    [xmlparser setShouldResolveExternalEntities:NO];
    
    // now parse the document
    BOOL ok = [xmlparser parse];
    if (ok == NO)
        NSLog(@"error parsing document");
    //else
        //NSLog(@"document successfully parsed");
    
    return ok;
}

-(void)parserDidStartDocument:(NSXMLParser *)parser {
    //NSLog(@"didStartDocument");
}


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
   // NSLog(@"didStartElement: %@", elementName);
    
    if ( [elementName isEqualToString:@"map"]) {
        
        NSString *mapWidth = [attributeDict objectForKey:@"width"];
        if (mapWidth)
         {
             int value = [mapWidth intValue];
            _currentTilemap.mapwidth = value;
         }
        
        NSString *mapHeight = [attributeDict objectForKey:@"height"];
        if (mapHeight)
         {
            int value = [mapHeight intValue];
            _currentTilemap.mapheight = value;
         }
        
        NSString *tileWidth = [attributeDict objectForKey:@"tilewidth"];
        if (tileWidth)
         {
            int value = [tileWidth intValue];
//             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                 value = value * 2;
//             }
            _currentTilemap.tilewidth = value;
         }
        
        NSString *tileHeight = [attributeDict objectForKey:@"tileheight"];
        if (tileHeight)
         {
            int value = [tileHeight intValue];
//             if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//                 value = value * 2;
//             }
            _currentTilemap.tileheight = value;
         }
        
    }
    
    if ( [elementName isEqualToString:@"tileset"]) {
        
        NSString *firstgidKey = @"firstGid";
        NSString *nameKey = @"tilesetName";
        
        id firstgidObj = [attributeDict objectForKey:@"firstgid"];
        id nameObj = [attributeDict objectForKey:@"name"];

        
        NSArray* tilesetKeys = [NSArray arrayWithObjects:firstgidKey, nameKey, nil];
        NSArray* tilesetObjects = [NSArray arrayWithObjects:firstgidObj, nameObj, nil];
        
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjects:tilesetObjects forKeys:tilesetKeys];
        
        [_currentTilemap.tilesets addObject:dict];
        
        
    }
    
    if ( [elementName isEqualToString:@"layer"]) {
        
        
        currentLayerOrObjectgroup = [[NSMutableArray alloc] init];
        
        NSString *layerName = [attributeDict objectForKey:@"name"];
        [currentLayerOrObjectgroup addObject: layerName];
        
        NSString *isLayer = @"layer";
        [currentLayerOrObjectgroup addObject: isLayer];
        
         }
    
    if ( [elementName isEqualToString:@"tile"]) {
        
        NSString *gid = [attributeDict objectForKey:@"gid"];
        [currentLayerOrObjectgroup addObject: gid];
        
    }
    
    if ( [elementName isEqualToString:@"objectgroup"]) {
        
        
        currentLayerOrObjectgroup = [[NSMutableArray alloc] init];
        
        NSString *objectgroupName = [attributeDict objectForKey:@"name"];
        [currentLayerOrObjectgroup addObject: objectgroupName];
        
        NSString *isObjectgroup = @"objectgroup";
        [currentLayerOrObjectgroup addObject: isObjectgroup];
        
    }
    
    if ( [elementName isEqualToString:@"object"]) {
        NSString *xCoordinate = [attributeDict objectForKey:@"x"];
        NSString *yCoordinate = [attributeDict objectForKey:@"y"];
        NSString *gid = [attributeDict objectForKey:@"gid"];
        
        //in case the mapmaker makes some sort of mistake using a gidless tile.
        if ([gid length] == 0) {
            //gid = @"1";
            return;
        }
        
        NSDictionary *object = [NSDictionary dictionaryWithObjectsAndKeys:xCoordinate, @"x", yCoordinate, @"y", gid, @"gid", nil];
        
        [currentLayerOrObjectgroup addObject: object];
        
    }
    
    
}

    
    


-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if ( [elementName isEqualToString:@"layer"]) {
        [_currentTilemap.layersAndObjectgroups addObject:currentLayerOrObjectgroup];
    
        //NSLog(@"didEndElement: %@", elementName);
    }
    
    if ( [elementName isEqualToString:@"objectgroup"]) {
        [_currentTilemap.layersAndObjectgroups addObject:currentLayerOrObjectgroup];
        
       // NSLog(@"didEndElement: %@", elementName);
    }
    

}

// error handling
-(void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"XMLParser error: %@", [parseError localizedDescription]);
}

-(void)parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    NSLog(@"XMLParser error: %@", [validationError localizedDescription]);
}





- (NSMutableArray*) unpackTilesets: (NSMutableArray *) tilesetArray withTileSize: (NSInteger) tileSize {
    // assume tiles are square
    
    //NSLog(@"tileSize: %ld", (long)tileSize);
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        tileSize = tileSize * 2;
//    }
    
    
    NSUInteger count = [tilesetArray count];
    
    // init array with null. later make the array capacity non arbitrary to save memory
    
    NSMutableArray *arrayOfGidsAndTextures = [[NSMutableArray alloc] init];
    arrayOfGidsAndTextures = [NSMutableArray arrayWithCapacity:99];
    for (int i = 0; i <= 99; i ++){
        [arrayOfGidsAndTextures addObject:[NSNull null]];
        
    }
    
    
    NSMutableDictionary *currentTileset = [[NSMutableDictionary alloc] init];
    
    SKTexture *tsTexture = [[SKTexture alloc] init];
    
    for (int i = 0; i < count; i ++) {
        
        currentTileset = [tilesetArray objectAtIndex:i];
        NSString *tilesetName = [currentTileset objectForKey:@"tilesetName"];
        
        
        tsTexture = [SKTexture textureWithImageNamed:tilesetName];
        
        
        tsTexture.filteringMode = SKTextureFilteringNearest;
        
        long currentGid = [[currentTileset objectForKey:@"firstGid"] integerValue];
        
        float sx = 0;
        float sy = (tsTexture.size.height - tileSize);
        
        while (sy >= 0) {
            
            if (sx == tsTexture.size.width)
            {
                sx = 0;
                sy -= tileSize;
             //   currentGid --;
                
                continue;
            }
            
            //NSLog(@"currentGid: %ld", currentGid);
            //NSLog(@"sx: %f, sy: %f", sx, sy);
            
            
            
            CGRect cutter = CGRectMake ((sx / tsTexture.size.width), (sy / tsTexture.size.height), (tileSize / tsTexture.size.width), (tileSize / tsTexture.size.height));
            
            
            SKTexture *temp = [SKTexture textureWithRect:cutter inTexture:tsTexture];
            
        
            
            [arrayOfGidsAndTextures replaceObjectAtIndex:currentGid withObject:temp];
            
            //NSLog(@"arrayOfGidsAndTextures objectAtIndex:currentGid : %@", [arrayOfGidsAndTextures objectAtIndex:currentGid]);
            

            
            sx += tileSize;
            
            
            currentGid ++;
        }
        
    }
    return arrayOfGidsAndTextures;
}




-(void)parserDidEndDocument:(NSXMLParser *)parser {
    //NSLog(@"didEndDocument");

    
    _currentTilemap.tilesets = [self unpackTilesets: _currentTilemap.tilesets withTileSize: _currentTilemap.tilewidth];
    
}
    
@end
