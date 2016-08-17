//
//  TokenManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TokenManager : NSObject
@property (nonatomic,strong) NSString *deviceToken;
+(instancetype) sharedManager;
-(void) registerForRemoteNotifications;
@end
