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
-(void) requestUploadAttachment:(UIImage *)image fkid:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//上传附件视频
-(void) requestUploadAttachmentMovie:(NSURL *)movieURL fkid:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//历史上报
-(void) requestHistoryEventWithPage:(NSInteger)page SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
