//
//  NSBDBaseUIItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef NS_ENUM(NSUInteger, SheetUIStyle)
{
    SheetUIStyle_ShortText, //TitleDetailCell
    SheetUIStyle_Text,     //vc
    SheetUIStyle_Switch, // CheckableTitleCell    SheetUIStyle_ImageAndVideo, //EventMediaPickerView

};


@interface NSBDBaseUIItem : NSObject
@property (strong,nonatomic) NSArray *infolist;
-(NSArray *)defaultUIStyleMapping; //UI布局
-(NSDictionary *)defaultUITextMapping; //UI布局
+(instancetype) defaultItem;
@end
