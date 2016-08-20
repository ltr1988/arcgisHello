//
//  SearchSheetCellFactory.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSheetCellFactory.h"
#import "TitleDetailCell.h"
#import "TitleTextInputCell.h"
#import "CheckableTitleCell.h"

@implementation SearchSheetCellFactory
+(BaseTitleCell *) cellForSheetStyle:(SheetUIStyle) style reuseIdentifier:(NSString *)identifier
{
    BaseTitleCell *cell = [[BaseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    switch (style) {
        case SheetUIStyle_ShortText: {
            cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            
            break;
        }
        case SheetUIStyle_Text: {
            cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
        case SheetUIStyle_Switch: {
            cell = [[CheckableTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            break;
        }
        default:
        {
            cell = [[BaseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
    }
    
    
    
    return cell;
}
@end
