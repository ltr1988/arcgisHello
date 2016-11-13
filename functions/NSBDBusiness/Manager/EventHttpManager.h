//
//  EventHttpManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"
@class EventReportModel;
@interface EventHttpManager : NSObject
+(instancetype) sharedManager;

//上报事件
-(void) requestNewEvent:(EventReportModel *)model successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;


//上传附件图片
-(void) requestUploadAttachment:(UIImage *)image fkid:(NSString *)fkid qxyjFlag:(BOOL) isQxyj successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//上传附件视频
-(void) requestUploadAttachmentMovie:(NSURL *)movieURL fkid:(NSString *)fkid qxyjFlag:(BOOL) isQxyj successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//查询附件
-(void) requestQueryAttachmentListWithId:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//巡查查询附件
-(void) requestQuerySearchAttachmentListWithId:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
//下载附件
-(void) requestDownloadAttachmentWithId:(NSString *)fkid qxyjFlag:(BOOL)isqxyj successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
//历史上报
-(void) requestHistoryEventWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//我的待办
-(void) requestMyEventWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//查询event进度
-(void) requestMyEventProgressListWithId:(NSString*)eid SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//添加event进度
-(void) requestAddMyEventProgressListWithId:(NSString*) eid
                                       uuid:(NSString *) uuid
                                      title:(NSString*) title
                                  disposeBy:(NSString*) disposeBy
                            SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//我的处置任务 查询
-(void) requestMyDealedEventListWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//我的处置任务详情 查询
-(void) requestMyDealedEventDetailWithId:(NSString *)eid SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

// 我的处置任务历史查询
-(void) requestMyDealedEventProgressListWithId:(NSString*) eid SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
// 我的处置任务 添加进度
-(void) requestAddMyEventProgressListWithId:(NSString*) eid
                                       uuid:(NSString *) uuid
                                    content:(NSString*) content
                            SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
