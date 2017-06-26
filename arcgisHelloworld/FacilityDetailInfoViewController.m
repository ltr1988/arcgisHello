//
//  FacilityDetailInfoViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/23.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "FacilityDetailInfoViewController.h"
#import "FacilityInfoItem.h"
#import "HttpMetaData.h"

@interface FacilityDetailInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) FacilityInfoItem *model;

@property (nonatomic,strong) NSArray *datalist;
@property (nonatomic,strong) NSSet *filterSet;
@end

@implementation FacilityDetailInfoViewController

-(instancetype) initWithFacilityInfoItem:(FacilityInfoItem *) model
{
    self = [super init];
    if (self) {
        _model = model;
        
    }
    return self;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    self.detailTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.detailTableView.delegate = self;
    self.detailTableView.dataSource = self;
    
    [self.view addSubview:self.detailTableView];
    
    self.detailTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
}

-(NSArray *) datalist
{
    if (!_datalist) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSString *key in _model.orderedKeyIds) {
            HttpMetaData *data =_model.info[key];
            if ([[self filterSet] containsObject:data.title])
                continue;
            [array addObject:data];
        }
        _datalist = [array copy];
    }
    return _datalist;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datalist.count;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusableIdentifier = @"InfoListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    HttpMetaData *data = _datalist[indexPath.row];
    cell.textLabel.text = data.title;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", data.value];
    
    return cell;
    
}

-(NSSet *) filterSet
{
    if (!_filterSet) {
        _filterSet = [NSSet setWithArray:@[@"",
                                           @"管理处id",
                                           @"工程编号",
                                           @"设施编号",
                                           @"设备汇总类id",
                                           @"设施类型编号",
                                           @"ISDEL",
                                           @"ADDTIME",
                                           @"REMARKS",
                                           @"USERID",
                                           @"工程类型编号",
                                           @"ORDER_ID",
                                           @"设施ID",
                                           @"设备类型id",
                                           @"DEPTCODE",]];
    }
    return _filterSet;
}

@end
