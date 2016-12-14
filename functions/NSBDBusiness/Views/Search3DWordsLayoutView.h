//
//  Search3DWordsLayoutView.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/7/25.
//  Copyright © 2016年 fifila. All rights reserved.
//
#import <UIKit/UIKit.h>
typedef void (^WordsLayoutViewCallback)(NSInteger selectedIndex);


@interface Search3DWordsLayoutView : UIView
@property(nonatomic,strong) NSArray *words;
- (id)initWithCallback:(WordsLayoutViewCallback)callback;
- (void)layOut;
-(CGFloat) heightForView;
@end
