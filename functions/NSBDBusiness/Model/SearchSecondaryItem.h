//
//  SearchSecondaryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SearchSecondaryType) {
    SearchSecondaryType_ShortText, //TitleDetailCell
    SearchSecondaryType_Text,     //vc
    SearchSecondaryType_Confirm, // CheckableTitleCell
    SearchSecondaryType_ImageAndVideo, //EventMediaPickerView
    
};


@interface SearchSecondaryItem : NSObject

-(instancetype) initWithDict:(NSDictionary *)dict;
@property (nonatomic,strong) id item;
@property (nonatomic,assign) SearchSecondaryType type;

@end
