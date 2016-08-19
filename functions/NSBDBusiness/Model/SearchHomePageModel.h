//
//  SearchHomePageModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorizeManager.h"
#import "HttpBaseModel.h"

@interface SearchHomePageModel : HttpBaseModel

@property (nonatomic,strong) NSArray *datalist;

@end
