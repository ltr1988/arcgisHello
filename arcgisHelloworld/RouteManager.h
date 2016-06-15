//
//  RouteManager.h
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  datashare space for picking lat/lon from map
 */
@interface RouteManager : NSObject
+(instancetype) sharedInstance;

@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint endPoint;

@property (nonatomic,copy) NSString *startText;
@property (nonatomic,copy) NSString *endText;

@property (nonatomic,assign) BOOL pickingStartPoint;
@property (nonatomic,assign) BOOL pickingEndPoint;

-(void) setPoint:(CGPoint) value;
@end
