//
//  SearchSheetInfoItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSBDBaseUIItem.h"
#import "TitleItem.h"

@interface SearchSheetInfoItem : NSObject<NSCoding>

@property (nonatomic,strong) TitleItem *data;
@property (nonatomic,copy) NSString *key;       //@"taskid",
@property (nonatomic,assign) SheetUIStyle uiStyle;
@property (nonatomic,assign) NSInteger order;
-(void) setTitle:(NSString *)title;
-(void) setDetail:(NSString *)detail;
-(instancetype) initWithKey:(NSString *) key style:(NSArray *)styleArray;
-(instancetype) initWithKey:(NSString *) key uiStyle:(SheetUIStyle) style data:(TitleItem *)item;
@end
