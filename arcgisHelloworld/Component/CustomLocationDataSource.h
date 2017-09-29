//
//  CustomLocationDataSource.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/9/9.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomLocationDataSource : NSObject<AGSLocationDisplayDataSource>
@property (nonatomic, weak) id<AGSLocationDisplayDataSourceDelegate> delegate;

-(void)start;

-(void)stop;

@property (nonatomic, readonly, getter = isStarted) BOOL started;

@property (nonatomic, strong, readonly) NSError *error;
@end
