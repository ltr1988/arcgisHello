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

#define HOME3D_CACHE_PATH_MANE @"home3dCache_mane"
#define HOME3D_CACHE_PATH_CATEGORY @"home3dCache_category"

@implementation Home3DDataSource

-(NSDictionary *) requestCache
{
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    NSString *cache = [[NSString cachesPath] stringByAppendingPathComponent:HOME3D_CACHE_PATH_MANE];
    NSDictionary* dict = [NSKeyedUnarchiver unarchiveObjectWithFile:cache]?:nil;
    if (dict) {
        info[Home3DDataInfoKeys.mane] = [Search3DHeaderModel objectWithKeyValues:dict];
    }
    
    cache = [[NSString cachesPath] stringByAppendingPathComponent:HOME3D_CACHE_PATH_CATEGORY];
    dict = [NSKeyedUnarchiver unarchiveObjectWithFile:cache]?:nil;
    if (dict) {
        info[Home3DDataInfoKeys.category] = [Search3DHeaderModel objectWithKeyValues:dict];
    }
    return nil;
}

-(void) setCacheWithData:(NSDictionary *)dict path:(NSString *) path
{
    NSString *cache = [[NSString cachesPath] stringByAppendingPathComponent:path];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ( [manager fileExistsAtPath:cache])
    {
        [manager removeItemAtPath:cache error:nil];
    }
    [dict writeToFile:cache atomically:YES];
}

-(void) requestMANEHeaderDataWithSuccess:(void (^)(Search3DHeaderModel * model)) success fail:(void (^)()) fail
{
    [[Search3DHttpManager sharedManager] request3DHeaderMANEWithSuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        Search3DHeaderMANEModel * model = [Search3DHeaderMANEModel objectWithKeyValues:dict];
        if (model) {
            [self setCacheWithData:dict path:HOME3D_CACHE_PATH_MANE];
            
             success(model);
             }else
             {
                 fail();
             }
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        fail();
    }];
}

-(void) requestCategoryHeaderDataWithSuccess:(void (^)(Search3DHeaderModel * model)) success fail:(void (^)()) fail
{
    [[Search3DHttpManager sharedManager] request3DHeaderCategoryWithSuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        Search3DHeaderCategoryModel * model = [Search3DHeaderCategoryModel objectWithKeyValues:dict];
        if (model) {
            [self setCacheWithData:dict path:HOME3D_CACHE_PATH_CATEGORY];
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


const struct Home3DDataInfoKeysGroup Home3DDataInfoKeys =
(Home3DDataInfoKeysGroup) {
    .mane = @"mane",
    .category = @"category",
};
