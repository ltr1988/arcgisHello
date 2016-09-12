//
//  MyLocalEventCell.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/9/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyLocalEventCell.h"
#import "Masonry.h"
#import "UIColor+ThemeColor.h"
#import "EventDetailView.h"
#import "EventReportModel.h"

@implementation MyLocalEventCell
-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSubViews];
    }
    return self;
}

-(void) setupSubViews
{
    __weak UIView *weakView = self.contentView;
    CGFloat buttonHeight = 25 , buttonWidth = 70;
    
    eventDetailView = [[EventDetailView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, [EventDetailView heightForView])];
    eventDetailView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [weakView addSubview:eventDetailView];
    
    btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDelete.bounds = CGRectMake(0, 0, buttonWidth, buttonHeight);
    [btnDelete setTitle:@"删除" forState:UIControlStateNormal];
    [btnDelete setTitleColor:[UIColor themeLightBlackColor] forState:UIControlStateNormal];
    [btnDelete.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btnDelete.layer.borderColor = [UIColor themeLightBlackColor].CGColor;
    btnDelete.layer.borderWidth = 1;
    btnDelete.layer.cornerRadius = 2;
    [btnDelete addTarget:self action:@selector(actionDelete) forControlEvents:UIControlEventTouchUpInside];
    [weakView addSubview:btnDelete];
    
    btnReport = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReport.bounds = CGRectMake(0, 0, buttonWidth, buttonHeight);
    [btnReport setTitle:@"上报" forState:UIControlStateNormal];
    [btnReport setTitleColor:[UIColor themeBlueColor] forState:UIControlStateNormal];
    [btnReport.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btnReport.layer.borderColor = [UIColor themeBlueColor].CGColor;
    btnReport.layer.borderWidth = 1;
    btnReport.layer.cornerRadius = 2;
    [btnReport addTarget:self action:@selector(actionReport) forControlEvents:UIControlEventTouchUpInside];
    [weakView addSubview:btnReport];
    
    CGFloat padding = 8;
    
    [btnReport mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(eventDetailView.mas_bottom).offset(padding);
        make.height.mas_equalTo(buttonHeight);
        make.width.mas_equalTo(buttonWidth);
        make.right.mas_equalTo(weakView.mas_right).offset(-16);
    }];
    
    [btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(eventDetailView.mas_bottom).offset(padding);
        make.height.mas_equalTo(buttonHeight);
        make.width.mas_equalTo(buttonWidth);
        make.right.mas_equalTo(btnReport.mas_left).offset(-10);
    }];
    
}


-(void) setData:(EventReportModel *) data
{
    _data = data;
    [eventDetailView setViewData:(id<EventDetailViewDelegate>)data];
}

+(CGFloat) heightForCell
{
    CGFloat buttonHeight = 25,padding = 8;
    CGFloat height = [EventDetailView heightForView] + padding*2 +buttonHeight;
    return height;
}

#pragma mark actions

-(void) actionReport
{
    if (_reportCallback) {
        _reportCallback(_data);
    }
}
-(void) actionDelete
{
    if (_deleteCallback) {
        _deleteCallback(_data);
    }
    
}
@end
