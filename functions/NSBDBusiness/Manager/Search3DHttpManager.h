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

-(void) request3DHeaderMANEWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
-(void) request3DHeaderCategoryWithSuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
-(void) request3DModelWithObjectnum:(NSString *)objectnum SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;

-(void) request3DShenMaiWithX:(CGFloat)x y:(CGFloat)y SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
-(void) request3DModelWithKey:(NSString *)key mane:(NSString *)mane category:(NSString *)category SuccessCallback:(HttpSuccessCallback) success failCallback:(HttpFailCallback) fail;
@end
