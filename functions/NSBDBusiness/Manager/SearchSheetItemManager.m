//
//  SearchSheetItemManager.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/27.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSheetItemManager.h"
#import "AuthorizeManager.h"
#import "NSBDBaseUIItem.h"

#define SEARCH_SHEET_ITEM(task,code,fcode)  [NSString stringWithFormat:@"SearchSheetItem_%@_%@_%@_%@",[[AuthorizeManager sharedInstance] userName],task,code,fcode]


#define SEARCH_LINE_LIST(task,code)  [NSString stringWithFormat:@"SearchSheetItem_%@_%@_%@",[[AuthorizeManager sharedInstance] userName],task,code]

@implementation SearchSheetItemManager
+(void) addSearchSheetItem:(NSBDBaseUIItem *)item withCode:(NSString *)code fcode:(NSString *)fcode
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:item];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:SEARCH_SHEET_ITEM(item.taskid,code,fcode)];
}

+(NSBDBaseUIItem *) getSearchSheetItemWithCode:(NSString *)code fcode:(NSString *)fcode taskid:(NSString *)taskid{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_SHEET_ITEM(taskid,code,fcode)];
    if (!data) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+(void) removeSearchSheetItemWithCode:(NSString *)code fcode:(NSString *)fcode taskid:(NSString *)taskid{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:SEARCH_SHEET_ITEM(taskid,code,fcode)];
}

+(void) addSearchLineItem:(NSBDBaseUIItem *)item withCode:(NSString *)code
{
    NSMutableArray *list = [self getSearchLineListWithCode:code taskid:item.taskid];
    if (!list) {
        list = [NSMutableArray array];
    }
    [list addObject:item];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:list];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:SEARCH_LINE_LIST(item.taskid,code)];
    
}

+(NSMutableArray *) getSearchLineListWithCode:(NSString *)code taskid:(NSString *)taskid{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:SEARCH_LINE_LIST(taskid,code)];
    if (!data) {
        return nil;
    }
    return [[NSKeyedUnarchiver unarchiveObjectWithData:data] mutableCopy];
}

+(NSBDBaseUIItem *) getSearchLineItemWithUUID:(NSString *)uuid code:(NSString *)code taskid:(NSString *)taskid{
    
    NSMutableArray *list = [self getSearchLineListWithCode:code taskid:taskid];
    if (!list) {
        return nil;
    }
    for (NSBDBaseUIItem *item in list) {
        if ([item.itemId isEqualToString:uuid]) {
            return item;
        }
    }
    return nil;
}

+(void) removeSearchLineItemWithWithUUID:(NSString *)uuid code:(NSString *)code taskid:(NSString *)taskid{
    NSMutableArray *list = [self getSearchLineListWithCode:code taskid:taskid];
    if (!list) {
        return;
    }
    NSBDBaseUIItem *itemToBeDel = nil;
    for (NSBDBaseUIItem *item in list) {
        if ([item.itemId isEqualToString:uuid]) {
            itemToBeDel = item;
            break;
        }
    }
    if (itemToBeDel) {
        [list removeObject:itemToBeDel];
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:list];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:SEARCH_LINE_LIST(taskid,code)];
}
@end
