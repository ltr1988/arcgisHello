//
//  ThreeColumnCell.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/9/18.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ThreeColumnCell.h"
#import "ThreeColumnView.h"


@implementation ThreeColumnCell
{
    ThreeColumnView *columnView;
}

-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        columnView = [[ThreeColumnView alloc] initWithFrame:self.bounds];
        columnView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:columnView];
    }
    return self;
}

-(void) setData:(id<ThreeColumnViewDelegate>)data
{
    _data = data;
    [columnView setData:data];
}

@end
