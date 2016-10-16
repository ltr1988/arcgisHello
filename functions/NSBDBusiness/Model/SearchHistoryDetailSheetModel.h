//
//  SearchHistoryDetailSheetModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"

@interface SearchHistoryDetailSheetModel : HttpBaseModel
@property (nonatomic,strong) NSArray *datalist;  //list of SearchHistoryTaskItem
@end
