//
//  NSString+LVPath.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (LVPath)
#pragma mark Standard Paths

+ (NSString *)cachesPath;
+ (NSString *)documentsPath;

+ (NSString *)temporaryPath;

+ (NSString *)pathForTemporaryFile;
@end
