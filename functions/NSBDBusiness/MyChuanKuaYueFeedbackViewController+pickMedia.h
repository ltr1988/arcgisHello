//
//  MyChuanKuaYueFeedbackViewController+pickMedia.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueFeedbackViewController.h"
#import "ELCImagePickerController.h"
@interface MyChuanKuaYueFeedbackViewController (pickMedia)
-(void)openPicMenu;
-(void)openVideoMenu;
-(void)mediaRemove:(NSNotification *)noti;
-(void)setupPickerManager;
@end
