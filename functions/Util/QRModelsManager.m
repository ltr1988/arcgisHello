//
//  QRModelsManager.m
//  QQReaderUI-ipad
//
//  Created by William on 8/20/15.
//  Copyright (c) 2015 _tencent_. All rights reserved.
//

#import "QRModelsManager.h"
#import "HttpBaseModel.h"
#import "SearchHomePageModel.h"
#import "SearchTaskStatusModel.h"
#import "SearchCategoryItem.h"
#import "SearchHomePageItem.h"
#import "LoginModel.h"
#import "SearchCategoryModel.h"
#import "SearchHistoryItem.h"
#import "SearchHistoryModel.h"
#import "CommitedEventHistoryItem.h"
#import "CommitedEventHistoryModel.h"
#import "MyEventHistoryItem.h"
#import "HttpMetaData.h"
#import "SearchHistoryTaskItem.h"
#import "SearchHistoryDetailSheetModel.h"
#import "MyEventListModel.h"
#import "MyEventItem.h"
#import "MyEventDetailProgressModel.h"
#import "MyEventHistoryItem.h"
#import "AttachmentItem.h"
#import "MyDealedEventListModel.h"
#import "MyDealedEventItem.h"
#import "MyDealedEventDetailModel.h"
#import "MyDealedEventDetailItem.h"
#import "MyDealedEventDetailProgressModel.h"
#import "MyDealedEventHistoryItem.h"
#import "FacilityInfoModel.h"
#import "AttachmentModel.h"
#import "MyChuanKuaYueListModel.h"
#import "MyChuanKuaYueItem.h"
#import "MyChuanKuaYueProgressModel.h"
#import "MyChuanKuaYueProgressItem.h"
#import "Search3DResultItem.h"
#import "Search3DHeaderItem.h"
#import "Search3DHeaderModel.h"
#import "SearchSessionStateModel.h"
#import "Search3DShenMaiModel.h"
#import "Search3DShenMaiItem.h"
#import "Search3DResultModel.h"
#import "GDReverseGeoItem.h"
#import "SearchAdminsModel.h"
#import "SearchAdminItem.h"
@implementation QRModelsManager

/*
 * 所有用到 MJExtension 的类都需要在此进行 setup。所有！！！
 * 否则多线程访问会 crash。
 *
 * 原因为 MJExtension 会对其生成的模型信息做缓存（MJType: _cachedTypes, MJProperty: cachedPropertyWithProperty）。
 * 该缓存会在类第一次被使用的时候创建。故如果两个类被并发的创建就会 crash。
 *
 * 我们的策略是，在程序启动之初就把所有模型信息缓存好。此后所有线程对这些资源的访问皆为只读，不会再修改。借此避免 crash。
 *
 * 作者已表示不打算在框架內解决线程问题，且 MJExtension 新版本中中发现了更多的被多线程竞争的缓存资源。
 * Update 的时候需要慎重！
 *
 * 参考 Refs:
 * https://github.com/CoderMJLee/MJExtension/issues/27
 * https://github.com/CoderMJLee/MJExtension/pull/157
 * https://github.com/CoderMJLee/MJExtension/issues/152
 *
 */

+ (void)setupMJExtensionModelClasses {
    NSArray
    *classes =
    @[
      [HttpBaseModel class],
      [SearchHomePageModel class],
      [SearchTaskStatusModel class],
      [SearchCategoryItem class],
      [SearchHomePageItem class],
      [LoginModel class],
      [SearchCategoryModel class],
      [SearchHistoryModel class],
      [SearchHistoryItem class],
      [CommitedEventHistoryItem class],
      [CommitedEventHistoryModel class],
      [MyEventHistoryItem class],
      [HttpMetaData class],
      [SearchHistoryTaskItem class],
      [SearchHistoryDetailSheetModel class],
      [MyEventListModel class],
      [MyEventItem class],
      [MyEventDetailProgressModel class],
      [MyEventHistoryItem class],
      [AttachmentItem class],
      [AttachmentModel class],
      [MyDealedEventListModel class],
      [MyDealedEventItem class],
      [MyDealedEventDetailModel class],
      [MyDealedEventDetailItem class],
      [MyDealedEventDetailProgressModel class],
      [MyDealedEventHistoryItem class],
      [FacilityInfoModel class],
      [MyChuanKuaYueListModel class],
      [MyChuanKuaYueItem class],
      [MyChuanKuaYueProgressModel class],
      [MyChuanKuaYueProgressItem class],
      [Search3DResultItem class],
      [Search3DResultModel class],
      [Search3DHeaderItem class],
      [Search3DMANEHeaderItem class],
      [Search3DCategoryHeaderItem class],
      [Search3DHeaderModel class],
      [Search3DHeaderMANEModel class],
      [Search3DHeaderCategoryModel class],
      [SearchSessionStateModel class],
      [Search3DShenMaiModel class],
      [Search3DShenMaiItem class],
      [GDReverseGeoItem class],
      [GDConvertLocationItem class],
      [SearchAdminsModel class],
      [SearchAdminItem class],
      ];
    
    
    for (Class cls in classes) {
        [cls performSelector:@selector(properties)];
    }
}

+ (void)load
{
    [self setupMJExtensionModelClasses];
}

@end
