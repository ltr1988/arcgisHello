//
//  FFSelectToastView.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/5/23.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import "FFSelectToastView.h"

@interface FFSelectToastView()
@property (nonatomic,copy) void (^callback)(NSString *);
@end

@implementation FFSelectToastView
{
    BOOL _isShowing;
    NSArray<NSString *> * _showList;
    
    UITableView *_tableview;
}

+(instancetype) sharedInstance
{
    static FFSelectToastView *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[FFSelectToastView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    });
    return view;
}

-(instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _showList = [NSArray array];
        _tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth - 140, 160)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.layer.cornerRadius = 30;
        _tableview.clipsToBounds = YES;
        _tableview.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
        [self addSubview:_tableview];
        
    }
    return self;
}

+(void) toastWithSelections:(NSArray*)selections callback:(void (^)(NSString *selectResult))callback;
{
    [[FFSelectToastView sharedInstance] setShowList:selections];
    [[FFSelectToastView sharedInstance] setCallback:callback];
    [[FFSelectToastView sharedInstance] show];
}

-(void) setShowList:(NSArray *)list
{
    _showList = [list copy];
    _tableview.frame = CGRectMake(0, 0, kScreenWidth - 140, 40*list.count);
}

#pragma mark tableview delegate/datasouce
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isShowing) {
        _isShowing = NO;
        self.alpha = 1;
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:nil];
        
        if (_callback) {
            _callback(_showList[indexPath.row]);
        }
    }
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSInteger row = indexPath.row;
    cell.textLabel.text = _showList[row];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _showList.count;
}


- (void)show {
    @synchronized (self) {
        if (_isShowing) {
            [FFSelectToastView cancelPreviousPerformRequestsWithTarget:self];
        }
        // Add to window
        if (!self.superview) {
            [[[UIApplication sharedApplication] keyWindow] addSubview:self];
        } else {
            [self.superview bringSubviewToFront:self];
        }
        // Location center
        self.center = self.superview.center;
        _tableview.center = self.center;
        // Animate
        if (!_isShowing) {
            _isShowing = YES;
            self.alpha = 0;
            [UIView animateWithDuration:0.2 animations:^{
                self.alpha = 1;
            } completion:nil];
        }
    }
}

-(void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    
    if ([self hitTest:point withEvent:event]==self) {
        _isShowing = NO;
        self.alpha = 1;
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:nil];
    }
}
@end
