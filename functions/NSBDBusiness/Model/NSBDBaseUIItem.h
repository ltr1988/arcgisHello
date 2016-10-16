//
//  NSBDBaseUIItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseTitleCell.h"

@class UploadAttachmentModel;

typedef NS_ENUM(NSUInteger, SheetUIStyle)
{
    SheetUIStyle_ReadonlyText,
    SheetUIStyle_ShortText, //TitleDetailCell
    SheetUIStyle_Text,     //vc
    SheetUIStyle_Switch, // CheckableTitleCell    SheetUIStyle_ImageAndVideo, //EventMediaPickerView
    SheetUIStyle_Date,
};

@protocol TitleOnlyCellViewModel;

@interface NSBDBaseUIItem : NSObject<NSCoding,TitleOnlyCellViewModel>
{
    NSString *_title;
}
@property (strong,nonatomic) NSString *itemId;//uuid for request
@property (strong,nonatomic) NSString *taskid;
@property (strong,nonatomic) UploadAttachmentModel *attachModel;

@property (strong,nonatomic) NSArray *infolist; //list of SearchSheetGroupItem
@property (strong,nonatomic) NSString *title;

-(NSArray *)defaultUIStyleMapping; //UI布局
-(NSDictionary *)defaultUITextMapping; //UI布局

-(NSDictionary *)requestInfo; //协议输出
-(NSString *)actionKey; //协议key

-(void) setInfoArray:(NSArray *) array;//协议query 获取信息
+(instancetype) defaultItem;

-(BOOL) isLine;
@end
