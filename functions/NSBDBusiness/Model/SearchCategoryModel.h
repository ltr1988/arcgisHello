//
//  SearchCategoryModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"

@class NSBDBaseUIItem;
@interface SearchCategoryModel : HttpBaseModel
@property (nonatomic,strong) NSArray *datalist;
//NSBDBaseUIItem for line
@property (nonatomic,strong) NSBDBaseUIItem *uiItem;
@end
