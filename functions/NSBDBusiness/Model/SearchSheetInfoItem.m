//
//  SearchSheetInfoItem.m
//  NSBDMobileSearchPlatform
//
//  Created by LvTianran on 16/8/20.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "SearchSheetInfoItem.h"
#import "TitleInputItem.h"
#import "CheckableTitleItem.h"
#import "TitleDetailTextItem.h"
#import "TitleDateItem.h"
#import "TitleDetailItem.h"
#import "WeatherManager.h"
#import "NSDateFormatterHelper.h"

@implementation SearchSheetInfoItem

-(instancetype) initWithKey:(NSString *) key style:(NSArray *)styleArray //array[0] for style, array[1] for order
{
    self = [super init];
    if (self) {
        _uiStyle = [styleArray[0] integerValue];
        _order = [styleArray[1] integerValue];
        _key = [key copy];
        _data = [self dataWithStyle:_uiStyle];
    }
    return self;
}

-(void) setUiStyle:(SheetUIStyle)uiStyle
{
    if (_uiStyle != uiStyle) {
        _uiStyle = uiStyle;
    }
}

//-(void) setData:(TitleItem *)data
//{
//    _data = data;
//    if ([data isKindOfClass:[TitleInputItem class]]) {
//        _uiStyle = SheetUIStyle_ShortText;
//    }else if ([data isKindOfClass:[TitleDetailTextItem class]]) {
//        _uiStyle = SheetUIStyle_Text;
//    }else if ([data isKindOfClass:[TitleDateItem class]]) {
//        _uiStyle = SheetUIStyle_Date;
//    }else if ([data isKindOfClass:[TitleDetailItem class]]) {
//        _uiStyle = SheetUIStyle_ReadonlyText;
//    }else if ([data isKindOfClass:[CheckableTitleItem class]]) {
//        _uiStyle = SheetUIStyle_Switch;
//    }
//}

-(void) setTitle:(NSString *)title
{
    switch (_uiStyle) {
        case SheetUIStyle_ReadonlyText: {
            _data = [TitleDetailItem itemWithTitle:title detail:@""];
            break;
        }
        case SheetUIStyle_ShortTextNum:
        case SheetUIStyle_ShortText: {
            _data = [TitleInputItem itemWithTitle:title placeholder:[NSString stringWithFormat:@"请填写%@",title]];
            break;
        }
        case SheetUIStyle_ShortTextWeather:
            _data = [TitleInputItem itemWithTitle:title placeholder:[NSString stringWithFormat:@"请填写%@",title]];
            [(TitleInputItem*)_data setDetail:[WeatherManager sharedInstance].weather];
            break;
        case SheetUIStyle_Text: {
            _data = [TitleDetailTextItem itemWithTitle:title detail:@"未填写" text:@""];
            break;
        }case SheetUIStyle_Date: {
            NSDateFormatter *formater = [[NSDateFormatterHelper sharedInstance] formatterWithFormat:@"yyyy-MM-dd HH:mm:ss"];
            _data = [TitleDetailItem itemWithTitle:title detail:[formater stringFromDate:[NSDate date]]];
            break;
        }
        case SheetUIStyle_Switch: {
            _data = [CheckableTitleItem itemWithTitle:title checked:NO];
            break;
        }
        default:
        {
            _data = [TitleItem itemWithTitle:title];
        }
    }
}


-(void) setDetail:(NSString *)detail
{
    if (!detail) {
        return;
    }
    switch (_uiStyle) {
        case SheetUIStyle_Date:
        case SheetUIStyle_ReadonlyText: {
            TitleDetailItem *item = (TitleDetailItem *)_data;
            item.detail = detail;
            break;
        }
        case SheetUIStyle_ShortTextNum:
        case SheetUIStyle_ShortTextWeather:
        case SheetUIStyle_ShortText: {
            TitleInputItem *item = (TitleInputItem *)_data;
            item.detail = detail;
            break;
        }
        case SheetUIStyle_Text: {
            TitleDetailTextItem *item = (TitleDetailTextItem *)_data;
            item.text = detail;
            if (detail.length>0) {
                item.detail = @"已填写";
            }else
            {
                item.detail = @"未填写";
            }
            break;
        }
        case SheetUIStyle_Switch: {
            CheckableTitleItem *item = (CheckableTitleItem *)_data;
            item.checked = [detail boolValue];
            break;
        }
    }
}
-(TitleItem *) dataWithStyle:(SheetUIStyle)uiStyle
{
    switch (uiStyle) {
        case SheetUIStyle_ReadonlyText: {
            return [TitleDetailItem itemWithTitle:@"" detail:@""];
            break;
        }
        case SheetUIStyle_ShortTextWeather:
        case SheetUIStyle_ShortTextNum:
        case SheetUIStyle_ShortText: {
            return [TitleInputItem itemWithTitle:@"" placeholder:@""];
            break;
        }
        case SheetUIStyle_Text: {
            return [TitleDetailTextItem itemWithTitle:@"" detail:@""];
            break;
        }
        case SheetUIStyle_Switch: {
            return [CheckableTitleItem itemWithTitle:@""];
            break;
        }
        case SheetUIStyle_Date:{
            return [TitleDetailItem itemWithTitle:@"" detail:@""];
            break;
        }
    }
    return [TitleItem itemWithTitle:@""];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.data forKey:@"TitleItem"];
    [aCoder encodeObject:self.key forKey:@"key"];
    [aCoder encodeInteger:self.uiStyle forKey:@"uiStyle"];
    [aCoder encodeInteger:self.order forKey:@"order"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        self.data = [aDecoder decodeObjectForKey:@"TitleItem"];
        self.key = [aDecoder decodeObjectForKey:@"key"];
        self.uiStyle = [aDecoder decodeIntegerForKey:@"uiStyle"];
        self.order = [aDecoder decodeIntegerForKey:@"order"];
    }
    
    return self;
}
@end
