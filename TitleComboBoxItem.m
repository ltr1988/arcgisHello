//
//  TitleComboBoxItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2018/3/17.
//  Copyright © 2018年 fifila. All rights reserved.
//

#import "TitleComboBoxItem.h"

@implementation TitleComboBoxItem
+(instancetype) itemWithTitle:(NSString *)title dataSource:(NSArray *)dataSource;
{
    TitleComboBoxItem *item = [TitleComboBoxItem new];
    item.title = title;
    item.dataSource = dataSource;
    item.selectText = dataSource.firstObject;
    return item;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.title forKey:@"_title"];
    [aCoder encodeObject:self.selectText forKey:@"_selectText"];
    [aCoder encodeObject:self.dataSource forKey:@"_dataSource"];
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.title = [aDecoder decodeObjectForKey:@"_title"];
        self.selectText = [aDecoder decodeObjectForKey:@"_selectText"];
        self.dataSource = [aDecoder decodeObjectForKey:@"_dataSource"];
    }
    
    return self;
}

-(NSString *)value
{
    return _selectText;
}
@end
