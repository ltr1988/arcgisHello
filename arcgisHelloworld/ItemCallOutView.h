//
//  ItemCallOutView.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

@protocol ItemCallOutViewModel <NSObject>

-(NSString *) title;
-(NSString *) infoImageURL;
-(NSString *) webSiteImageURL;
-(NSDictionary *) moreInfo;
-(NSDictionary *) webSiteInfo;
@end


typedef void (^CalloutCallback)(NSDictionary *info);

@interface ItemCallOutView : UIView

@property (nonatomic,strong) id<ItemCallOutViewModel> model;

@property (nonatomic,copy) CalloutCallback moreInfoCallback;
@property (nonatomic,copy) CalloutCallback webSiteCallback;


@end
