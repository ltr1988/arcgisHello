//
//  Home3DDataSource.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Home3DDataSource.h"
#import "NSString+LVPath.h"
#import "MJExtension.h"
#import "Search3DHttpManager.h"

#define HOME3D_CACHE_PATH @"home3dCache"

@implementation Home3DDataSource

-(Search3DHeaderModel *) requestCache
{
    NSString *cache = [[NSString cachesPath] stringByAppendingPathComponent:HOME3D_CACHE_PATH];
    NSDictionary* dict = [NSKeyedUnarchiver unarchiveObjectWithFile:cache]?:nil;
    if (dict) {
        return [Search3DHeaderModel objectWithKeyValues:dict];
    }
    return nil;
}

-(void) setCacheWithData:(NSDictionary *)dict
{
    NSString *cache = [[NSString cachesPath] stringByAppendingPathComponent:HOME3D_CACHE_PATH];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ( [manager fileExistsAtPath:cache])
    {
        [manager removeItemAtPath:cache error:nil];
    }
    [dict writeToFile:cache atomically:YES];
}

-(void) requestHeaderDataWithSuccess:(void (^)(Search3DHeaderModel * model)) success fail:(void (^)()) fail
{
    [[Search3DHttpManager sharedManager] request3DHeaderWithSuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        Search3DHeaderModel * model = [Search3DHeaderModel objectWithKeyValues:dict];
        if (model.success) {
            [self setCacheWithData:dict];
            success(model);
        }else
        {
            fail();
        }
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        fail();
    }];
}
@end
