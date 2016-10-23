//
//  FacilityInfoItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacilityInfoItem : NSObject

@property (nonatomic,strong) NSDictionary *info;

@property (nonatomic,strong) NSArray *orderedKeyIds;
-(instancetype) initWithArray:(NSArray *)infoArray;
@end
