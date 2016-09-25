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
