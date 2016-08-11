//
//  SearchChoiceController.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchChoiceController.h"
#import "CommonDefine.h"
#import "Masonry.h"

@interface SearchChoiceController()
{
    UIView *contentView;
}
@end

@implementation SearchChoiceController

-(void) viewDidLoad
{
    [super viewDidLoad];
    [self setupSubviews];
}

-(void) setupSubviews
{
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    UITapGestureRecognizer *_tapToCloseGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToClose:)];
    _tapToCloseGesture.numberOfTapsRequired = 1;
    _tapToCloseGesture.numberOfTouchesRequired = 1;
    _tapToCloseGesture.delegate = self;
    [self.view addGestureRecognizer:_tapToCloseGesture];
    
    contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius = 5;
    contentView.layer.masksToBounds = YES;
    [self.view addSubview:contentView];
    
    UILabel *label = [UILabel new];
    label.text = @"有未结束的填报信息，是否继续填报上一次内容?";
    label.lineBreakMode = NSLineBreakByCharWrapping;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    [label setTextColor:[UIColor blackColor]];
    [self.view addSubview:label];
    
    UIButton *btnContinue = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnContinue setTitle:@"继续填报上次内容" forState:UIControlStateNormal];
    [btnContinue.titleLabel setTextColor:[UIColor whiteColor]];
    [btnContinue.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btnContinue setBackgroundColor:[UIColor blueColor]];
    [btnContinue addTarget:self action:@selector(actionContinue:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnContinue];
    
    UIButton *btnEndSession = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnEndSession setTitle:@"结束并填报新信息" forState:UIControlStateNormal];
    [btnEndSession.titleLabel setTextColor:[UIColor whiteColor]];
    [btnEndSession.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btnEndSession setBackgroundColor:[UIColor blackColor]];
    [btnEndSession addTarget:self action:@selector(actionEndSession:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEndSession];
    
    __weak UIView *weakParentView = self.view;
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(300);
        make.width.mas_equalTo(300);
        make.centerX.mas_equalTo(weakParentView.mas_centerX);
        make.centerY.mas_equalTo(weakParentView.mas_centerY);
    }];
                                 
    __weak UIView *weakView = contentView;
                                 
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakView.mas_top).offset(30);
        make.left.mas_equalTo(weakView.mas_left).offset(40);
        make.right.mas_equalTo(weakView.mas_right).offset(-40);
    }];
    
    [btnContinue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label.mas_bottom).offset(50);
        make.left.mas_equalTo(weakView.mas_left).offset(60);
        make.right.mas_equalTo(weakView.mas_right).offset(-60);
        make.height.mas_equalTo(40);
    }];
    
    [btnEndSession mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btnContinue.mas_bottom).offset(16);
        make.left.mas_equalTo(weakView.mas_left).offset(60);
        make.right.mas_equalTo(weakView.mas_right).offset(-60);
        make.height.mas_equalTo(40);
    }];
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:contentView];
    BOOL locationIsInCenterPanel = CGRectContainsPoint(contentView.bounds, location);
    
    return !locationIsInCenterPanel;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    // never recognize simultaneously because then a table view cell swipe can close a panel
    return NO;
}


- (void)tapToClose:(UITapGestureRecognizer *)gesture
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark actions
- (void)actionContinue:(id) sender
{
    
}

- (void)actionEndSession:(id) sender
{
    
}
@end
