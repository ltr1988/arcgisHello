//
//  MapViewController+InfoMapping.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/10/11.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapViewController+InfoMapping.h"

@implementation MapViewController (InfoMapping)

-(BOOL) shouldFilter:(NSString *) key
{
    return [[self filterSet] containsObject:[key lowercaseString]];
}

-(NSSet *) filterSet
{
    return [NSSet setWithArray:@[@"sysfeatureid",
                                   @"sysfeaturegeometry",
                                   @"order_id",
                                   @"objectnum",
                                   @"objtypenum",
                                   @"belongenum",
                                   @"manenum",
                                   @"statusnum",
                                   @"BelongGQ",
                                   @"usorienum",
                                   @"usresenum",
                                   @"nusorienum",
                                   @"nusresenum",]];
    
}

-(NSString *) stringFromInfoKey:(NSString *) key
{
    NSString *retStr = [self mappingDict][key.lowercaseString];
    if (retStr) {
        return retStr;
    }
    return key;
}

-(NSDictionary *) mappingDict
{
    return
    @{
      @"sysfeatureid":@"id(主键)",
      @"sysfeaturegeometry":@"几何对象",
      @"order_id":@"排序编号",
      @"name":@"名称",
      @"objectnum":@"设施编号",
      @"objtype":@"设施类型",
      @"objtypenum":@"设施类型编号",
      @"belonge":@"从属工程",
      @"belongenum":@"从属工程编号",
      @"mane":@"管理单位",
      @"manenum":@"管理单位编号",
      @"status":@"建设状态",
      @"statusnum":@"状态编号",
      @"belonggq":@"所属干支渠代码",
      @"investment":@"工程投资",
      @"location":@"地理位置",
      @"milenum":@"桩号",
      @"usorie":@"正常调水上游工程",
      @"usorienum":@"正常调水上游工程代码",
      @"usrese":@"正常调水下游工程",
      @"usresenum":@"正常调水下游工程代码",
      @"nusorie":@"应急调水上游工程",
      @"nusorienum":@"应急调水上游工程代码",
      @"nusrese":@"应急调水下游工程",
      @"nusresenum":@"应急调水下游工程代码",
      @"name_chn":@"单位名称",
      @"name_eng":@"单位英文名称",
      @"address":@"单位地址",
      @"zip_code":@"单位邮编",
      @"numofstaff":@"在职职工人数",
      @"profile":@"单位简介",
      @"hoistform":@"启闭机型式",
      @"hoistcount":@"启闭机数量",
      @"hoistv":@"启闭机启门容量",
      @"length":@"长度",
      @"deslength":@"设计长度",
      @"emnedmann":@"管线埋设方式",
      @"solutions":@"输水方式",
      @"indiameter":@"内径",
      @"first":@"一衬",
      @"second":@"二衬",
      @"maxslope":@"最大纵坡",
      @"pressure":@"洞顶以上压力水头",
      @"introduct":@"工程简介",
      @"ownership":@"产权单位",
      @"width":@"宽度",
      @"area":@"占地面积",
      @"maccount":@"机组台数",
      @"desflow":@"设计流量",
      @"owflow":@"自流流量",
      @"maxflow":@"最大流量",
      @"head":@"扬程",
      @"wmaxh":@"总扬程",
      @"ucapacity":@"单机容量",
      @"ipcapacity":@"总装机容量",
      @"minh":@"最低水位",
      @"desh":@"设计水位",
      @"maxh":@"最大水位",
      @"desminh":@"设计低水位",
      @"desmaxh":@"设计高水位",
      @"dessh":@"设计蓄水位",
      @"highlevel":@"最高蓄水位",
      @"foredesh":@"前池（进水口）设计水位",
      @"foretwl":@"前池最高水位",
      @"forelwl":@"前池最低水位",
      @"ofcdesh":@"出水渠设计水位",
      @"octdesh":@"出水渠最高运行水位",
      @"ofcldesh":@"出水渠最低运行水位",
      @"bottomalti":@"底板高程",
      @"grolevel":@"地面高程",
      @"v":@"总容积",
      @"vh":@"调蓄水量",
      @"uscapacity":@"有效库容",
      @"strform":@"结构形式",
      @"fbelev":@"进口池底高程",
      @"telev":@"池顶高程",
      @"cplevel":@"管中心高程",
      @"size":@"管径或尺寸型号",
      @"diameter":@"管径",
      @"gdtype":@"管道类型及规格",
      @"gddiameter":@"管道直径",
      @"depth":@"井深",
      @"emexit":@"排水出口",
      @"dpdiameter":@"分水管管径",
      @"vdiameter":@"与主隧洞相交的垂直钢管直径（mm）",
      @"diam_gro":@"距地面 5.6m 钢管直径（mm）",
      @"change_dia":@"渐变后钢管直径（mm）",
      @"dpcmeter":@"分水支管中心距",
      @"dpflow":@"分水流向",
      @"hou_s":@"管理用房面积（m²）",
      @"clevel":@"主管中心高程（m）",
      @"dpclevel":@"分水管中心高程（m）",
      @"sinpiplen":@"单管长度",
      @"wblevel":@"井底板高程",
      @"rooflevel":@"顶板高程",
      @"channel":@"排入河道",
      @"cplevel":@"主管中心高程",
      @"grolevel":@"地面高程",
      @"cpplevel":@"泵管中心高程",
      @"rblevel":@"护砌河底高程",
      @"type":@"水厂类型",
      @"scale":@"水厂规模",
      @"nsbdscale":@"南水北调工程供水规模",
      @"oriobjname":@"通水前水源地",
      @"resobje":@"通水后来水工程",
      @"resobjenum":@"通水后来水工程代码",
      @"oridivname":@"来水分水口",
      @"oridivnum":@"来水分水口编码",
      @"inputdate":@"投入运行时间",
      @"servscope":@"服务范围",
      @"nearbldg":@"临近建筑物",
      @"cptt":@"主管中心至包封顶高度",
      @"bottomalt":@"阀井底高程",
      @"height":@"排空井高度",
      @"thickness":@"排空井壁厚度",
      @"owplevel":@"出水管中心高程",
      @"wtlevel":@"阀井顶板高程",
      @"whheight":@"排空井井筒高度",
      @"soilth":@"覆土厚度",
      @"angle":@"角度",
      @"distance":@"阀井中心至竖向折点距离",
      @"cheight":@"排空井墙顶高程",
      @"5yfs":@"5年洪水位",
      @"50yfs":@"50年洪水位",
      @"100yfs":@"100年洪水位",
      @"200yfs":@"200年洪水位",
      @"300yfs":@"300年洪水位",
      @"wspacing":@"井间距",
      @"pipc_level":@"管中心高程",
      @"waterflow":@"供水流向",
      @"waterdesh":@"设计取水流量",
      @"blevel":@"坝底高程",
      @"tlevel":@"坝顶高程",
      @"form":@"闸门形式",
      @"addtraffic":@"加大流量",
      @"topheight":@"闸顶高程",
      @"blevel":@"底坎高程",
      @"tfcapacity":@"总过流能力",
      @"datatime":@"数据采集时间",
      @"orid_time":@"数据来源时间",
      @"remarks":@"备注",
      };
    
}


@end
