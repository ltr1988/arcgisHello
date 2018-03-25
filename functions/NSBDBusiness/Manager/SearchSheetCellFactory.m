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
        case SheetUIStyle_ReadonlyText:{
            cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
        case SheetUIStyle_ShortTextWeather:
        case SheetUIStyle_ShortText: {
            cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
        case SheetUIStyle_ShortTextNum:
        {
            cell = [[TitleTextInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            [(TitleTextInputCell*)cell setKeyBoardType:UIKeyboardTypeDecimalPad];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
        case SheetUIStyle_Date:
        case SheetUIStyle_Text: {
            cell = [[TitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        }
        case SheetUIStyle_Switch: {
            cell = [[CheckableTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        }
        default:
        {
            cell = [[BaseTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    }
    
    
    
    return cell;
}
@end
