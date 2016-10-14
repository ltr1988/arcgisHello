//
//  SearchDetailSheetViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
#import "MediaPickerManager.h"
@class EventMediaPickerView;

@class NSBDBaseUIItem;
@interface SearchDetailSheetViewController : SupportRotationSelectBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    MediaPickerManager *mPickerManager;
}


@property (nonatomic,strong) EventMediaPickerView *mPicker;

+(instancetype) sheetReadOnlyWithUIItem:(NSBDBaseUIItem *)item;
+(instancetype) sheetEditableWithUIItem:(NSBDBaseUIItem *)item;

@property (nonatomic,strong) NSString *code;
@property (nonatomic,strong) NSString *fcode;
@property (nonatomic,strong) NSString *fname;
@end
