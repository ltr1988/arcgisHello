//
//  Search3DHttpManager.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"

@interface Search3DHttpManager : NSObject
+(instancetype) sharedManager;

-(void) request3DHeaderWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
