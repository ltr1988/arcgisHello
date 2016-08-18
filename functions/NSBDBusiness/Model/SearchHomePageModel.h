//
//  SearchHomePageModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AuthorizeManager.h"

@interface SearchHomePageModel : NSObject

@property (nonatomic,strong) NSArray *datalist;
@property (nonatomic,strong) NSString *name;

+(instancetype) modelForDepartment:(NSBD_Department) department;
@end
