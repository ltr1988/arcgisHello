//
//  EventReportViewController+pickMedia.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/28.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "EventReportViewController.h"
#import "ELCImagePickerController.h"
#import "EventMediaPickerView.h"

@interface EventReportViewController (pickMedia) <ELCImagePickerControllerDelegate>
-(void)openPicMenu;
-(void)openVideoMenu;
-(void)mediaRemove:(NSNotification *)noti;
@end
