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
                SearchSheetInfoItem *item = [[SearchSheetInfoItem alloc] initWithKey:key style:dict[key]];
                [array addObject:item];
            }
        }
        NSArray *resultArray = [array sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            SearchSheetInfoItem *item1 = obj1;
            SearchSheetInfoItem *item2 = obj2;
            NSNumber *number1 = @(item1.order);
            NSNumber *number2 = @(item2.order);
            
            NSComparisonResult result = [number1 compare:number2];
            
            return result == NSOrderedDescending; // 升序
            //        return result == NSOrderedAscending;  // 降序
        }];
        //sort array
        
        self.items = resultArray;
    }
    return self;
}


- (NSComparisonResult)compare: (SearchSheetInfoItem *)item
{
    SearchSheetInfoItem *tempItem = (SearchSheetInfoItem *)self;
    
    NSComparisonResult result = [@(tempItem.order) compare:@(item.order)];
    
    return result == NSOrderedDescending; // 升序
    //    return result == NSOrderedAscending;  // 降序
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
