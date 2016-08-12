//
//  SearchChoiceController.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol SearchChoiceControllerDelegate <NSObject>

-(void) dismissController;
-(void) continueSession;
-(void) endSession;

@end

@interface SearchChoiceController : UIViewController<UIGestureRecognizerDelegate>
@property (nonatomic,weak) id<SearchChoiceControllerDelegate> delegate;
@end
