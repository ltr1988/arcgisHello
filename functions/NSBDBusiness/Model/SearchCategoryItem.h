//
//  SearchCategoryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/25.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTitleCell.h"

@class NSBDBaseUIItem;


@interface SearchCategoryItem : NSObject
@property (nonatomic,strong) NSString *facilityCode;
@property (nonatomic,strong) NSString *itemId;
@property (nonatomic,strong) NSString *fid;
@property (nonatomic,strong) NSString *categoryId;
@property (nonatomic,strong) NSString *ftype;
@property (nonatomic,strong) NSString *fname;

@property (nonatomic,assign) NSString *timeStamp;
@property (nonatomic,strong) NSString *addUser;

@end

@interface SearchCategoryItem (TitleOnlyCellViewModel)<TitleOnlyCellViewModel>
-(NSString *) title;
@end
