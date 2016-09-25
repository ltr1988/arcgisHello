//
//  NSDictionary+JSON.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (JSON)
-(NSString *) json;
+(instancetype) dictWithJson:(NSString *)json;
+(instancetype) dictWithJsonData:(NSData *) json;
@end
