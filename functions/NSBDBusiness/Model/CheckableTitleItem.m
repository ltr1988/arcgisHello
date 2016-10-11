//
//  CheckableTitleItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "CheckableTitleItem.h"

@implementation CheckableTitleItem
+(instancetype) itemWithTitle:(NSString *)title checked:(BOOL)checked
{
    CheckableTitleItem *item = [CheckableTitleItem new];
    item.title = title;
    item.checked = checked;
    return item;
}

-(NSString *)value
{
    return _checked?@"1":@"0";
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"_title"];
    [aCoder encodeBool:_checked forKey:@"_checked"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
        _checked = [aDecoder decodeBoolForKey:@"_checked"];
    }
    
    return self;
}
@end
