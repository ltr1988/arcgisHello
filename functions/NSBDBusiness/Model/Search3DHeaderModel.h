//
//  Search3DHeaderModel.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "HttpBaseModel.h"

@interface Search3DHeaderModel : NSObject
@property (nonatomic,strong) NSArray *datalist;

+(instancetype) mockModel;
@end

@interface Search3DHeaderMANEModel : Search3DHeaderModel
@end

@interface Search3DHeaderCategoryModel : Search3DHeaderModel
@end
