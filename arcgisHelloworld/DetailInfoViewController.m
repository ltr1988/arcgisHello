//
//  DetailInfoViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DetailInfoViewController.h"
#import "FacilityManager.h"
#import "FacilityInfoModel.h"
#import "UITableView+EmptyView.h"
#import "FacilityInfoItem.h"
#import "HttpMetaData.h"
#import "FacilityDetailInfoViewController.h"

@interface DetailInfoViewController()<CenterSwitchActionDelegate>
{

    NSInteger selectedIndex;
}
@property (nonatomic,strong) UITableView *detailTableView;
@property (nonatomic,strong) UITableView *facilityTableView;
@property (nonatomic,strong) NSMutableDictionary *detailData;
@property (nonatomic,strong) NSArray *facilityDataList;
@end

@implementation DetailInfoViewController

-(instancetype) initWithData:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        _detailData = [NSMutableDictionary dictionary];
        if (dict) {
            _detailData = [dict mutableCopy];
        }
        for (NSString *key in dict) {
            if ([dict[key] isKindOfClass:[NSString class]]) {
                NSString *value = dict[key];
                if (value.length == 0) {
                    _detailData[key] = nil;
                }
            }
        }
        
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
    
    self.facilityTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.facilityTableView.delegate = self;
    self.facilityTableView.dataSource = self;
    self.facilityTableView.hidden = YES;
    
    [self.view addSubview:self.facilityTableView];
    
    self.facilityTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    CenterSwitchView *view = [[CenterSwitchView alloc] initWithFrame:CGRectMake(0, 0, CenetrSwitchWidth, CenetrSwitchHeight) andTitleArray:@[@"设施信息",@"设备列表"] andDelegate:self andSelectIndex:0];
    view.delegate = self;
    
    [self navigationItem].titleView = view;
    _facilityDataList = [NSArray array];
    [self requestDataList];
}

- (void)centerSwitchToIndex:(NSUInteger)index
{
    NSLog(@"%@", [NSString stringWithFormat:@"change to index:%lu",(unsigned long)index]);
    selectedIndex = index;
    self.facilityTableView.hidden = (selectedIndex==0);
    self.detailTableView.hidden = (selectedIndex!=0);
}

-(void)requestDataList
{
    NSString *objectNum = _detailData[@"设施编号"];
    if (objectNum) {
        @weakify(self)
        [[FacilityManager sharedInstance] requestFacilityWithId:objectNum successCallback:^(NSURLSessionDataTask *task, id dict) {
            @strongify(self)
            FacilityInfoModel * model = [FacilityInfoModel objectWithKeyValues:dict];
            if (model.success) {
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSArray *info in model.datalist) {
                    FacilityInfoItem *item = [[FacilityInfoItem alloc] initWithArray:info];
                    [tempArray addObject:item];
                }
                self.facilityDataList = [tempArray copy];
                [self.facilityTableView reloadData];
                
            }else if (model.status == HttpResultInvalidUser)
            {
                [ToastView popToast:@"您的帐号在其他地方登录"];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            else
            {
                [ToastView popToast:@"获取设施信息失败,请稍候再试"];
            }
        } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
            [ToastView popToast:@"获取设施信息失败,请稍候再试"];
        }];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.detailTableView) {
        
        return _detailData.count;
    }else
    {
        if (!_facilityDataList || _facilityDataList.count == 0)
        {
            [tableView setEmptyView];
            return 0;
        }
        [tableView removeEmptyView];
        return _facilityDataList.count;
    }
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.detailTableView) {
        NSString *reusableIdentifier = @"LayersListCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusableIdentifier];
        }
        cell.textLabel.text = [_detailData.allKeys objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", _detailData[cell.textLabel.text]];
        //enable reordering on each cell
        //[cell setShowsReorderControl:YES];
        return cell;
    }else
    {
        NSInteger row = indexPath.row;
        NSString *reusableIdentifier = @"facilityListCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
        
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusableIdentifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        FacilityInfoItem *item = _facilityDataList[row];
        HttpMetaData *data = item.info[@"NAME"];
        if (data)
        {
            cell.textLabel.text = data.value;
        }
        data = item.info[@"INSTALL_LOCATION"];
        if (data) {
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", data.value];
        }
        
        return cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FacilityDetailInfoViewController *vc = [[FacilityDetailInfoViewController alloc] initWithFacilityInfoItem:_facilityDataList[indexPath.row]];
    FacilityInfoItem *item = _facilityDataList[indexPath.row];
    HttpMetaData *data = item.info[@"NAME"];
    vc.title = data.value;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
