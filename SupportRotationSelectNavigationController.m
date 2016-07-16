//
//  SupportRotationSelectNavigationController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectNavigationController.h"

@implementation SupportRotationSelectNavigationController

- (BOOL)shouldAutorotate
{
    id currentViewController = self.topViewController;
    
    if ([currentViewController respondsToSelector:@selector(supportRotation)])
        return [currentViewController supportRotation];
    else
        return YES;
}

@end
