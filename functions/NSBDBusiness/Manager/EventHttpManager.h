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

-(void) requestNewEvent:(EventReportModel *)model successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

-(void) requestUploadAttachment:(UIImage *)image fkid:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

-(void) requestUploadAttachmentMovie:(NSURL *)movieURL fkid:(NSString *)fkid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
