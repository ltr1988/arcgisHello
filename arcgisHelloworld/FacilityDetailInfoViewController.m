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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.orderedKeyIds.count;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusableIdentifier = @"InfoListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusableIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *key =  [_model.orderedKeyIds objectAtIndex:indexPath.row];
    HttpMetaData *data =_model.info[key];
    cell.textLabel.text = data.title.length>0?data.title:data.dataID;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", data.value];
    
    return cell;
    
}

@end
