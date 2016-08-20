//
//  SearchSheetInfoItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "NSBDBaseUIItem.h"
#import "TitleItem.h"

@interface SearchSheetInfoItem : NSObject

@property (nonatomic,strong) TitleItem *data;
@property (nonatomic,copy) NSString *key;       //@"taskid",
@property (nonatomic,assign) SheetUIStyle uiStyle;

-(void) setTitle:(NSString *)title;
-(instancetype) initWithKey:(NSString *)key style:(SheetUIStyle) style;
@end
