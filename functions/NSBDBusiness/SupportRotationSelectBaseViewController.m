//
//  NoRotationBaseViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@implementation SupportRotationSelectBaseViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
    
}

-(BOOL) hideNavBar
{
    return NO;
}

-(BOOL) supportRotation
{
    return NO;
}
@end
