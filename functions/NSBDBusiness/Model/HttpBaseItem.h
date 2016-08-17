//
//  HttpBaseItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpBaseItem : NSObject
-(instancetype) initWithDict:(NSDictionary *)dict;
@property (nonatomic,assign) BOOL success;  //status == 100
@end
