//
//  MyEventDetailViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@class EventMediaPickerView;
@class FeedbackModel;

@interface MyEventDetailViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate>
{
    //下拉菜单
    UIActionSheet *myActionSheetPic;
    UIActionSheet *myActionSheetVideo;
    EventMediaPickerView *mPicker;
}
@property (nonatomic,strong) UITableView *feedbackTableView;
@property (nonatomic,strong) UITableView *historyTableView;
@property (nonatomic,strong) FeedbackModel *feedbackModel;
@property (nonatomic,strong) NSArray *historyModel;


@end
