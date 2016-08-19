//
//  LoginModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"
#import "LoginItem.h"

@interface LoginModel : HttpBaseModel

@property(nonatomic,strong) LoginItem *loginInfo;
@end
