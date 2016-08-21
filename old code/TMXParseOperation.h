//
//  TMXParseOperation.h
//  TileMapADTtest
//
//  Created by John Feldcamp on 6/21/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "GameplayScene.h"
#import "Tilemap.h"

//@class Tilemap;

@interface TMXParseOperation : NSObject <NSXMLParserDelegate>

- (BOOL)parseDocumentWithURL:(NSURL *)url;

@property Tilemap *currentTilemap;


@end
