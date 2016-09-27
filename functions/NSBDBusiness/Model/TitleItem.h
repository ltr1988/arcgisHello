//
//  TitleItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTitleCell.h"

@interface TitleItem : NSObject<TitleOnlyCellViewModel,NSCoding>
@property (nonatomic,strong) NSString *title;
+(instancetype) itemWithTitle:(NSString *)title;
@end
