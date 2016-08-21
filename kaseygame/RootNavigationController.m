//
//  RootNavigationController.m
//  kaseygame
//
//  Created by John Feldcamp on 8/12/14.
//  Copyright (c) 2014 Zachary Feldcamp. All rights reserved.
//

#import "RootNavigationController.h"
#import "GameplayViewController.h"

@implementation RootNavigationController

-(BOOL)shouldAutorotate
{
    return [[self.viewControllers lastObject] shouldAutorotate];
}

-(NSUInteger)supportedInterfaceOrientations
{

    return UIInterfaceOrientationMaskLandscape;
        
    
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return [[self.viewControllers lastObject] preferredInterfaceOrientationForPresentation];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
