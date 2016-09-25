//
//  SearchSecondaryListViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/24.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSecondaryListViewController.h"
#import "SearchCategoryItem.h"
#import "CommonDefine.h"
#import "Masonry.h"
#import "QRSeparatorCell.h"
#import "SearchSheetCellFactory.h"
#import "SearchSheetGroupItem.h"
#import "SearchSheetInfoItem.h"
#import "SearchSessionManager.h"
#import "SearchSessionItem.h"
#import "NSBDBaseUIItem.h"



@interface SearchSecondaryListViewController()
@property (nonatomic,strong) NSArray *dataList;
@property (nonatomic,strong) SearchCategoryItem *item;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,readonly) NSDictionary *codeDictionary;
@property (nonatomic,readonly) NSDictionary *titleDictionary;
@end

@implementation SearchSecondaryListViewController
@synthesize codeDictionary = _codeDictionary;
@synthesize titleDictionary = _titleDictionary;

-(instancetype) initWithSearchCategoryItem:(SearchCategoryItem*) item
{
    if (self = [super init]) {
        _item = item;
    }
    return self;
}

-(NSDictionary *) codeDictionary
{
    if (!_codeDictionary) {
        _codeDictionary = @{@"NGQPKJUP":@"ngqqueryair",
                            @"NGQPKJDOWN":@"ngqqueryair",
                            @"NGQPQJUP":@"ngqquerywell",
                            @"NGQPQJDOWN":@"ngqquerywell",
                            @"NGQGX":@"ngqqueryline",
                            @"DGQPQJ":@"dgqqueryair",
                            @"DGQFSK":@"dgqquerywater",
                            @"DGQPKJ":@"dgqquerywell",
                            @"DGQGX":@"dgqqueryline",
                            @"DNPKJ":@"dnquerywell",
                            @"DNPQJ":@"dnqueryair",
                            @"DNGX":@"dnqueryline"};
    }
    return _codeDictionary;
    
}

-(NSDictionary *) titleDictionary
{
    if (!_titleDictionary) {
        _titleDictionary = @{@"NGQPKJUP":@"南干渠排空井上段",
                            @"NGQPKJDOWN":@"南干渠排空井下段",
                            @"NGQPQJUP":@"南干渠排气阀井上段",
                            @"NGQPQJDOWN":@"南干渠排气阀井下段",
                            @"NGQGX":@"南干渠管线",
                            @"DGQPQJ":@"东干渠排气阀井",
                            @"DGQFSK":@"东干渠分水口",
                            @"DGQPKJ":@"东干渠排空井",
                            @"DGQGX":@"东干渠管线",
                            @"DNPKJ":@"大宁排空井",
                            @"DNPQJ":@"大宁排气阀井",
                            @"DNGX":@"大宁管线"};
    }
    return _titleDictionary;
    
}

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    
    [self requestData];
}

-(void) requestData
{
    if (![[AFNetworkReachabilityManager sharedManager] isReachable])
    {
        [ToastView popToast:@"暂无网络，稍后再试"];
        return;
    }
    @weakify(self);
    [[SearchSessionManager sharedManager] requestQueryListSearchSessionWithTaskId:[SearchSessionManager sharedManager].session.sessionId code:_item.code action:self.codeDictionary[_item.code] SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        @strongify(self);
        
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
        @strongify(self);
    }];
}

-(void) setupSubviews
{
    self.title = self.titleDictionary[_item.code];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _tableView.backgroundColor = UI_COLOR(0xFF,0x82,0x47);
    _tableView.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (!_dataList) {
        return 0;
    }
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_dataList) {
        return [UITableViewCell new];
    }
//    NSInteger row = indexPath.row;
//    SearchSheetGroupItem *group = self.uiItem.infolist[section];
//    if (row < group.items.count) {
//        
//        SearchSheetInfoItem *item = group.items[row];
//        
//        BaseTitleCell *cell = [_tableView dequeueReusableCellWithIdentifier:item.key];
//        if (!cell) {
//            cell = [SearchSheetCellFactory cellForSheetStyle:item.uiStyle reuseIdentifier:item.key];
//        }
//        
//        cell.data = item.data;
//    }

    
    
    return [UITableViewCell new];
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
