//
//  WeatherManager.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/8/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeatherManager : NSObject

+(instancetype) sharedInstance;

-(void) requestData;
@property (nonatomic,strong) NSString *weather;
@property (nonatomic,strong) NSString *date;
@end
