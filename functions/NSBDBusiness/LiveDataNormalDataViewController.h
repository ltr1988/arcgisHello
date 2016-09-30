//
//  LiveDataNormalDataViewController.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SupportRotationSelectBaseViewController.h"

@class TitleDetailItem;

// 3列数据
// 刷新时间
@interface LiveDataNormalDataViewController : SupportRotationSelectBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_modelList;
}
@property (nonatomic,strong) NSArray *modelList;
@property (nonatomic,weak) TitleDetailItem *model; //super model

-(instancetype) initWithTitleDetailItem:(TitleDetailItem *)item;


-(UIView *) headerView;
-(void) refreshHeader;   //refresh header content

-(void) setupSubviews;
-(void) reloadTableView; //reload data in tableview

-(void) actionRefreshData; //request data

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
@end
