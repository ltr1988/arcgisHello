//
//  SearchDetailSheetViewController+pickMedia.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/14.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchDetailSheetViewController.h"

@interface SearchDetailSheetViewController (pickMedia)
-(void)openPicMenu;
-(void)openVideoMenu;
-(void)setupPickerManager;
-(void)mediaRemove:(NSNotification *)noti;
@end
