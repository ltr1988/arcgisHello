//
//  MyChuanKuaYueProgressModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"

@interface MyChuanKuaYueProgressModel : HttpBaseModel
@property (nonatomic,strong) NSArray *datalist; //MyChuanKuaYueProgressItem
@property (nonatomic,strong) NSString *total;
@property (nonatomic,strong) NSString *pageNo;

-(BOOL) hasMore;
@end
