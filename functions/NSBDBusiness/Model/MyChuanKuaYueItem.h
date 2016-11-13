//
//  MyChuanKuaYueItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyChuanKuaYueListItemCellModel;

@interface MyChuanKuaYueItem : NSObject
@property (nonatomic,strong) NSString *acrossCode;
@property (nonatomic,strong) NSString *projectEnd;
@property (nonatomic,strong) NSString *supervisoryUnit;
@property (nonatomic,strong) NSString *effectiveState;
@property (nonatomic,assign) double poix;
@property (nonatomic,assign) double poiY;
@property (nonatomic,strong) NSString *managementOpinion;
@property (nonatomic,assign) long long addTime; //addtime.time
@property (nonatomic,strong) NSString *nsbdbOpinion;
@property (nonatomic,strong) NSString *deptCode;
@property (nonatomic,strong) NSString *receiveDate;
@property (nonatomic,strong) NSString *contact;
@property (nonatomic,strong) NSString *receiverId;
@property (nonatomic,assign) BOOL isDel;
@property (nonatomic,strong) NSString *unit;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *acrossId;
@property (nonatomic,strong) NSString *constructionUnit;
@property (nonatomic,strong) NSString *record;
@property (nonatomic,strong) NSString *num;
@property (nonatomic,strong) NSString *declarationStatement;
@property (nonatomic,strong) NSString *constructionPeriod;
@property (nonatomic,strong) NSString *theId;
@property (nonatomic,strong) NSString *changeTimes;
@property (nonatomic,assign) BOOL pass;
@property (nonatomic,strong) NSString *rowNum;
@property (nonatomic,strong) NSString *safetyMonitorUnit;
@property (nonatomic,strong) NSString *mileNum;
@property (nonatomic,strong) NSString *positionDescription;
@property (nonatomic,strong) NSString *changeStatus;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *applicant;
@property (nonatomic,strong) NSString *data;
@property (nonatomic,strong) NSString *other;
@property (nonatomic,assign) BOOL isAccept;
@property (nonatomic,strong) NSString *applyDate;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *receiver;


@property (nonatomic,strong) NSArray *fileList; //AttachmentItem
@end


@interface MyChuanKuaYueItem(CellModel) <MyChuanKuaYueListItemCellModel>
- (NSString *) cellTitle;
- (NSString *) cellUnit;
- (NSString *) cellLocation;
@end
