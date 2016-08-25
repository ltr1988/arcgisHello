//
//  NSBDBaseUIItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSBDBaseUIItem.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
@implementation NSBDBaseUIItem

-(NSArray *)defaultUIStyleMapping
{
    return nil;
}

-(NSDictionary *)defaultUITextMapping
{
    return nil;
}


+(instancetype) defaultItem
{
    Class class = [self class];
    return [[class alloc] init];
}


-(instancetype) init
{
    self = [super init];
    if (self) {
        NSMutableArray *array = [NSMutableArray array];
        NSDictionary *textinfo = [self defaultUITextMapping]?:[NSDictionary dictionary];
        NSArray *uiStyleArray = [self defaultUIStyleMapping]?:[NSArray array];
        for (NSDictionary *style in uiStyleArray) {
            SearchSheetGroupItem *group = [[SearchSheetGroupItem alloc] initWithDict:style];
            for (SearchSheetInfoItem *item in group.items) {
                NSString *title = textinfo[item.key]?:@"";
                [item setTitle:title];
            }
            [array addObject:group];
        }
        self.infolist = [array copy];
        
    }
    return self;
}
@end