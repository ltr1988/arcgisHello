//
//  AuthorizeManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HttpManager.h"

typedef NS_ENUM(NSInteger,NSBD_Department)
{
    DepartmentDaNingGuanLiChu,
    DepartmentDongGanQu,
    DepartmentNanGanQu,
    DepartmentDaNingXuTiaoShuiKu,
};


@interface AuthorizeManager : NSObject
+(instancetype) sharedInstance;

-(void) requestLoginWithUser:(NSString *)user password:(NSString *)psw callback:(InfoCallback) callback;

-(void) requestBindDeviceWithCallback:(InfoCallback) callback;

@property (nonatomic,strong) NSString *userName; //set method will save name into disk too
@property (nonatomic,strong) NSString *userPsw;
@property (nonatomic,strong) NSString *userid;
@property (nonatomic,strong) NSString *token;
@end
