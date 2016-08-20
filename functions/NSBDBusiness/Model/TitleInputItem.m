//
//  TitleInputItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleInputItem.h"


@implementation TitleInputItem
+(instancetype) itemWithTitle:(NSString *)title placeholder:(NSString *)placeholder
{
    TitleInputItem *item = [TitleInputItem new];
    item.title = title;
    item.detail = @"";
    item.placeholder = placeholder;
    return item;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"_title"];
    [aCoder encodeObject:self.detail forKey:@"_detail"];
    
    [aCoder encodeObject:_placeholder forKey:@"_placeholder"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
        self.detail = [aDecoder decodeObjectForKey:@"_detail"];
        _placeholder = [aDecoder decodeObjectForKey:@"_placeholder"];
    }
    
    return self;
}
@end

