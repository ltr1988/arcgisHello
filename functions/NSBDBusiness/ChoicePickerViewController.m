//
//  ChoicePickerViewController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/4.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ChoicePickerViewController.h"
@interface ChoicePickerViewController()
{
    NSArray *dataList;    //strings
    NSInteger checkIndex;
}
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,copy) InfoCallback callback;
@end

@implementation ChoicePickerViewController

-(instancetype) initWithChoices:(NSArray *)choices saveCallback:(InfoCallback) callback
{
    self = [super init];
    if (self) {
        dataList = [choices copy];
        checkIndex = -1;
        if (callback) {
            self.callback = callback;
        }
    }
    return self;
}

-(instancetype) initWithChoices:(NSArray *)choices checkedIndex:(NSInteger) index  saveCallback:(InfoCallback) callback
{
    self = [super init];
    if (self) {
        dataList = [choices copy];
        checkIndex = index;
        if (callback) {
            self.callback = callback;
        }
    }
    return self;
}


-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
    if (!dataList || dataList.count == 0) {
        dataList = [NSArray array];
        checkIndex = -1;
    }
    
}

-(void) actionSave
{
    
    if (checkIndex>=0 && _callback) {
        NSDictionary *userInfo = @{@"choice":dataList[checkIndex]};
        dispatch_async(dispatch_get_main_queue(), ^{
            _callback(userInfo);
        });
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) setupSubviews
{
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(actionSave)];
    [self.navigationItem setRightBarButtonItem:rightItem];
    
    _table = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    
    _table.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _table.backgroundColor = [UIColor whiteColor];
    _table.separatorColor = UI_COLOR(0xe3, 0xe4, 0xe6);
    
    [self.view addSubview:_table];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    if (row<0 || row>=dataList.count) {
        return [UITableViewCell new];
    }
    

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CheckableCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CheckableCell"];
    }
    cell.textLabel.text = dataList[row];
    
    if (checkIndex == row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    checkIndex = indexPath.row;
    [tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
