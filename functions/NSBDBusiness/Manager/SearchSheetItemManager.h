//
//  SearchSheetItemManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/27.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class NSBDBaseUIItem;
@interface SearchSheetItemManager : NSObject
+(void) addSearchSheetItem:(NSBDBaseUIItem *)item withCode:(NSString *)code fcode:(NSString *)fcode;
+(NSBDBaseUIItem *) getSearchSheetItemWithCode:(NSString *)code fcode:(NSString *)fcode taskid:(NSString *)taskid;
+(void) removeSearchSheetItemWithCode:(NSString *)code fcode:(NSString *)fcode taskid:(NSString *)taskid;
@end
