//
//  Search3DHeaderModel.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "Search3DHeaderModel.h"
#import "Search3DHeaderItem.h"

@implementation Search3DHeaderModel

+(instancetype) mockModel
{return nil;}

@end

@implementation Search3DHeaderMANEModel


+(instancetype) mockModel
{
    Search3DMANEHeaderItem * item1 = [[Search3DMANEHeaderItem alloc] init];
    item1.keyword = @"abc";
    Search3DMANEHeaderItem * item2 = [[Search3DMANEHeaderItem alloc] init];
    item2.keyword = @"badsfasdf";
    Search3DMANEHeaderItem * item3 = [[Search3DMANEHeaderItem alloc] init];
    item3.keyword = @"wwwwwwc";
    Search3DMANEHeaderItem * item4 = [[Search3DMANEHeaderItem alloc] init];
    item4.keyword = @"ddd dsa fd";
    Search3DHeaderMANEModel *model = [[Search3DHeaderMANEModel alloc] init];
    model.datalist = @[item1,item2,item3,item4];
    return model;
}

+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"manelist",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[Search3DMANEHeaderItem class] forKey:@"datalist"];
    return dict;
}

@end

@implementation Search3DHeaderCategoryModel

+(instancetype) mockModel
{
    Search3DCategoryHeaderItem * item1 = [[Search3DCategoryHeaderItem alloc] init];
    item1.keyword = @"abc";
    Search3DCategoryHeaderItem * item2 = [[Search3DCategoryHeaderItem alloc] init];
    item2.keyword = @"badsfasdf";
    Search3DCategoryHeaderItem * item3 = [[Search3DCategoryHeaderItem alloc] init];
    item3.keyword = @"wwwwwwc";
    Search3DCategoryHeaderItem * item4 = [[Search3DCategoryHeaderItem alloc] init];
    item4.keyword = @"ddd dsa fd";
    Search3DHeaderCategoryModel *model = [[Search3DHeaderCategoryModel alloc] init];
    model.datalist = @[item1,item2,item3,item4];
    return model;
}
+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{@"datalist" :@"objtypelist",
             };
    
}
+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[Search3DCategoryHeaderItem class] forKey:@"datalist"];
    return dict;
}

@end


