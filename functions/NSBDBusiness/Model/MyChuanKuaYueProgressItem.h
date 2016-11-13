//
//  MyChuanKuaYueProgressItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyChuanKuaYueHistoryCell.h"

@class UploadAttachmentModel;
@interface MyChuanKuaYueProgressItem : NSObject<MyChuanKuaYueHistoryCellModel>
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *departName;
@property (nonatomic,strong) NSString *btime;
@property (nonatomic,strong) NSString *creator;


@property (nonatomic,strong) NSArray *fileList; //AttachmentItem
@property (nonatomic,strong) UploadAttachmentModel *attachment;
@end
