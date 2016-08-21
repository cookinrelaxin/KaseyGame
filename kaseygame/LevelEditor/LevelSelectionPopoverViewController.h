//
//  LevelSelectionPopoverViewController.h
//  kaseygame
//
//  Created by John Feldcamp on 8/14/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LevelEditorViewController.h"

@interface LevelSelectionPopoverViewController : UITableViewController
@property (nonatomic) NSArray* levelNames;
@property (nonatomic) NSString* levelToLoad;
@property (nonatomic) LevelEditorViewController* senderViewController;


@end
