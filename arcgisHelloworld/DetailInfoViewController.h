//
//  DetailInfoViewController.h
//  arcgisHelloworld
//
//  Created by fifila on 16/6/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailInfoViewController : NoRotationBaseViewController<UITableViewDataSource,UITableViewDelegate>
-(instancetype) initWithData:(NSDictionary *) dict;
@end
