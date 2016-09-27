//
//  SearchSheetGroupItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSheetGroupItem.h"
@implementation SearchSheetGroupItem

/**
 *  dict example
 */
//       @{
//      @"group":@"",
//      @"wellnum":@(SheetUIStyle_ShortText),
//      @"wellname":@(SheetUIStyle_ShortText),
//      }

-(instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        NSMutableArray *array =[NSMutableArray array];
        for (NSString *key in dict) {
            if ([key isEqualToString:@"group"]) {
                _groupName = dict[key];
            }else
            {
                SearchSheetInfoItem *item = [[SearchSheetInfoItem alloc] initWithKey:key style:[dict[key] integerValue]];
                [array addObject:item];
            }
        }
        self.items = [array copy];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.groupName forKey:@"groupName"];
    [aCoder encodeObject:self.items forKey:@"items"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.groupName = [aDecoder decodeObjectForKey:@"groupName"];
        self.items = [aDecoder decodeObjectForKey:@"items"];
    }
    
    return self;
}
@end
