//
//  FFSelectToastView.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 2017/5/23.
//  Copyright © 2017年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FFSelectToastView : UIView<UITableViewDelegate,UITableViewDataSource>
+(void) toastWithSelections:(NSArray*)selections callback:(void (^)(NSString *selectResult))callback;
@end
