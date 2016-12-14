//
//  Search3DHeaderItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/12/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search3DHeaderItem : NSObject
@property (nonatomic,strong) NSString *keyword;
@property (nonatomic,strong) NSString *number;
@end


@interface Search3DMANEHeaderItem : Search3DHeaderItem

@end

@interface Search3DCategoryHeaderItem : Search3DHeaderItem
@end
