//
//  MyDealedEventDetailItem.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/10/17.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UploadAttachmentModel;
@interface MyDealedEventDetailItem : NSObject
@property (nonatomic,strong) NSString *creator;
@property (nonatomic,strong) NSString *departmentName;
@property (nonatomic,strong) NSString *executorName;
@property (nonatomic,strong) NSString *eid;
@property (nonatomic,strong) NSString *makeTime;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *status;

@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSArray *fileList;
@property (nonatomic,strong) UploadAttachmentModel *attachment;
@end
