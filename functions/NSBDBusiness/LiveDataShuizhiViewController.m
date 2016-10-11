//
//  LiveDataShuizhiViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/1.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "LiveDataShuizhiViewController.h"
#import "ThreeColumnCell.h"
#import "ThreeColumnItem.h"
#import "ThreeColumnView.h"
#import "UIColor+ThemeColor.h"
#import "CommonDefine.h"

@interface LiveDataShuizhiViewController ()

@end

@implementation LiveDataShuizhiViewController

-(void) setupModel
{
#ifdef NoServer
    ThreeColumnColorItem *item = [[ThreeColumnColorItem alloc] init];
    item.firstColumnText = @"官厅";
    item.thirdColumnText = @"0.4";
    item.thirdColumnColor = [UIColor themeLightBlueColor];
    
    ThreeColumnColorItem *item1 = [[ThreeColumnColorItem alloc] init];
    item1.firstColumnText = @"密云";
    item1.thirdColumnText = @"0.7";
    item1.thirdColumnColor = [UIColor themeLightBlueColor];
    
    ThreeColumnColorItem *item2 = [[ThreeColumnColorItem alloc] init];
    item2.firstColumnText = @"怀柔";
    item2.thirdColumnText = @"0.5";
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
    item.thirdColumnText = @"实时水位";
    
    [view setData:item];
    
    return view;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    ThreeColumnColorItem *item = _modelList[indexPath.row];
    
    //    LiveDataDetailShuikuInfoViewController *vc = [[LiveDataDetailShuikuInfoViewController alloc] initWithTitle:item.firstColumnText];
    //    [self.navigationController pushViewController:vc animated:YES];
}
@end
