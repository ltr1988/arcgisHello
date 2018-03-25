//
//  TitleItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "TitleItem.h"

@implementation TitleItem
+(instancetype) itemWithTitle:(NSString *)title;
{
    TitleItem *item = [TitleItem new];
    item.title = title;
    return item;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"_title"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
    }
    
    return self;
}

-(NSString *)value
{
    return _title;
}
@end
