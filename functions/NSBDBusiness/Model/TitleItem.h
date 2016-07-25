//
//  TitleItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TitleOnlyCell.h"

@interface TitleItem : NSObject<TitleOnlyCellViewModel>
@property (nonatomic,strong) NSString *title;
+(instancetype) itemWithTitle:(NSString *)title;
@end
