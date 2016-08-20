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
@end
