//
//  SearchPlaceBasicInfoViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2018/3/18.
//  Copyright © 2018年 fifila. All rights reserved.
//

#import "SearchPlaceBasicInfoViewController.h"
#import "Masonry.h"
#import "SearchSessionManager.h"


NSInteger const SearchPlaceBasicInfoCellHeight = 40;

@interface SearchPlaceBasicInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) UITableView *tableView;
@property (nonatomic) UIView *bgView;
@end

@implementation SearchPlaceBasicInfoViewController

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self.bgView];
    if (!CGRectContainsPoint(self.tableView.frame, point)) {
        [self dismissViewControllerAnimated:YES
                                 completion:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubviews];
    
    self.model = [SearchSessionManager sharedManager].session.basicInfo;
    [self.tableView reloadData];
}

-(void) setupSubviews
{
    self.bgView = [UIView new];
    self.bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_bgView addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
        make.width.mas_equalTo(kScreenWidth-30);
        make.height.mas_equalTo(SearchPlaceBasicInfoCellHeight *5);
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SearchPlaceBasicInfoCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            TitleTextInputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCellSearcher"];
            if (!cell) {
                cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCellSearcher"];
            }
            cell.readOnly = YES;
            cell.data = self.model.searcher;
            return cell;
            break;
        }
        case 1:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleTextInputCellSearchAdmin"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleTextInputCellSearchAdmin"];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.data = self.model.searchAdmin;
            cell.readOnly = YES;
            return cell;
            break;
        }
        case 2:
        {
            TitleComboBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleComboBoxCell"];
            if (!cell) {
                cell = [[TitleComboBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleComboBoxCell"];
            }
            cell.data = self.model.taskTypeName;
            cell.readOnly = YES;
            return cell;
            break;
        }
        case 3:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.data = self.model.date;
            cell.readOnly = YES;
            return cell;
            break;
        }
        case 4:
        {
            TitleDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TitleDetailCell"];
            if (!cell) {
                cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TitleDetailCell"];
            }
            cell.data = self.model.weather;
            cell.readOnly = YES;
            return cell;
            break;
        }
        default:
            break;
    }
    return [UITableViewCell new];
}
@end
