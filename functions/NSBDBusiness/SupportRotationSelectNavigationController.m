//
//  SupportRotationSelectNavigationController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectNavigationController.h"

#import "UIColor+ThemeColor.h"

@implementation SupportRotationSelectNavigationController

-(void) viewDidLoad
{
    [super viewDidLoad];
    self.navigationBar.translucent = NO;
    self.delegate =self;
    
    UIColor * color = [UIColor whiteColor];
    
    //这里我们设置的是颜色，还可以设置shadow等，具体可以参见api
    NSDictionary * dict = [NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    //大功告成
    self.navigationBar.titleTextAttributes = dict;
    
    [self.navigationBar setBarTintColor :[UIColor themeLightBlueColor]];
    [self.navigationBar setTintColor:[UIColor whiteColor]];

}

- (BOOL)shouldAutorotate
{
    id currentViewController = self.topViewController;
    
    if ([currentViewController respondsToSelector:@selector(supportRotation)])
        return [currentViewController supportRotation];
    else
        return YES;
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([viewController respondsToSelector:@selector(hideNavBar)])
    {
        [self setNavigationBarHidden:[viewController performSelector:@selector(hideNavBar)] animated:YES];
    }
}


@end
