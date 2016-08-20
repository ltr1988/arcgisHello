//
//  SearchSheetCellFactory.h
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSBDBaseUIItem.h"
#import "BaseTitleCell.h"

@interface SearchSheetCellFactory : NSObject
+(BaseTitleCell *) cellForSheetStyle:(SheetUIStyle) style  reuseIdentifier:(NSString *)identifier;

@end
