//
//  TokenManager.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TokenManager.h"

@implementation TokenManager

+(instancetype) sharedManager
{
    static TokenManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [TokenManager new];
        manager.deviceToken = @"100";
    });
    return manager;
}

-(void) registerForRemoteNotifications
{
    UIApplication *application = [UIApplication sharedApplication];
    UIUserNotificationSettings
    *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert |
                                                              UIUserNotificationTypeBadge |
                                                              UIUserNotificationTypeSound)
                                                  categories:nil];
    [application registerUserNotificationSettings:settings];
    [application registerForRemoteNotifications];
    NSLog(@"Successfully Registered for Remote Notification");
}
@end
