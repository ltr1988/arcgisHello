//
//  RouteViewController.h
//  arcgisHelloworld
//
//  Created by fifila on 16/6/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RouteStartEndPickerController : SupportRotationSelectBaseViewController

@property (strong, nonatomic) AGSPoint *endPoint;
@property (strong, nonatomic) NSString *endPointDesc;
@end
