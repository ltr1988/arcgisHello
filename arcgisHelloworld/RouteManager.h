//
//  RouteManager.h
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RouteManager : NSObject
+(instancetype) sharedInstance;

@property (nonatomic,assign) Point *startPoint;
@property (nonatomic,assign) Point *endPoint;
@end
