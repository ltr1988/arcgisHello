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
@end
