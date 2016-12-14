//
//  ComboBox.m
//  ComboBoxExample
//
//  Created by Ulaş Sancak on 7/25/13.
//  Copyright (c) 2013 Sancak. All rights reserved.
//

#import "ComboBox.h"
#import "ComboBoxCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation ComboBox

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [self addSubview:_button];
        [_button addTarget:self action:@selector(openComboBox:) forControlEvents:UIControlEventTouchUpInside];
        
        _arrow = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width-12,frame.size.height/2 - 6, 12, 12)];
        _arrow.image = [UIImage imageNamed:@"arrow"];
        [self addSubview:_arrow];
        
        
        [_button setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        defaultComboBoxTableSize = CGSizeMake(self.frame.size.width, 100);
        _comboBoxTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, _button.frame.origin.y+_button.frame.size.height, self.frame.size.width, 0)];
        
        _comboBoxTableView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _comboBoxTableView.layer.borderWidth = 1;
        _comboBoxTableView.delegate = self;
        _comboBoxTableView.dataSource = self;
        [self addSubview:_comboBoxTableView];
        
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyOpenComboBox:) name:@"openComboBox" object:nil];
    }
    return self;
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) notifyOpenComboBox:(NSNotification *)noti
{
    if (noti.object != self) {
        if (_comboBoxTableView.frame.size.height != 0) {
            
            [self closeComboBoxWithAnimation:_comboBoxTableView];
        }
    }
}

-(void)openComboBoxWithAnimation:(UITableView *)comboBoxTableView{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"openComboBox" object:self];
    [UIView animateWithDuration:0.25
                     animations:^(void){
                         [_comboBoxTableView setFrame:CGRectMake(0, _button.frame.origin.y+_button.frame.size.height, self.frame.size.width, defaultComboBoxTableSize.height)];
                         CGRect frame = self.frame;
                         frame.size.height = _button.frame.size.height+_comboBoxTableView.frame.size.height;
                         self.frame = frame;
                         frame = self.frame;
                         frame.size.height = _button.frame.size.height+_comboBoxTableView.frame.size.height;
                         self.frame = frame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)closeComboBoxWithAnimation:(UITableView *)comboBoxTableView{
    [UIView animateWithDuration:0.25
                     animations:^(void){
                         [_comboBoxTableView setFrame:CGRectMake(0, _button.frame.origin.y+_button.frame.size.height, self.frame.size.width, 0)];
                         CGRect frame = self.frame;
                         frame.size.height = _button.frame.size.height+_comboBoxTableView.frame.size.height;
                         self.frame = frame;
                         frame = self.frame;
                         frame.size.height = _button.frame.size.height+_comboBoxTableView.frame.size.height;
                         self.frame = frame;
                     }
                     completion:^(BOOL finished){
                         
                     }];
}

-(void)setComboBoxSize:(CGSize)size{
    defaultComboBoxTableSize = size;
}


-(void)setComboBoxData:(NSArray *)comboBoxData{
    _comboBoxDataArray = [NSArray arrayWithArray:comboBoxData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _comboBoxDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"ComboCell";
    ComboBoxCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[ComboBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CGRect frame = cell.frame;
    frame.size.width = self.frame.size.width;
    cell.frame = frame;
    
    cell.titleLabel.text = [_comboBoxDataArray objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_button setTitle:[_comboBoxDataArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    [self closeComboBoxWithAnimation:_comboBoxTableView];
    [self.delegate comboBox:self didSelectRowAtIndexPath:indexPath];
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (IBAction)openComboBox:(UIButton *)sender {
    if (_comboBoxTableView.frame.size.height == 0) {
        [_comboBoxTableView reloadData];
        [self openComboBoxWithAnimation:_comboBoxTableView];
    }
    else {
        [self closeComboBoxWithAnimation:_comboBoxTableView];
    }
    
}

-(void)setComboBoxTitle:(NSString *)title{
    [_button setTitle:title forState:UIControlStateNormal];
}

@end
