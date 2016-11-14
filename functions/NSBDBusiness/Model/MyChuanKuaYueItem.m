//
//  MyChuanKuaYueItem.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/11/13.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MyChuanKuaYueItem.h"
#import "MyChuanKuaYueListItemCell.h"
#import "AttachmentItem.h"
@implementation MyChuanKuaYueItem


+ (NSDictionary *)replacedKeyFromPropertyName

{
    return @{
             @"theId":@"ID",
             @"acrossId" :@"ACROSSID",
             @"acrossCode" :@"ACROSSCODE",
             @"constructionUnit" :@"CONSTRUCTIONUNIT",
             @"supervisoryUnit" :@"SUPERVISORYUNIT",
             @"safetyMonitorUnit" :@"SAFETYMONITORUNIT",
             @"mileNum" :@"MILENUM",
             @"positionDescription" :@"POSITIONDESCRIPTION",
             @"poiX" :@"POIX",
             @"poiY" :@"POIY",
             @"constructionPeriod" :@"CONSTRUCTIONPERIOD",
             
             @"declarationStatement" :@"DECLARATIONSTATEMENT",
             @"changeStatus":@"CHANGESTATUS",
             @"effectiveState" :@"EFFECTIVESTATE",
             @"changeTimes":@"CHANGETIMES",
             @"projectEnd" :@"PROJECTEND",
             @"name":@"NAME",
             @"type" :@"TYPE",
             @"num":@"NUM",
             @"data" :@"DATA",
             @"receiver":@"RECEIVER",
             @"receiverId" :@"RECEIVERID",
             @"applicant":@"APPLICANT",
             @"managementOpinion" :@"MANAGEMENTOPINION",
             @"nsbdbOpinion":@"NSBDBOPINION",
             @"record" :@"RECORD",
             @"other":@"OTHER",
             @"deptCode" :@"DEPTCODE",
             @"isDel":@"ISDEL",
             @"applyDate" :@"APPLYDATE",
             @"addTime":@"ADDTIME.time",
             @"receiveDate" :@"RECEIVEDATE",
             
             @"pass" :@"PASS",
             @"unit":@"UNIT",
             @"contact" :@"CONTACT",
             @"isAccept":@"ISACCEPT",
             @"state" :@"STATE",
             @"fileList":@"FILELIST",
             };
    
}

+(NSDictionary *) objectClassInArray
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:[AttachmentItem class] forKey:@"fileList"];
    return dict;
}
@end


@implementation MyChuanKuaYueItem (CellModel)

- (NSString *) cellTitle
{
    return self.name;
}
- (NSString *) cellUnit
{
    return self.constructionUnit.length>0?self.constructionUnit:@"无";
}
- (NSString *) cellLocation
{
    return self.other.length>0?self.other:@"无";
}
@end
