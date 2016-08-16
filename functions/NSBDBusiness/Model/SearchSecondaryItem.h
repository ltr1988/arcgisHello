//
//  SearchSecondaryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SearchSecondaryType) {
    SearchSecondaryType_ShortText,
    SearchSecondaryType_Text,
    SearchSecondaryType_Confirm, // UISwitch
    SearchSecondaryType_ImageAndVideo, //EventMediaPickerView
    
};


@interface SearchSecondaryItem : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) id detail;
@property (nonatomic,assign) SearchSecondaryType type;
@end
