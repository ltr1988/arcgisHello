//
//  InfoAGSMapView.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/19.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "InfoAGSMapView.h"

@implementation InfoAGSMapView

#pragma mark - touch
-(void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event]; // Message superclass
    
    if (self.infoView && self.infoView.hidden == NO) {
        UITouch *touch = [touches anyObject]; // Get touch from set
        
        if (touch.view != self.infoView) {
            
            __weak __typeof(self) weakself = self;
            [UIView animateWithDuration:0.5 animations:^{
                weakself.infoView.alpha = 0;
            } completion:^(BOOL finished) {
                weakself.infoView.hidden = YES;
            }];
            
        }

    }
    
}

-(void) setInfoView:(UIView *)infoView
{
    if (_infoView && (_infoView!= infoView)) {
        [_infoView removeFromSuperview];
    }
    _infoView = infoView;
    CGRect frame = self.bounds;
    frame.origin.y = self.bounds.size.height - infoView.frame.size.height;
    frame.size.height = infoView.frame.size.height;
    _infoView.frame = frame;
    
    _infoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    [self addSubview:_infoView];
    
    [self bringSubviewToFront:_infoView];
}

-(void) showInfoView:(BOOL)animated
{
    if (_infoView) {
        
        _infoView.hidden = NO;
        self.infoView.alpha = 0;
        __weak __typeof(self) weakself = self;
        
        if (animated) {
            [UIView animateWithDuration:0.5 animations:^{
                weakself.infoView.alpha = 1;
            }];
        }
        else
            self.infoView.alpha = 1;
    }
}
@end
