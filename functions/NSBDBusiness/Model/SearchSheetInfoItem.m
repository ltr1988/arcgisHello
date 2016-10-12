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

-(void) setData:(TitleItem *)data
{
    _data = data;
    if ([data isKindOfClass:[TitleInputItem class]]) {
        _uiStyle = SheetUIStyle_ShortText;
    }else if ([data isKindOfClass:[TitleDetailTextItem class]]) {
        _uiStyle = SheetUIStyle_Text;
    }else if ([data isKindOfClass:[TitleDateItem class]]) {
        _uiStyle = SheetUIStyle_Date;
    }else if ([data isKindOfClass:[TitleDetailItem class]]) {
        _uiStyle = SheetUIStyle_ReadonlyText;
    }else if ([data isKindOfClass:[CheckableTitleItem class]]) {
        _uiStyle = SheetUIStyle_Switch;
    }
}

-(void) setTitle:(NSString *)title
{
    switch (_uiStyle) {
        case SheetUIStyle_ReadonlyText: {
            _data = [TitleDetailItem itemWithTitle:title detail:@""];
            break;
        }
        case SheetUIStyle_ShortText: {
            _data = [TitleInputItem itemWithTitle:title placeholder:[NSString stringWithFormat:@"请填写%@",title]];
            break;
        }
        case SheetUIStyle_Text: {
            _data = [TitleDetailTextItem itemWithTitle:title detail:@"未填写" text:@""];
            break;
        }case SheetUIStyle_Date: {
            NSDateFormatter *formater = [[NSDateFormatter alloc] init];
            
            [formater setDateFormat:@"yyyy-MM-dd"];
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

-(TitleItem *) dataWithStyle:(SheetUIStyle)uiStyle
{
    switch (uiStyle) {
        case SheetUIStyle_ReadonlyText: {
            return [TitleDetailItem itemWithTitle:@"" detail:@""];
            break;
        }
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
