//
//  DetailInfoViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DetailInfoViewController.h"


@interface DetailInfoViewController()<CenterSwitchActionDelegate>
{
    NSMutableDictionary *detailData;
    NSArray *dataList;
}
@end

@implementation DetailInfoViewController

-(instancetype) initWithData:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        detailData = [NSMutableDictionary dictionary];
        if (dict) {
            detailData = [dict mutableCopy];
        }
        for (NSString *key in dict) {
            if ([dict[key] isKindOfClass:[NSString class]]) {
                NSString *value = dict[key];
                if (value.length == 0) {
                    detailData[key] = nil;
                }
            }
        }
        
    }
    return self;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    CenterSwitchView *view = [[CenterSwitchView alloc] initWithFrame:CGRectMake(0, 0, CenetrSwitchWidth, CenetrSwitchHeight) andTitleArray:@[@"设施信息",@"设备列表"] andDelegate:self andSelectIndex:0];
    view.delegate = self;
    [self.view addSubview:tableView];
    
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self navigationItem].titleView = view;
    
    [self requestDataList];
}

- (void)centerSwitchToIndex:(NSUInteger)index
{
    NSLog([NSString stringWithFormat:@"change to index:%lu",(unsigned long)index]);
}

-(void)requestDataList
{
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return detailData.count;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusableIdentifier = @"LayersListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusableIdentifier];
    }
    cell.textLabel.text = [detailData.allKeys objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = detailData[cell.textLabel.text];
    //enable reordering on each cell
    [cell setShowsReorderControl:YES];
    return cell;
}
@end
