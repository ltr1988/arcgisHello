//
//  InfoAGSMapView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Arcgis/Arcgis.h>

@interface InfoAGSMapView : AGSMapView
@property (nonatomic,strong) UIView *infoView;
@property (nonatomic,strong) UIView *bottomView;
-(void) showInfoView:(BOOL)animated;
@end
