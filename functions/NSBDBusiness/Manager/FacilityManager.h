//
//  FacilityManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"

@interface FacilityManager : NSObject
+(instancetype) sharedInstance;

-(void) requestFacilityWithId:(NSString *)fid successCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
