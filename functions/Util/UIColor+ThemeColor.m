//
//  UIColor+ThemeColor.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "UIColor+ThemeColor.h"
#import "CommonDefine.h"

@implementation UIColor (ThemeColor)
+(UIColor *) borderColor
{
    return UI_COLOR(0xe3, 0xe4, 0xe6);
}

+(UIColor *) themeLightBlackColor
{
    return UI_COLOR(76, 77, 78);
}

+(UIColor *) seperatorColor
{
    return UI_COLOR(0xf0, 0xf1, 0xf2);
}

+(UIColor *) themeGrayBackgroundColor
{
    return UI_COLOR(0xfa, 0xfb, 0xfc);
}

+(UIColor *) backGroundGrayColor
{
    return UI_COLOR(231,232,234);
}

+(UIColor *) themeBlueColor
{
    return UI_COLOR(26, 117, 237);
}

+(UIColor *) themeLightBlueColor
{
    return UI_COLOR(61, 147, 253);
}

+(UIColor *) themeDarkBlackColor
{
    return UI_COLOR(32, 41, 50);
}

+(UIColor *) themeGrayTextColor
{
    return UI_COLOR(110, 110, 110);
}
@end
