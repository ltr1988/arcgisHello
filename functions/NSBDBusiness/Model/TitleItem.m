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
@end
