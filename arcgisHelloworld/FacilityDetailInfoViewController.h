//
//  FacilityDetailInfoViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"
@class FacilityInfoItem;
@interface FacilityDetailInfoViewController : SupportRotationSelectBaseViewController

-(instancetype) initWithFacilityInfoItem:(FacilityInfoItem *) model;
@end
