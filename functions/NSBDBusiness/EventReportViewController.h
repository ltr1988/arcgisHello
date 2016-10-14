//
//  EmergencyReportViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "EventMediaPickerView.h"
#import "DatePickViewController.h"

#import "EventReportModel.h"
#import "MediaPickerManager.h"

@interface EventReportViewController : SupportRotationSelectBaseViewController
{
    //下拉菜单
    UIActionSheet *myActionSheetPic;
    UIActionSheet *myActionSheetVideo;
    
    MediaPickerManager *mPickerManager;
    MPMoviePlayerViewController *_mvPlayer;
}

@property (nonatomic,strong) EventMediaPickerView *mPicker;

@property (nonatomic,strong) EventReportModel *model;
@property (nonatomic,assign) BOOL readonly;

-(instancetype) initWithModel:(EventReportModel *) model;
@end
