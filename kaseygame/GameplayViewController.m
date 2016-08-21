//
//  GameplayViewController.m
//  kaseygame
//
//  Created by John Feldcamp on 8/12/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "GameplayViewController.h"

@implementation GameplayViewController{
    
    BOOL initialTouchLocationAtRightEdgeOfScreen;
    SKView* gameplayView;
    UIView* inGameMenuView;

}
- (void)viewWillLayoutSubviews
{
 
        gameplayView = (SKView *)self.view;
        [super viewWillLayoutSubviews];
        if (!gameplayView.scene) {
        
            gameplayView.showsFPS = YES;
            gameplayView.showsNodeCount = YES;
            gameplayView.multipleTouchEnabled = YES;
            
                
           GameplayScene* gameplayScene = [GameplayScene sceneWithSize:gameplayView.bounds.size];
            gameplayScene.scaleMode = SKSceneScaleModeResizeFill;
            
            [gameplayView presentScene:gameplayScene];
            
            inGameMenuView = [self.view viewWithTag:101];
            [self.view addSubview:inGameMenuView];
            inGameMenuView.hidden = true;
            
            
    }
    
    
}


- (IBAction)buttonPressed:(UIButton *)sender
{
    
    if ((sender = _returnToGameButton)) {
        //inGameMenuView.hidden = true;
        [UIView transitionWithView:gameplayView duration:.1 options:UIViewAnimationOptionTransitionCrossDissolve  animations:^{
            
        } completion:^(BOOL finished){inGameMenuView.hidden = true;
        }];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
        UITouch * touch = [touches anyObject];
    
        CGPoint touchLocation = [touch locationInView:self.view];

        if (touchLocation.x < (self.view.bounds.size.width - 10)) {
            return;
        }
        else {
            initialTouchLocationAtRightEdgeOfScreen = true;
            
        }
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch * touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInView:self.view];
    
    if (initialTouchLocationAtRightEdgeOfScreen & (touchLocation.x < (self.view.bounds.size.width - 30))) {
        initialTouchLocationAtRightEdgeOfScreen = false;
        //inGameMenuView.hidden = false;
        
        [UIView transitionWithView:gameplayView duration:.1 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            
        } completion:^(BOOL finished){inGameMenuView.hidden = false;
        }];
    }
    
}


-(BOOL) shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeLeft;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;


 }


- (void)didReceiveMemoryWarning
{
  
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
