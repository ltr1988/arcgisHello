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


-(UIView *) headerView;
-(void) setupSubviews;
-(void) reloadTableView;
-(void) refreshHeader;
-(void) actionRefreshData;

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
@end
