//
//  MyEventListModel.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"

@interface MyEventListModel : HttpBaseModel
@property (nonatomic,strong) NSArray *datalist;
@property (nonatomic,strong) NSString *total;
@property (nonatomic,strong) NSString *pageNo;

-(BOOL) hasMore;
@end
