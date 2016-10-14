//
//  EventReportViewController+pickMedia.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportViewController.h"
#import "EventMediaPickerView.h"

@interface EventReportViewController (pickMedia)
-(void)openPicMenu;
-(void)openVideoMenu;
-(void)setupPickerManager;
-(void)mediaRemove:(NSNotification *)noti;
-(void)play:(NSURL *)videoUrl;
@end
