//
//  SearchAdminsModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/25.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"
#import "SearchAdminItem.h"

@interface SearchAdminsModel : HttpBaseModel
@property (nonatomic,strong) NSArray *datalist;
@end
