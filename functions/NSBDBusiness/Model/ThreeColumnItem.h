//
//  ThreeColumnItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

@protocol ThreeColumnViewDelegate;

#import <Foundation/Foundation.h>

@interface ThreeColumnItem : NSObject<ThreeColumnViewDelegate>
@property (nonatomic,copy) NSString *firstColumnText;
@property (nonatomic,copy) NSString *secondColumnText;
@property (nonatomic,copy) NSString *thirdColumnText;
@end


@interface ThreeColumnColorItem : ThreeColumnItem

@property (nonatomic,strong) UIColor *firstColumnColor;
@property (nonatomic,strong) UIColor *secondColumnColor;
@property (nonatomic,strong) UIColor *thirdColumnColor;

@end