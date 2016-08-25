//
//  TitleDateItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleDateItem.h"


@implementation TitleDateItem
-(NSString *) detail
{
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *str=[outputFormatter stringFromDate:_date];
    return str;
}

+(instancetype) itemWithTitle:(NSString *)title
{
    TitleDateItem *item = [TitleDateItem new];
    item.title = title;
    item.date = [NSDate date];
    return item;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"_title"];
    [aCoder encodeObject:_date forKey:@"_date"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
        _date = [aDecoder decodeObjectForKey:@"_date"];
    }
    
    return self;
}
@end
