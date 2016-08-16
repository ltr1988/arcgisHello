//
//  SearchSecondaryGroupItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchSecondaryGroupItem : NSObject

-(instancetype) initWithDict:(NSDictionary *)dict;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSArray *datalist;
@end
