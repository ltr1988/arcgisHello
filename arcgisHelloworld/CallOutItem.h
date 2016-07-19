//
//  CallOutItem.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemCallOutView.h"

@interface CallOutItem<ItemCallOutViewModel> : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *detail;
@property (nonatomic,strong) NSString *infoImageURL;

@property (nonatomic,strong) NSString *webSiteImageURL;

@property (nonatomic,strong) NSDictionary *moreInfo;
@property (nonatomic,strong) NSDictionary *webSiteInfo;
@end
