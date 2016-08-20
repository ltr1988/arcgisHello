//
//  SearchDetailSheetViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
#import "NSBDBaseUIItem.h"

@interface SearchDetailSheetViewController : SupportRotationSelectBaseViewController<UITableViewDelegate,UITableViewDataSource>

+(instancetype) sheetReadOnlyWithUIItem:(NSBDBaseUIItem *)item;
+(instancetype) sheetEditableWithUIItem:(NSBDBaseUIItem *)item;

@property (nonatomic,strong) NSBDBaseUIItem *uiItem;
@end
