//
//  TitleDetailTextItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleDetailTextItem.h"


@implementation TitleDetailTextItem
+(instancetype) itemWithTitle:(NSString *)title detail:(NSString *)detail text:(NSString *)text
{
    TitleDetailTextItem *item = [TitleDetailTextItem new];
    item.title = title;
    item.detail = detail;
    item.text = text;
    return item;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"_title"];
    [aCoder encodeObject:self.detail forKey:@"_detail"];
    
    [aCoder encodeObject:self.text forKey:@"_text"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
        self.detail = [aDecoder decodeObjectForKey:@"_detail"]; //未填写，已填写
        self.text = [aDecoder decodeObjectForKey:@"_text"]; //实际填写内容
    }
    
    return self;
}
@end
