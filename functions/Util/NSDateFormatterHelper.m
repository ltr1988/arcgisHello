//
//  NSDateFormatterHelper.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/17.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "NSDateFormatterHelper.h"

@interface NSDateFormatterHelper()
@property (nonatomic,strong) NSMutableDictionary *formatterDict;
@end
@implementation NSDateFormatterHelper
+(instancetype) sharedInstance
{
    static NSDateFormatterHelper *helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[NSDateFormatterHelper alloc] init];
    });
    return helper;
}

-(NSMutableDictionary *) formatterDict
{
    if (!_formatterDict) {
        _formatterDict = [NSMutableDictionary dictionary];
    }
    return _formatterDict;
}

-(NSDateFormatter *) formatterWithFormat:(NSString *)format
{
    if (!self.formatterDict[format]) {
        @synchronized (self) {
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            
            [formater setDateFormat:format];
            self.formatterDict[format] = formater;
        }
    }
    return self.formatterDict[format];
}
@end
