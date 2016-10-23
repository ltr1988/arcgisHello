//
//  MyEventDetailViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
#import "MediaPickerManager.h"

@class EventMediaPickerView;
@class FeedbackModel;


typedef NS_ENUM(NSInteger, MyEventDetailType) {
    MyEventDetailType_Normal,
    MyEventDetailType_Dispose,
};

@interface MyEventDetailViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    MediaPickerManager *mPickerManager;
}


@property (nonatomic,strong) EventMediaPickerView *mPicker;
@property (nonatomic,strong) UITableView *feedbackTableView;
@property (nonatomic,strong) UITableView *historyTableView;
@property (nonatomic,strong) FeedbackModel *feedbackModel;
@property (nonatomic,strong) NSArray *historyModel; //array of MyEventHistoryItem



-(instancetype) initWithEventId:(NSString *)eid departName:(NSString *)depart;
-(instancetype) initWithEventId:(NSString *)eid departName:(NSString *)depart eventType:(MyEventDetailType) etype;
@end
