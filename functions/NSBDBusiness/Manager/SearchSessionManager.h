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

@interface SearchSessionManager : NSObject
@property (nonatomic,strong) NSString *sessionId;

+(instancetype) sharedManager;

-(BOOL) hasSession;
-(void) setSessionId:(NSString *)sid;
-(void) requestNewSearchSessionWithSearchStartModel:(SearchStartModel*) model successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

-(void) requestEndSearchSessionWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
