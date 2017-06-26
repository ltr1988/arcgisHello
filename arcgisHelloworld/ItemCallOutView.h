//
//  ItemCallOutView.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

@protocol ItemCallOutViewModel <NSObject>

-(NSString *) title;
-(NSString *) detail;
-(NSString *) infoImageURL;
-(NSString *) webSiteImageURL;
-(NSDictionary *) moreInfo;
-(NSDictionary *) webSiteInfo;
-(AGSPoint *) location;
@end


typedef void (^CalloutCallback)(id info);

@interface ItemCallOutView : UIView

@property (nonatomic,strong) id<ItemCallOutViewModel> model;

@property (nonatomic,copy) CalloutCallback moreInfoCallback;
@property (nonatomic,copy) CalloutCallback webSiteCallback;

@property (nonatomic,copy) CalloutCallback goHereCallback;

@end
