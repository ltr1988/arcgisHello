//
//  MyEventDetailViewController+pickMedia.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/6.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyEventDetailViewController.h"
#import "ELCImagePickerController.h"

@interface MyEventDetailViewController (pickMedia)
-(void)openPicMenu;
-(void)openVideoMenu;
-(void)mediaRemove:(NSNotification *)noti;
-(void)setupPickerManager;
@end
