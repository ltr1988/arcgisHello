//
//  Search3DShenMaiItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search3DShenMaiItem : NSObject

//duanmian:断面图名称
//milesum：桩号
//depth:埋深
@property (nonatomic,strong) NSString *duanmian;
@property (nonatomic,strong) NSString *depth;
@property (nonatomic,strong) NSString *milesum;

-(NSString *)imageUrl;
@end
