//
//  Home3DDataSource.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Search3DHeaderModel.h"

@interface Home3DDataSource : NSObject

-(Search3DHeaderModel *) requestCache;
-(void) requestHeaderDataWithSuccess:(void (^)(Search3DHeaderModel * model)) success fail:(void (^)()) fail;

@end
