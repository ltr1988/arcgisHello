//
//  SearchHistoryModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"

@interface SearchHistoryModel : HttpBaseModel
@property (nonatomic,strong) NSArray *datalist;  //list of SearchHistoryTaskItem
@property (nonatomic,strong) NSString *total;
-(BOOL) hasMore;
@end
