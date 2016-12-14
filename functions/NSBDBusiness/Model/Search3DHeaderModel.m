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

-(NSArray *) stringArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (Search3DHeaderItem *item in self.datalist) {
        [array addObject: item.keyword];
    }
    return [array copy];
}
@end

@implementation Search3DHeaderMANEModel


+(instancetype) mockModel
{
    Search3DMANEHeaderItem * item1 = [[Search3DMANEHeaderItem alloc] init];
    item1.keyword = @"你看着很瞎";
    Search3DMANEHeaderItem * item2 = [[Search3DMANEHeaderItem alloc] init];
    item2.keyword = @"我瞎";
    Search3DMANEHeaderItem * item3 = [[Search3DMANEHeaderItem alloc] init];
    item3.keyword = @"感觉快挂了";
    Search3DMANEHeaderItem * item4 = [[Search3DMANEHeaderItem alloc] init];
    item4.keyword = @"真心扛不住了";
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
    item1.keyword = @"分水口";
    Search3DCategoryHeaderItem * item2 = [[Search3DCategoryHeaderItem alloc] init];
    item2.keyword = @"泵站";
    Search3DCategoryHeaderItem * item3 = [[Search3DCategoryHeaderItem alloc] init];
    item3.keyword = @"稀里哗啦一通字";
    Search3DCategoryHeaderItem * item4 = [[Search3DCategoryHeaderItem alloc] init];
    item4.keyword = @"鼓励挂啦啦啦啦";
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


