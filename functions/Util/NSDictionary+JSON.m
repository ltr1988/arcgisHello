//
//  NSDictionary+JSON.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)
-(NSString *) json
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:0 error:0];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (!jsonStr) {
        jsonStr = @"";
    }
    return jsonStr;
}

//
//-(NSString *) json
//{
//    NSMutableString *jsonStr = [NSMutableString stringWithString: @"{"];
//    for (NSString *key in self.allKeys) {
//        [jsonStr appendString:[NSString stringWithFormat:@"%@:\"%@\",",key, self[key]]];
//    }
//    if ([jsonStr characterAtIndex:jsonStr.length-1] == ',') {
//        [jsonStr replaceCharactersInRange:NSMakeRange(jsonStr.length-1, 1) withString:@"}"];
//    }
//    return [jsonStr copy];
//}


+(instancetype) dictWithJson:(NSString *) json
{
    if (json == nil) {
        return nil;
    }
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData  options:NSJSONReadingMutableContainers error:&error];
    return dict;
}

+(instancetype) dictWithJsonData:(NSData *) json
{
    if (json == nil) {
        return nil;
    }
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:json  options:NSJSONReadingMutableContainers error:&error];
    return dict;
}
@end
