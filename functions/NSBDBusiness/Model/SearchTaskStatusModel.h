//
//  SearchStartItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpBaseModel.h"

@interface SearchTaskStatusModel : HttpBaseModel


@property (nonatomic,strong) NSString *tid;  //task id
@property (nonatomic,strong) NSString *name; //name
@property (nonatomic,strong) NSString *type; //type

@end
