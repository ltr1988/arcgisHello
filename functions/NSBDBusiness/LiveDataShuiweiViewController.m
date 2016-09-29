//
//  LiveDataShuiweiViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/29.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LiveDataShuiweiViewController.h"
#import "ThreeColumnCell.h"
#import "ThreeColumnItem.h"
#import "ThreeColumnView.h"
#import "UIColor+ThemeColor.h"

@interface LiveDataShuiweiViewController ()

@end

@implementation LiveDataShuiweiViewController

-(void) setupModel
{
#ifdef NoServer
    ThreeColumnColorItem *item = [[ThreeColumnColorItem alloc] init];
    item.firstColumnText = @"东干渠";
    item.thirdColumnText = @"0.4";
    item.thirdColumnColor = [UIColor themeLightBlueColor];
    
    ThreeColumnColorItem *item1 = [[ThreeColumnColorItem alloc] init];
    item1.firstColumnText = @"南干渠";
    item1.thirdColumnText = @"0.7";
    item1.thirdColumnColor = [UIColor themeLightBlueColor];
    
    ThreeColumnColorItem *item2 = [[ThreeColumnColorItem alloc] init];
    item2.firstColumnText = @"大宁";
    item2.thirdColumnText = @"0.5";
    item2.thirdColumnColor = [UIColor themeLightBlueColor];
    
    _modelList = @[item,item1,item2];
    return;
#endif
}
@end
