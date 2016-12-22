//
//  SearchSessionManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/16.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"

@class SearchStartModel;
@class SearchSessionItem;
@class NSBDBaseUIItem;
@interface SearchSessionManager : NSObject
@property (nonatomic,strong) SearchSessionItem *session;

+(instancetype) sharedManager;
+(void) changeUser;

-(BOOL) hasSession;
-(void) setNewSessionWithId:(NSString *)sessionId;
-(void) requestNewSearchSessionWithSearchStartModel:(SearchStartModel*) model sessionID:(NSString *)sessionId successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

-(void) requestEndSearchSessionWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//查询
//state :0暂停 1执行中 2完成 3审核完成 4审核失败
-(void) requestChangeSearchSessionState:(NSInteger)state successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//taskconfig
-(void) requestTaskConfigInSearchSessionSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//巡查query
-(void) requestQueryListSearchSessionWithTaskId:(NSString *) taskid code:(NSString *) code action:(NSString *) action SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//历史巡查query facility
-(void) requestQueryHistoryListSearchSessionWithTaskId:(NSString *) taskid code:(NSString *) code action:(NSString *) action SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//历史巡查query line
-(void) requestQueryHistoryLineListSearchSessionWithTaskId:(NSString *) taskid code:(NSString *) code action:(NSString *) action SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//历史巡查query well
-(void) requestQueryHistoryWellSearchSessionWithTaskId:(NSString *) taskid wellnum:(NSString *) wellnum action:(NSString *) action SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//提交表单
-(void) requestUploadSheetWithItem:(NSBDBaseUIItem *) item SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//更新方位
-(void) requestUpdateLocationWithX:(double) x y:(double)y  height:(double)h successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

-(void) requestQueryTaskFinishedStatusWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
