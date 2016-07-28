//
//  EmergencyReportViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventReportViewController : SupportRotationSelectBaseViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    //下拉菜单
    UIActionSheet *myActionSheetPic;
    UIActionSheet *myActionSheetVideo;
    
    NSMutableArray *mediaList;
    
}
@end
