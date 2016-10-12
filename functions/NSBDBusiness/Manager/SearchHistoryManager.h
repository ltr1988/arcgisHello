//
//  SearchHistoryManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"


//管理搜索历史的本地缓存和网络请求
@interface SearchHistoryManager : NSObject

+(instancetype) sharedManager;

-(BOOL) saveCache;

//巡查历史列表
-(void) requestSearchHistoryListSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

//巡查信息查询
-(void) requestSearchHistoryQueryInfo:(id) qinfo SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
