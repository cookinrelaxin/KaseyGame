//
//  TreeModel.h
//  kaseygame
//
//  Created by John Feldcamp on 8/21/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tree : NSObject
@property (nonatomic) NSString* name;
@property (nonatomic) NSString* value;
@property (nonatomic) NSMutableArray* subTrees;

//- (void)addChild;
//-(BOOL)isLeaf;
//-(BOOL)isEmptyTree;


@end
