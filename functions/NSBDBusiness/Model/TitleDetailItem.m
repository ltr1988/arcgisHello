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



@end



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
        self.detail = [aDecoder decodeObjectForKey:@"_detail"];
        self.text = [aDecoder decodeObjectForKey:@"_text"];
    }
    
    return self;
}
@end
