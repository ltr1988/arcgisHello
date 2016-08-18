//
//  HttpBaseItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,HttpResultStatus){
   HttpResultSuccess = 100, //成功
   HttpResultFail =  200, //失败
   HttpResultServerException =  300, //服务端异常，请联系管理员。
   HttpResultParamError =  301, //参数错误，请检查参数完整性
   HttpResultVersionError =  302, //版本号错误
   HttpResultBadAction =  303, //非法的执行语法与参数
   HttpResultInvalidUser =  304, //不合法的用户
   HttpResultBadSignature =  305, //非法的签名信息
};



@interface HttpBaseItem : NSObject
-(instancetype) initWithDict:(NSDictionary *)dict;
@property (nonatomic,assign) BOOL success;  //status == 100
@property (nonatomic,assign) NSInteger status;
@end
