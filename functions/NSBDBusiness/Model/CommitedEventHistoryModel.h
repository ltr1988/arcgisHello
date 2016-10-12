//
//  MyEventHistoryModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"

@interface CommitedEventHistoryModel : HttpBaseModel
@property (nonatomic,strong) NSArray *datalist;
@property (nonatomic,strong) NSString *total;
@property (nonatomic,strong) NSString *pageNo;
@end
