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
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "NSString+UUID.h"
#import "BaseTitleCell.h"

@implementation NSBDBaseUIItem


-(BOOL) isLine
{
    return NO;
}


-(NSDictionary *)requestInfo
{
    return nil;
}

-(NSArray *)defaultUIStyleMapping
{
    return nil;
}

-(NSDictionary *)defaultUITextMapping
{
    return nil;
}

-(NSString *) actionKey
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
        _infolist = [array copy];
        _itemId = [NSString stringWithUUID];
        _taskid = [SearchSessionManager sharedManager].session.sessionId;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.itemId forKey:@"itemId"];
    [aCoder encodeObject:self.taskid forKey:@"taskid"];
    [aCoder encodeObject:self.infolist forKey:@"infolist"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.itemId = [aDecoder decodeObjectForKey:@"itemId"];
        self.taskid = [aDecoder decodeObjectForKey:@"taskid"];
        self.infolist = [aDecoder decodeObjectForKey:@"infolist"];
    }
    
    return self;
}
@end
