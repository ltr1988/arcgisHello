//
//  LiveDataLiuliangViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LiveDataLiuliangViewController.h"
#import "ThreeColumnCell.h"
#import "ThreeColumnItem.h"
#import "ThreeColumnView.h"
#import "UIColor+ThemeColor.h"
#import "CommonDefine.h"

@interface LiveDataLiuliangViewController ()

@end

@implementation LiveDataLiuliangViewController


-(void) setupModel
{
#ifdef NoServer
    ThreeColumnColorItem *item = [[ThreeColumnColorItem alloc] init];
    item.firstColumnText = @"屯佃泵站";
    item.secondColumnText = @"昌平";
    item.thirdColumnText = @"55.4";
    item.thirdColumnColor = [UIColor themeLightBlueColor];
    
    ThreeColumnColorItem *item1 = [[ThreeColumnColorItem alloc] init];
    item1.firstColumnText = @"屯佃泵站";
    item1.secondColumnText = @"昌平";
    item1.thirdColumnText = @"55.5";
    item1.thirdColumnColor = [UIColor themeLightBlueColor];
    
    ThreeColumnColorItem *item2 = [[ThreeColumnColorItem alloc] init];
    item2.firstColumnText = @"李史山泵站";
    item2.secondColumnText = @"怀柔";
    item2.thirdColumnText = @"55.6";
    item2.thirdColumnColor = [UIColor themeLightBlueColor];
    
    _modelList = @[item,item1,item2];
    return;
#endif
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    ThreeColumnView *view = [[ThreeColumnView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 50)];
    [view setColumnColor:[UIColor grayColor]];
    [view setFont:UI_FONT(12)];
    
    ThreeColumnColorItem *item = [ThreeColumnColorItem new];
    item.firstColumnText = @"站点";
    item.secondColumnText = @"行政区";
    item.thirdColumnText = @"累计雨量(毫米)";
    
    [view setData:item];
    
    return view;
}
@end
