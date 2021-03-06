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
#import "HttpMetaData.h"
#import "UploadAttachmentModel.h"
#import "NSDateFormatterHelper.h"

@implementation NSBDBaseUIItem
@synthesize title = _title;

-(BOOL) isLine
{
    return NO;
}


-(NSDictionary *)requestInfo
{
    NSDateFormatter *formate = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter *formateDay = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd"];
    return @{
             @"type":self.type?:@"",
             @"isupload":@"0",
             @"state":@"1",
             @"exedate":[formateDay stringFromDate:[NSDate date]],
             @"createtime":[formate stringFromDate:[NSDate date]],
             @"starttime": [formate stringFromDate:[NSDate date]],
             @"source":@"iOS",};

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

-(UploadAttachmentModel *) attachModel
{
    if (!_attachModel) {
        _attachModel = [[UploadAttachmentModel alloc] init];
    }
    return _attachModel;
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
    [aCoder encodeObject:self.attachModel forKey:@"attachModel"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.itemId = [aDecoder decodeObjectForKey:@"itemId"];
        self.taskid = [aDecoder decodeObjectForKey:@"taskid"];
        self.infolist = [aDecoder decodeObjectForKey:@"infolist"];
        self.attachModel = [aDecoder decodeObjectForKey:@"attachModel"];
    }
    
    return self;
}

-(void) setInfoArray:(NSArray *) array
{
    NSDictionary *dict = [self infoDictFromArray:array];
    for (SearchSheetGroupItem *group in self.infolist) {
        for (SearchSheetInfoItem *item in group.items) {
            [item setDetail:dict[item.key.lowercaseString]];
        }
    }
    if (dict[@"id"]) {
        self.itemId = dict[@"id"];
    }
}

-(NSDictionary *) infoDictFromArray:(NSArray *)array
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:array.count];
    for (HttpMetaData *meta in array) {
        dict[meta.dataID.lowercaseString] = meta.value;
    }
    return [dict copy];
}
@end
