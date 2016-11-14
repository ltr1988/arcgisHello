//
//  EventHttpManager+ChuanKuaYue.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventHttpManager.h"

@interface EventHttpManager (ChuanKuaYue)
-(void) requestQueryChuanKuaYueWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
-(void) requestQueryChuanKuaYueDetailWithID:(NSString *)theID SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
-(void) requestQueryHistoryChuanKuaYueWithPage:(NSInteger)page ID:(NSString *)theID SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
-(void) requestQueryChuanKuaYueDetailWithID:(NSString *)theID isHistory:(BOOL)isHistory SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
-(void) requestAddMyChuanKuaYueProgressListWithId:(NSString *)uuid
                                         acrossId:(NSString *)acrossId
                                       acrossName:(NSString *)acrossName
                                       acrossCode:(NSString *)acrossCode
                                          content:(NSString *)content
                                  SuccessCallback:(HttpSuccessCallback) success
                                     failCallback:(HttpFailCallback) fail;

-(void) requestQueryHistoryChuanKuaYueProgressWithPage:(NSInteger)page AcrossCode:(NSString *)acrossCode SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

-(void) requestQueryMyChuanKuaYueProgressWithPage:(NSInteger)page AcrossCode:(NSString *)acrossCode SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
