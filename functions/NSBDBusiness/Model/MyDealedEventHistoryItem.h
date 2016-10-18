//
//  MyDealedEventHistoryItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MyEventHistoryCell.h"

@class UploadAttachmentModel;

@interface MyDealedEventHistoryItem : NSObject<MyEventHistoryCellModel>
@property (nonatomic,strong) NSString *detailId;
@property (nonatomic,strong) NSString *disposeComment;
@property (nonatomic,strong) NSString *addTime;
@property (nonatomic,strong) NSString *creatorName;
@property (nonatomic,strong) NSArray *fileList;
@property (nonatomic,strong) UploadAttachmentModel *attachment;
@end
