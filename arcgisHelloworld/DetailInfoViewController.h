//
//  DetailInfoViewController.h
//  arcgisHelloworld
//
//  Created by fifila on 16/6/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CenterSwitchView.h"

@interface DetailInfoViewController : SupportRotationSelectBaseViewController<UITableViewDataSource,CenterSwitchActionDelegate,UITableViewDelegate>
-(instancetype) initWithData:(NSDictionary *) dict objectNumber:(NSString *)objectNumber;
@end
