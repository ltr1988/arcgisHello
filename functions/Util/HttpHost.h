//
//  HttpHost.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpHost : NSObject

+(NSMutableDictionary *) paramWithAction:(NSString *)action method:(NSString *)method req:(NSDictionary *) req;

+(NSString *) weatherURL;

//host A
+(NSString *) hostAURL;
+(NSString *) hostAURLWithParam:(NSDictionary *)dict;

//host 3d
+(NSString *) host3DURL;
+(NSString *) host3DURLWithType:(NSString *)type;
@end
