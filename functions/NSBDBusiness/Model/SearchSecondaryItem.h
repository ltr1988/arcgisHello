//
//  SearchSecondaryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/15.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SearchSecondaryType) {
    
    SearchSecondaryType_Text,
    SearchSecondaryType_Confirm,
    SearchSecondaryType_Image,
    
};


@interface SearchSecondaryItem : NSObject
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) id detail;
@property (nonatomic,assign) SearchSecondaryType type;
@end
