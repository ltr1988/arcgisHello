//
//  MyEventHistoryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/7.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyEventHistoryCell.h"

@class UploadAttachmentModel;

//我的待办应急
@interface MyEventHistoryItem : NSObject<MyEventHistoryCellModel>
@property (nonatomic,strong) NSString *detailId;
@property (nonatomic,strong) NSString *disposeDescription;
@property (nonatomic,strong) NSString *addTime;
@property (nonatomic,strong) NSString *creatorName;
@property (nonatomic,strong) NSString *disposeBy;
@property (nonatomic,strong) NSArray *fileList;
@property (nonatomic,strong) UploadAttachmentModel *attachment;
@end
