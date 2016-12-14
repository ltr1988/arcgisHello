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

-(NSDictionary *) requestCache;
-(void) requestHeaderDataWithSuccess:(void (^)(Search3DHeaderModel * model)) success fail:(void (^)()) fail;

@end

typedef struct Home3DDataInfoKeysGroup {
    __unsafe_unretained NSString *mane;   
    __unsafe_unretained NSString *category;
} Home3DDataInfoKeysGroup;

extern const struct Home3DDataInfoKeysGroup Home3DDataInfoKeys;
