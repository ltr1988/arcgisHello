//
//  SearchSessionStateModel.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSessionStateModel.h"

@implementation SearchSessionStateModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"sessionId" :@"data.taskid"};
    
}
@end
