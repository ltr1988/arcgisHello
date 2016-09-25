//
//  SearchCategoryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/8/21.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchHomePageItem : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *code;

+(NSDictionary *) mappingInfo;
-(id) sheetItem;
@end
