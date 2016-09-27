//
//  TitleDetailItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleDetailItem.h"

@implementation TitleDetailItem
+(instancetype) itemWithTitle:(NSString *)title detail:(NSString *)detail
{
    TitleDetailItem *item = [TitleDetailItem new];
    item.title = title;
    item.detail = detail;
    return item;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"_title"];
    [aCoder encodeObject:_detail forKey:@"_detail"];

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
        _detail = [aDecoder decodeObjectForKey:@"_detail"];
    }
    
    return self;
}

-(NSString *)value
{
    return _detail;
}

@end





