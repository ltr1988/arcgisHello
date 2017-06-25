//
//  BDReverseGeoItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/24.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GDReverseGeoItem : NSObject
@property (nonatomic,strong) NSString *formatted_address;
@property (nonatomic,strong) NSString *district;
@property (nonatomic,strong) NSString *street;
@property (nonatomic,strong) NSString *number;
@property (nonatomic,strong) NSString *township;

-(NSString *) shortAddress;
@end

@interface GDConvertLocationItem : NSObject
@property (nonatomic,strong) NSString *locations;

-(CLLocationCoordinate2D) location2D;
@end
