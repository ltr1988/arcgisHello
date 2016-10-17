//
//  MyDealedEventDetailListModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"
#import "MyDealedEventDetailItem.h"

@interface MyDealedEventDetailModel : HttpBaseModel
@property (nonatomic,strong) MyDealedEventDetailItem *dataItem;
@end
