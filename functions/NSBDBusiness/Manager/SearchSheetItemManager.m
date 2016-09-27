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
@end
