//
//  DetailInfoViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/12.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "DetailInfoViewController.h"


@interface DetailInfoViewController()
{
    NSMutableDictionary *data;
}
@end

@implementation DetailInfoViewController

-(instancetype) initWithData:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        data = [NSMutableDictionary dictionary];
        if (dict) {
            data = [dict mutableCopy];
        }
        for (NSString *key in dict) {
            if ([dict[key] isKindOfClass:[NSString class]]) {
                NSString *value = dict[key];
                if (value.length == 0) {
                    data[key] = nil;
                }
            }
        }
        
    }
    return self;
}


-(void) viewDidLoad
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [self.view addSubview:tableView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return data.count;
}


-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *reusableIdentifier = @"LayersListCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reusableIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reusableIdentifier];
    }
    cell.textLabel.text = [data.allKeys objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = data[cell.textLabel.text];
    //enable reordering on each cell
    [cell setShowsReorderControl:YES];
    return cell;
}
@end
