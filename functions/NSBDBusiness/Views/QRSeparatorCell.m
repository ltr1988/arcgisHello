//
//  QRSeparatorCell.m
//  NSBDMobileSearchPlatform 
//
//  Created by LvTianran on 15/12/1.
//  Copyright © 2015年 _tencent_. All rights reserved.
//

#if !__has_feature(objc_arc)
#error This file must be compiled with ARC. Use -fobjc-arc flag (or convert project to ARC).
#endif


#import "QRSeparatorCell.h"
#import "CommonDefine.h"

@implementation QRSeparatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.borderColor = UI_COLOR(0xe3, 0xe4, 0xe6);
        self.backgroundColor = UI_COLOR(0xf0, 0xf1, 0xf2);
        self.topBorder = YES;
        self.bottomBorder = YES;
    }
    
    return self;
}

-(void) customizeStyle: (UIColor *) bgColor borderColor:(UIColor *) borderColor needTopBorder:(BOOL)needTopBorder needBottomBorder:(BOOL)needBottomBorder
{
    if (bgColor != nil) {
        self.backgroundColor = bgColor;
    }
    if (borderColor != nil) {
        self.borderColor = borderColor;
    }
    self.topBorder =needTopBorder;
    self.bottomBorder = needBottomBorder;
}

-(void) customizeStyle: (UIColor *) bgColor borderColor:(UIColor *) borderColor
{
    [self customizeStyle:bgColor borderColor:borderColor needTopBorder:YES needBottomBorder:YES];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.borderColor == nil) {
        return;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1);
    CGContextSetStrokeColorWithColor(context, [self.borderColor CGColor]);

    if (_topBorder) {
        CGContextMoveToPoint(context, 0, 0);
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), 0);
        CGContextStrokePath(context);
    }
    
    if (_bottomBorder) {
        CGContextMoveToPoint(context, 0, CGRectGetHeight(self.frame));
        CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        CGContextStrokePath(context);
    }
    
}

@end



@implementation QRSeparatorCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        QRSeparatorView *separatorView = [[QRSeparatorView alloc] initWithFrame:self.bounds];
        separatorView.tag = 999;
        separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:separatorView];
    }
    
    return self;
}

-(void) customizeStyle: (UIColor *) bgColor borderColor:(UIColor *) borderColor
{
    [self customizeStyle:bgColor borderColor:borderColor needTopBorder:YES needBottomBorder:YES];
}

-(void) customizeStyle: (UIColor *) bgColor borderColor:(UIColor *) borderColor needTopBorder:(BOOL)needTopBorder needBottomBorder:(BOOL)needBottomBorder
{
    QRSeparatorView *separatorView = (QRSeparatorView *)[self.contentView viewWithTag:999];
    [separatorView customizeStyle:bgColor borderColor:borderColor needTopBorder:needTopBorder needBottomBorder:needBottomBorder];
}
@end
