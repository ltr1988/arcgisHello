//
//  MyChuanKuaYueFeedbackViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
#import "MediaPickerManager.h"

@class EventMediaPickerView;
@class FeedbackModel;
@class MyChuanKuaYueItem;

@interface MyChuanKuaYueFeedbackViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    MediaPickerManager *mPickerManager;
}

@property (nonatomic,strong) EventMediaPickerView *mPicker;
@property (nonatomic,strong) UITableView *feedbackTableView;
@property (nonatomic,strong) UITableView *historyTableView;
@property (nonatomic,strong) UITableView *myFeedbackTableView;
@property (nonatomic,strong) FeedbackModel *feedbackModel;
@property (nonatomic,strong) NSArray *historyModel;
@property (nonatomic,strong) NSArray *myFeedbackModel;


-(instancetype) initWithCrossItem:(MyChuanKuaYueItem *)item;
@end
