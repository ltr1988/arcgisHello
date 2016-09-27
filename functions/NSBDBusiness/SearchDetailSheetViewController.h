//
//  SearchDetailSheetViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@class NSBDBaseUIItem;
@interface SearchDetailSheetViewController : SupportRotationSelectBaseViewController<UITableViewDelegate,UITableViewDataSource>

+(instancetype) sheetReadOnlyWithUIItem:(NSBDBaseUIItem *)item;
+(instancetype) sheetEditableWithUIItem:(NSBDBaseUIItem *)item;

@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *fcode;
@end
