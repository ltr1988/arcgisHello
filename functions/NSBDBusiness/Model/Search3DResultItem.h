//
//  Search3DResultItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/12/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Search3DResultCell.h"

@interface Search3DResultItem : NSObject<Search3DResultViewModel>
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *mane;
@property (nonatomic,strong) NSString *modelpath; //三维模型url路径
@end
