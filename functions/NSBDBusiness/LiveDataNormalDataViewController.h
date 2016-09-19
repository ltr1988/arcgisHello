//
//  LiveDataNormalDataViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@interface LiveDataNormalDataViewController : SupportRotationSelectBaseViewController<UITableViewDelegate,UITableViewDataSource>

-(instancetype) initWithTitle:(NSString *)title;
@end
