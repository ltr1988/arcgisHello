//
//  BDReverseGeoItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/6/24.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "GDReverseGeoItem.h"

@implementation GDReverseGeoItem
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"formatted_address":@"regeocode.formatted_address",
             @"district":@"regeocode.addressComponent.district",
             @"street":@"regeocode.addressComponent.streetNumber.street",
             @"number":@"regeocode.addressComponent.streetNumber.number",
             @"township":@"regeocode.addressComponent.township",};
}


-(NSString *) shortAddress
{
    if (self.formatted_address.length>12) {
        NSRange range = [self.formatted_address rangeOfString:self.district];
        if (range.length!=0){
            NSString *shortStr = [self.formatted_address substringFromIndex:range.location];
            if (shortStr.length>12) {
                return shortStr = [self.formatted_address substringFromIndex:range.location+range.length];
            }else
            {
                return shortStr;
            }
            
        }
        
        return [NSString stringWithFormat:@"%@%@%@",
                self.district?:@"",
                self.street?:@"",
                self.number?:@""];
    }
    return self.formatted_address;
}
@end


@implementation GDConvertLocationItem
+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"locations":@"locations"};
}


-(CLLocationCoordinate2D) location2D
{
    CLLocationCoordinate2D coordinate;
    coordinate.latitude = 0;
    coordinate.longitude = 0;
    
    if (self.locations) {
        NSArray *array = [self.locations componentsSeparatedByString:@","];
        if (array.count>1) {
            coordinate.longitude = [array[0] floatValue];
            coordinate.latitude = [array[1] floatValue];
        }
    }
    return coordinate;
}
@end
