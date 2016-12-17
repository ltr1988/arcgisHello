//
//  LoginModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"

@interface LoginModel : HttpBaseModel

@property(nonatomic,strong) NSString *token;
@property(nonatomic,strong) NSString *userid;

@end
