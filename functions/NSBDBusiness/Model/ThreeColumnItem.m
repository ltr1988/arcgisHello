//
//  ThreeColumnItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ThreeColumnItem.h"
#import "ThreeColumnView.h"

@interface ThreeColumnItem()

@end

@implementation ThreeColumnItem


@end


@implementation ThreeColumnColorItem

-(UIColor *)firstColumnColor
{
    if (!_firstColumnColor) {
        _firstColumnColor = [UIColor blackColor];
    }
    return _firstColumnColor;
}


-(UIColor *)secondColumnColor
{
    if (!_secondColumnColor) {
        _secondColumnColor = [UIColor blackColor];
    }
    return _secondColumnColor;
}

-(UIColor *)thirdColumnColor
{
    if (!_thirdColumnColor) {
        _thirdColumnColor = [UIColor blackColor];
    }
    return _thirdColumnColor;
}
@end
