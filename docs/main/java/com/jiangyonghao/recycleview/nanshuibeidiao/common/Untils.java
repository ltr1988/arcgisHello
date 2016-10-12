package com.jiangyonghao.recycleview.nanshuibeidiao.common;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.os.Handler;
import android.os.Message;
import android.os.SystemClock;
import android.support.v7.app.AlertDialog;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.animation.AnticipateOvershootInterpolator;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.CompoundButton;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.Switch;
import android.widget.TextView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.Baseactivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.GridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Bimp;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ItemChoice;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ItemSingleChoice;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Mstore;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.DeleteShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.GpsKaiqi;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.wheel.StrericWheelAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.wheel.WheelView;

import org.json.JSONArray;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.x;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.lang.reflect.Type;
import java.math.BigDecimal;
import java.net.URISyntaxException;
import java.security.MessageDigest;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * Created by jiangyonghao on 2016/8/13.
 */
public class Untils {
    private static String dataurl1 = "http://restapi.amap.com/v3/geocode/regeo?output=json&location=";
    private static String dataurl2 = "&key=2ca1bf84428d8e3839ce7bf1cd12a2ab";
    private static String URL = "http://api.map.baidu.com/telematics/v3/weather?location=";
    private static String AK = "V7vGpr4PQSwLrlnVsImdPhP5";
    private static String MCODE = "45:48:E3:7A:56:E0:62:BA:0D:C2:CA:CE:01:35:11:FE:FC:62:2B:EB;com.at21.zrbh_ywxh";
    public static String SDpath = Environment.getExternalStorageDirectory().getAbsolutePath() + "/21at/南水北调/";
    public static String path = "/21at/南水北调/";
    public static String database = "southwatertonorth.db";
    public static String databasefoldername = "database/";
    public static String[] attachmentform = {"id", "time", "type", "path", "name", "isupload", "xiangdui", "cuntype", "fkid"};
    public static String[] inspectionmessage = {"id", "starttime", "endtime", "timekeeping", "executor", "auditor", "weather", "isnew", "exetime", "name"};
    public static String[] linepipe = {"id", "starttime", "stakestart", "stakeend", "issurvey", "isbuild", "ishavewater", "istrap", "ischange", "problem", "dealmethod", "isupload", "type", "titletime", "exedate", "weather", "createtime", "taskid", "isdamage"};
    public static String[] emergencyform = {"id", "starttime", "endtitme", "title", "category", "eventnature", "responseLevel", "reasons", "occurTime", "occurLocation", "eventcoord", "eventdepartment", "eventperson", "description", "eventrealcase", "type", "isupload", "taskid", "address","alarmPerson","alarmPersonContacts","spacePosition_x","spacePosition_y","reportToID","dispenseToID","distributeUserID"};
    public static String[] searchform = {"id", "islocate", "createtime", "name", "poix", "poiy","plevel","objectnum","objtype","manenum","mane","belongenum","belonge","objtypenum","objectid"};
    public static String[] daningjing = {"taskid", "id", "type", "createtime", "starttime", "exedate", "wellnum", "handgateleft", "handgateright", "airgateleft", "airgateright", "pondleft", "pondright", "warmleft", "warmright", "negativeleft", "negativelright", "environment", "weather", "gatetemperatureleft", "gatetemperatureright", "welltemperatureleft", "welltemperatureright", "remark", "isupload"};
    public static String[] dongganqufenshui = {"taskid", "id", "type", "createtime", "starttime", "isupload", "wellnum", "dryline_creepwell", "dryline_crawl", "dryline_wall", "dryline_bottom", "dryline_health", "dryline_flygate", "dryline_connect", "dryline_handgate", "dryline_sluice", "branch_creepwell", "branch_crawl", "branch_wall", "branch_bottom", "branch_health", "branch_connect", "branch_sluice", "measure_creepwell", "measure_crawl", "measure_wall", "measure_bottom", "measure_health", "measure_connect", "remark", "exedate"};
    public static String[] dongganqupaikong = {"taskid", "id", "type", "createtime", "starttime", "isupload", "wellnum", "dry_creepwell", "dry_crawl", "dry_wall", "dry_bottom", "dry_health", "dry_flygate", "dry_connect", "dry_handgate", "dry_sluice", "wet_creepwell", "wet_crawl", "wet_wall", "wet_bottom", "wet_health", "wet_drain", "water_creepwell", "water_crawl", "water_wall", "water_bottom", "water_health", "water_tillgate", "water_flygate", "water_connect", "remark", "exedate"};
    public static String[] dongganqupaiqi = {"taskid", "id", "type", "createtime", "starttime", "isupload", "wellnum", "over_crawl", "over_ground", "over_blowhole", "over_welllid", "over_health", "under_ladder", "under_guardrail", "under_wall", "unde_health", "unde_airgate", "unde_sluicegate", "unde_ballgate", "under_bottom", "remark", "exedate"};
    public static String[] nanganquguanxian = {"taskid", "id", "type", "createtime", "starttime", "isupload", "stake_drop", "stake_rustiness", "stake_dip", "water_ground", "water_nearby", "water_part", "water_fountain", "rules_plant", "rules_build", "rules_way", "rules_stack", "rules_burst", "rules_solid", "rules_chem", "rules_drain", "rules_other", "remark", "exedate","location"};
    //    public static String[] nanganqupaikongshang={"taskid","id","type","createtime","starttime","isupload","wellnumber","date","jinchang","weilan","huwai","shoujing","tongqi","shinei","jinggai","jingshi","pati","jianxiu","work","chukou","remark"};
    public static String[] nanganqupaikong = {"taskid", "id", "type", "createtime", "starttime", "isupload", "wellnum", "weather", "exedate", "march", "crawl", "deviceroom", "handwell", "arihole", "temperatureout", "temperaturein", "welllid", "ladder", "wellroom", "repairgate", "workgate", "exitgate", "remark"};
    public static String[] nanganqupaiqi = {"taskid", "id", "type", "createtime", "starttime", "isupload", "wellnum", "weather", "exedate", "march", "crawl", "deviceroom", "handwell", "arihole", "right_temperatureinh", "right_welllid", "right_wellroom", "right_ladder", "right_gate", "right_temperatureinl", "left_temperatureinh", "left_welllid", "left_wellroom", "left_ladder", "left_gate", "left_temperatureinl", "temperaturein", "temperatureout", "welllid", "wellroom", "ladder", "gate", "remark"};
    public static ItemChoice[] daningpaikongjingInfo = {new ItemChoice("手阀情况", "左手阀", false, "右手阀", false), new ItemChoice("空气阀情况", "左手阀", false, "右手阀", false), new ItemChoice("积水情况", "左手阀", false, "右手阀", false), new ItemChoice("保温设施", "左手阀", false, "右手阀", false), new ItemChoice("阴极保护", "左手阀", false, "右手阀", false)};//大宁排空井的左手阀右手阀实体内容
    public static String[] daningpaikongjingSwitch = {"手阀情况", "空气阀情况", "积水情况", "保温设施", "阴极保护", "左手阀", "右手阀"};//大宁排空井的左手阀右手阀实体内容
    //    public static String[] nanganqupaiqixia={"taskid","id","type","createtime","starttime","isupload","wellnumber","date","jinchang","weilan","huwai","shoujing","tongqi","shiwai","shinei","jinggai","futi","jingshi","fati","remark"};
//    public static String nanganpaiqixia = "nanganpaiqixia";
    public static String nanganpaiqishang = "nanganpaiqi";//南干渠排气阀井
    public static String nanqupaikongxia = "nanqupaikong";//南干渠排空井
    //    public static String nanqupaikongshang = "nanqupaikongshang";
    public static String nanganlinepipe = "nanganlinepipe";//南干渠管线
    public static String dongganpaiqi = "dongganpaiqi";
    public static String dongganpaikong = "dongganpaikong";
    public static String dongganqufen = "dongganqufenshui";
    public static String daning = "daning";
    public static String search = "searchrecord";
    public static String fujian = "attachmentform";
    public static String xunchaxinxi = "inspectionmessage";
    public static String guanxian = "linepipe";
    public static String tufashijian = "emergencyform";
    public static String fujianpath = "attachment";
    public static String tufaType = "突发上报";
    public static String daningguanxianType = "大宁管线";
    public static String dongganquguanxianType = "东干渠管线";
    public static String nanganquguanxianType = "南干渠管线";
    public static boolean daningdouble = false;//false默认为大宁排空井
    public static String daningpaikongjing = "大宁排空井";
    public static String daningpaiqifajing = "大宁排气阀井";
    public static String nanganqupaikongjingshang = "南干渠排空井上段";
    public static String nanganqupaikongjingxia = "南干渠排空井下段";
    public static String nanganqupaiqifashang = "南干渠排气阀上段";
    public static String nanganqupaiqifaxia = "南干渠排气阀下段";
    public static String guanxianleibiao = "管线列表";
    public static String xunchaType = "巡查对象";
    public static String noupload = "0";//未上报
    public static String upload = "1";//以上报
    public static String starttime, starttime1;//开始计时时间
    public static String biaoid;
    public static String taskid;
    //    public static boolean isdaningUncompleted = false;//当前大宁管线表是否完成
//    public static boolean isdongganquUncompleted = false;//当前东干渠管线表是否完成
    public static boolean isUncompletednanganqupaiqifa = false;//当前南干渠排气阀井表是否完成
    public static String defaultSwitch = "0";//默认没选中的
    public static String choiceSwitch = "1";//选中的
    public static String time;
    public static String videotype;
    public static String caremtype;
    public static String zhaopian = "照片";
    public static String shipin = "视频";
    public static String panbie = "0";
    public static HelperDb helperDb;
    public static InputMethodManager imm;
    public static Boolean SEARCHMODE = false;//点击主界面进入搜索模式
    public static String[] shijianlxInfo = { "水质污染","工程安全","应急调度","防汛抢险"};
    public static String[] shijianxzInfo = {"水质污染", "工程损害", "机电故障"};
    public static String[] dengjicpInfo = {"一级响应","二级响应","三级响应","四级响应","五级响应"};
    public static String[] chubuyyInfo = {"人为", "原因2", "原因3"};
    public static int minYear = 1970;  //最小年份
    public static int fontSize = 13;     //字体大小
    public static WheelView yearWheel, monthWheel, dayWheel, hourWheel, minuteWheel, secondWheel;
    public static String[] yearContent = null;
    public static String[] monthContent = null;
    public static String[] dayContent = null;
    public static String[] hourContent = null;
    public static String[] minuteContent = null;
    public static String[] secondContent = null;
    public static String dongganqupaiqiType = "东干渠排气井";
    public static String dongganqupaikongType = "东干渠排空井";
    public static String dongganqufenshuiType = "东干渠分水口";
    //东干渠排气
    public static String[] dongganqupaiqishangname = {"围栏", "地面", "气孔", "井盖", "卫生"};
    public static String[] dongganqupaiqixianame = {"爬梯", "护栏", "井壁", "井底", "气阀", "闸阀", "球阀", "卫生"};
    public static String[] dongganqupaiqishangkey = {"over_crawl", "over_ground", "over_blowhole", "over_welllid", "over_health"};
    public static String[] dongganqupaiqixiakey = {"under_ladder", "under_guardrail", "under_wall", "under_bottom", "unde_airgate", "unde_sluicegate", "unde_ballgate", "unde_health"};

    //东干渠排空
    public static String[] dongganqupaikongganname = {"爬井", "围栏", "井壁", "井底", "卫生", "电动蝶阀", "伸缩接头", "手动蝶阀", "电动闸阀"};
    public static String[] dongganqupaikongshiname = {"爬井", "围栏", "井壁", "井底", "卫生", "潜水排污泵"};
    public static String[] dongganqupaikongchuname = {"爬井", "围栏", "井壁", "井底", "卫生", "蝶式止回阀", "电动蝶阀", "伸缩接头"};
    public static String[] dongganqupaikonggankey = {"dry_creepwell", "dry_crawl", "dry_wall", "dry_bottom", "dry_health", "dry_flygate", "dry_connect", "dry_handgate", "dry_sluice"};
    public static String[] dongganqupaikongshikey = {"wet_creepwell", "wet_crawl", "wet_wall", "wet_bottom", "wet_health", "wet_drain"};
    public static String[] dongganqupaikongchukey = {"water_creepwell", "water_crawl", "water_wall", "water_bottom", "water_health", "water_tillgate", "water_flygate", "water_connect"};
    //东干渠出水阀井
    public static String[] dongganqufenshuiganname = {"爬井", "围栏", "井壁", "井底", "卫生", "电动蝶阀", "伸缩接头", "手动蝶阀", "手动球阀"};
    public static String[] dongganqufenshuizhiname = {"爬井", "围栏", "井壁", "井底", "卫生", "伸缩接头", "电动蝶阀"};
    public static String[] dongganqufenshuicename = {"爬井", "围栏", "井壁", "井底", "卫生", "流量计"};
    public static String[] dongganqufenshuigankey = {"dryline_creepwell", "dryline_crawl", "dryline_wall", "dryline_bottom", "dryline_health", "dryline_flygate", "dryline_connect", "dryline_handgate", "dryline_sluice"};
    public static String[] dongganqufenshuizhikey = {"branch_creepwell", "branch_crawl", "branch_wall", "branch_bottom", "branch_health", "branch_connect", "branch_sluice"};
    public static String[] dongganqufenshuicekey = {"measure_creepwell", "measure_crawl", "measure_wall", "measure_bottom", "measure_health", "measure_connect"};
    public static String qishiaddress;
    public static String zhongdianaddress;
    public static double zhonglon, zhonglat;
    public static String RealTimeTitle = "标题";
    public static String RealTimeTime = "时间";
    public static String RealTimeACTitle = "实时数据";
    public static String[] RealTimeInfo = {"实时雨情", "实时水位", "水库水情", "实时流量", "水质数据", "工程安全数据","实时数据"};
    public static int[] mi = {0, 10, 25, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 30000, 50000, 100000, 200000, 500000, 1000000};
    public static boolean isWode = false;
    public static boolean isLuxian = false;
    //我的工作列表
    public static String[] myWork = {"待办应急事件", "我的处置任务", "我的事件上报", "历史巡查记录"};
    public static boolean isusername = false;

    public static Map biaoming() {
        Map map = new HashMap();
        map.put("NGQPKJUP", "南干渠排空井上段");
        map.put("NGQPKJDOWN", "南干渠排空井下段");
        map.put("NGQPQJUP", "南干渠排气阀井上段");
        map.put("NGQPQJDOWN", "南干渠排气阀井下段");
        map.put("NGQGX", "南干渠管线");
        map.put("DGQPQJ", "东干渠排气阀井");
        map.put("DGQFSK", "东干渠分水口");
        map.put("DGQPKJ", "东干渠排空井");
        map.put("DGQGX", "东干渠管线");
        map.put("DNPKJ", "大宁排空井");
        map.put("DNPQJ", "大宁排气阀井");
        map.put("DNGX", "大宁管线");
        return map;
    }

    /**
     * 折算评分
     */
    public static double zhesuan(double zuobiao) {
        BigDecimal bg = new BigDecimal(zuobiao);
        double f1 = bg.setScale(4, BigDecimal.ROUND_HALF_UP).doubleValue();
        return f1;
    }

    public static String shibie(String s) {
        String string = "";
        switch (s) {
            case "100":
                string = "请求成功";
                break;
            case "200":
                string = "请求失败";
                break;
            case "300":
                string = "服务端异常，请联系管理员";
                break;
            case "301":
                string = "参数错误，请检查参数完整性";
                break;
            case "302":
                string = "版本号错误";
                break;
            case "303":
                string = "非法的执行语法与参数";
                break;
            case "304":
                string = "不合法的用户";
                break;
            case "305":
                string = "非法的签名信息";
                break;
        }
        return string;
    }

    //表对应的字段
    public static HashMap setmap() {
        HashMap map = new HashMap();
        map.put(daningguanxianType, guanxian);
        map.put(daningpaikongjing, daning);
        map.put(daningpaiqifajing, daning);
        map.put(dongganquguanxianType, guanxian);
        map.put(dongganqupaikongType, dongganpaikong);
        map.put(dongganqupaiqiType, dongganpaiqi);
        map.put(dongganqufenshuiType, dongganqufen);
        map.put(nanganquguanxianType, nanganlinepipe);
        map.put(nanganqupaikongjingshang, nanqupaikongxia);
        map.put(nanganqupaikongjingxia, nanqupaikongxia);
        map.put(nanganqupaiqifashang, nanganpaiqishang);
        map.put(nanganqupaiqifaxia, nanganpaiqishang);
        return map;
    }

    //地图tiaozhuan
    public static void ditu(Context context, Mstore mstore) {
        Log.e("dd", "ditu: " + "&slat=" + mstore.getSlat() +
                "&slon=" + mstore.getSlon() +
                "&sname=" + mstore.getSad() +
                "&dlat=" + mstore.getDlat() +
                "&dlon=" + mstore.getDlon() +
                "&dname=" + mstore.getDad());
        Intent intent = new Intent();
        if (StringUntils.isInstalled(context, "com.autonavi.minimap")) {
            intent.setData(Uri
                    .parse("androidamap://route?" +
                            "sourceApplication=softname" +
                            "&slat=" + mstore.getSlat() +
                            "&slon=" + mstore.getSlon() +
                            "&sname=" + mstore.getSad() +
                            "&dlat=" + mstore.getDlat() +
                            "&dlon=" + mstore.getDlon() +
                            "&dname=" + mstore.getDad() +
                            "&dev=0" +
                            "&m=0" +
                            "&t=2"));
            context.startActivity(intent);
        } else if (StringUntils.isInstalled(context, "com.baidu.BaiduMap")) {
            try {
                intent = Intent.parseUri("intent://map/direction?" +
                        "origin=latlng:" + mstore.getSlat() + "," + mstore.getSlon() +
                        "|name:" + mstore.getSad() +
                        "&destination=latlng:" + mstore.getDlat() + "," + mstore.getDlon() +
                        "|name:" + mstore.getDad() +
                        "&mode=driving" +
                        "&src=Name|AppName" +
                        "#Intent;scheme=bdapp;package=com.baidu.BaiduMap;end", 0);
            } catch (URISyntaxException e) {
                Log.e("URISyntaxException : ", e.getMessage());
                e.printStackTrace();
            }
            context.startActivity(intent);
        } else {
            ToastShow.setShow(context, "请安装地图软件");
        }
    }

    public static List<ItemSingleChoice> BiaodanInfo(String name[], String key[]) {
        List<ItemSingleChoice> dongganqu = new ArrayList<>();
        for (int i = 0; i < name.length; i++) {
            ItemSingleChoice singleChoice = new ItemSingleChoice(name[i], false, key[i]);
            dongganqu.add(singleChoice);
        }
        return dongganqu;
    }


    //蒋勇豪添加
    public static String setkm(double s) {
//        Log.e("ss",s/1000+"");
        for (int i = 0; i < mi.length - 1; i++) {
            if (mi[i] < (int) s && (int) s <= mi[i + 1]) {
                if (mi[i + 1] / 1000 >= 1) {
                    return mi[i + 1] / 1000 + "公里";
                } else {
                    return mi[i + 1] + "米";
                }
            }
        }
        return 100 + "米";
    }

    public static int setjuli(double s) {
//        Log.e("ss",s/1000+"");
        for (int i = 0; i < mi.length - 1; i++) {
            if (mi[i] < (int) s && (int) s <= mi[i + 1]) {
                if (mi[i + 1] / 1000 >= 1) {
                    return mi[i + 1] / 1000 - (int) s / 1000;
                } else {
                    return mi[i + 1] - (int) s;
                }
            }
        }
        return 0;
    }

    public static String[] loginkey = {"userName", "userPwd", "model", "serialnumber", "devicename", "systemnumber"};
    public static boolean issave = false;

    public static void setIssave() {
        Untils.issave = false;
    }

    /**
     * 公用实时保存
     */
    public static void setEditClick(Context context, EditText ed, final String ID, final String key, final String table) {
        final HelperDb helperDb = new HelperDb(context);
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                helperDb.update(ID, key, s.toString(), table);
                if (!"".equals(s.toString()) && s.toString() != null) {
                    Untils.issave = true;
                }
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    public static void setSwitchClick(final Context context, Switch sw, final String ID, final String key, final String table) {
        final HelperDb helperDb = new HelperDb(context);
        sw.setOnCheckedChangeListener(new CompoundButton.OnCheckedChangeListener() {
            @Override
            public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {


                if (isChecked) {
                    helperDb.update(ID, key, Untils.choiceSwitch, table);
                    Untils.issave = true;
//                    setHidden(context);
                } else {
                    helperDb.update(ID, key, Untils.defaultSwitch, table);
//                    setHidden(context);
                }
            }
        });
    }

    public static void setTextClick(Context context, TextView ed, final String ID, final String key, final String table) {
        final HelperDb helperDb = new HelperDb(context);
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                helperDb.update(ID, key, s.toString(), table);
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }


    /**
     * 突发上报时间选择器
     */
    public static void setShiJian(Context context, final int type, final TextView tex) {
        initContent();
        View view = ((LayoutInflater) context.getSystemService(context.LAYOUT_INFLATER_SERVICE)).inflate(R.layout.time_picker, null);
        Calendar calendar = Calendar.getInstance();
        int curYear = calendar.get(Calendar.YEAR);
        int curMonth = calendar.get(Calendar.MONTH) + 1;
        int curDay = calendar.get(Calendar.DAY_OF_MONTH);
        int curHour = calendar.get(Calendar.HOUR_OF_DAY);
        int curMinute = calendar.get(Calendar.MINUTE);
        int curSecond = calendar.get(Calendar.SECOND);
        TextView shi, fen, miao;
        shi = (TextView) view.findViewById(R.id.shi);
        fen = (TextView) view.findViewById(R.id.fen);
        miao = (TextView) view.findViewById(R.id.miao);
        yearWheel = (WheelView) view.findViewById(R.id.yearwheel);
        monthWheel = (WheelView) view.findViewById(R.id.monthwheel);
        dayWheel = (WheelView) view.findViewById(R.id.daywheel);
        hourWheel = (WheelView) view.findViewById(R.id.hourwheel);
        minuteWheel = (WheelView) view.findViewById(R.id.minutewheel);
        secondWheel = (WheelView) view.findViewById(R.id.secondwheel);
        TextView textView = (TextView) view.findViewById(R.id.picktimeTv);
        Button sureBtn = (Button) view.findViewById(R.id.sure);

        final Dialog dialog = new Dialog(context);

        DisplayMetrics dm = new DisplayMetrics();
        ((Activity) context).getWindowManager().getDefaultDisplay().getMetrics(dm);
        int screenWidth = dm.widthPixels;


        dialog.requestWindowFeature(Window.FEATURE_NO_TITLE);
        dialog.setContentView(view, new ViewGroup.LayoutParams(screenWidth - 200, ViewGroup.LayoutParams.WRAP_CONTENT));


        yearWheel.setAdapter(new StrericWheelAdapter(yearContent));
        if (tex.getText().toString().split("-").length < 3) {
            yearWheel.setCurrentItem(curYear - 2013);
        } else {
            yearWheel.setCurrentItem(Integer.parseInt(tex.getText().toString().trim().split("-")[0].toString()) - 2013);
        }
        yearWheel.setCyclic(true);
        yearWheel.setInterpolator(new AnticipateOvershootInterpolator());
        monthWheel.setAdapter(new StrericWheelAdapter(monthContent));
        if (tex.getText().toString().split("-").length < 3) {
            monthWheel.setCurrentItem(curMonth - 1);
        } else {
            monthWheel.setCurrentItem(Integer.parseInt(tex.getText().toString().trim().split("-")[1].toString()) - 1);
        }
        monthWheel.setCyclic(true);
        monthWheel.setInterpolator(new AnticipateOvershootInterpolator());
        dayWheel.setAdapter(new StrericWheelAdapter(dayContent));
        if (tex.getText().toString().split("-").length < 3) {
            dayWheel.setCurrentItem(curDay - 1);
        } else {
            if (tex.getText().toString().split(":").length < 3) {
                dayWheel.setCurrentItem(Integer.parseInt(tex.getText().toString().trim().split("-")[2].toString()) - 1);
            } else {
                dayWheel.setCurrentItem(Integer.parseInt(tex.getText().toString().trim().split("-")[2].split(" ")[0].toString()) - 1);
            }

        }

        dayWheel.setCyclic(true);
        dayWheel.setInterpolator(new AnticipateOvershootInterpolator());

        hourWheel.setAdapter(new StrericWheelAdapter(hourContent));
        if (type != 1 && tex.getText().toString().split("-").length == 3) {
            hourWheel.setCurrentItem(Integer.parseInt(tex.getText().toString().trim().split("-")[2].split(" ")[1].split(":")[0].toString()));
        } else {
            hourWheel.setCurrentItem(curHour);
        }
        hourWheel.setCyclic(true);
        hourWheel.setInterpolator(new AnticipateOvershootInterpolator());

        minuteWheel.setAdapter(new StrericWheelAdapter(minuteContent));
        if (type != 1 && tex.getText().toString().split("-").length == 3) {
            minuteWheel.setCurrentItem(Integer.parseInt(tex.getText().toString().trim().split("-")[2].split(" ")[1].split(":")[1].toString()));
        } else {
            minuteWheel.setCurrentItem(curMinute);
        }
        minuteWheel.setCyclic(true);
        minuteWheel.setInterpolator(new AnticipateOvershootInterpolator());

        secondWheel.setAdapter(new StrericWheelAdapter(secondContent));
        if (type != 1 && tex.getText().toString().split("-").length == 3) {
            secondWheel.setCurrentItem(Integer.parseInt(tex.getText().toString().trim().split("-")[2].split(" ")[1].split(":")[2].toString()));
        } else {
            secondWheel.setCurrentItem(curSecond);
        }
        secondWheel.setCyclic(true);
        secondWheel.setInterpolator(new AnticipateOvershootInterpolator());
        if (type == 1) {
            hourWheel.setVisibility(View.GONE);
            minuteWheel.setVisibility(View.GONE);
            secondWheel.setVisibility(View.GONE);
            shi.setVisibility(View.GONE);
            fen.setVisibility(View.GONE);
            miao.setVisibility(View.GONE);
        } else {
            hourWheel.setVisibility(View.VISIBLE);
            minuteWheel.setVisibility(View.VISIBLE);
            secondWheel.setVisibility(View.VISIBLE);
            shi.setVisibility(View.VISIBLE);
            fen.setVisibility(View.VISIBLE);
            miao.setVisibility(View.VISIBLE);
        }

        sureBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                StringBuffer sb = new StringBuffer();
                sb.append(yearWheel.getCurrentItemValue()).append("-")
                        .append(monthWheel.getCurrentItemValue()).append("-")
                        .append(dayWheel.getCurrentItemValue());

                sb.append(" ");
                if (type != 1) {
                    sb.append(hourWheel.getCurrentItemValue())
                            .append(":").append(minuteWheel.getCurrentItemValue())
                            .append(":").append(secondWheel.getCurrentItemValue());
                }
                tex.setText(sb);
                dialog.cancel();
            }
        });
        dialog.show();
    }

    public static void initContent() {
        yearContent = new String[10];
        for (int i = 0; i < 10; i++)
            yearContent[i] = String.valueOf(i + 2013);

        monthContent = new String[12];
        for (int i = 0; i < 12; i++) {
            monthContent[i] = String.valueOf(i + 1);
            if (monthContent[i].length() < 2) {
                monthContent[i] = "0" + monthContent[i];
            }
        }

        dayContent = new String[31];
        for (int i = 0; i < 31; i++) {
            dayContent[i] = String.valueOf(i + 1);
            if (dayContent[i].length() < 2) {
                dayContent[i] = "0" + dayContent[i];
            }
        }
        hourContent = new String[24];
        for (int i = 0; i < 24; i++) {
            hourContent[i] = String.valueOf(i);
            if (hourContent[i].length() < 2) {
                hourContent[i] = "0" + hourContent[i];
            }
        }

        minuteContent = new String[60];
        for (int i = 0; i < 60; i++) {
            minuteContent[i] = String.valueOf(i);
            if (minuteContent[i].length() < 2) {
                minuteContent[i] = "0" + minuteContent[i];
            }
        }
        secondContent = new String[60];
        for (int i = 0; i < 60; i++) {
            secondContent[i] = String.valueOf(i);
            if (secondContent[i].length() < 2) {
                secondContent[i] = "0" + secondContent[i];
            }
        }
    }

    /**
     * 隐藏软件盘
     */
    public static void setHidden(Context context) {
        imm = (InputMethodManager) context
                .getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(((Activity) context).getCurrentFocus()
                .getWindowToken(), InputMethodManager.HIDE_NOT_ALWAYS);
    }

    /**
     * 初始化pop以及适配器
     */
    public static GridViewAdapter setpop(Context context, String type, String starttime, GridViewAdapter adapter, GridView pic_mov_GV) {
        adapter = new GridViewAdapter(context);
        pic_mov_GV.setAdapter(adapter);
        Untils.caremtype = type;
        Untils.starttime1 = starttime;
        PhotoTools.InitPop(context);
        adapter.setImage(Baseactivity.tempSelectBitmap, adapter);
        return adapter;
    }

    /**
     * 回显时初始化数据
     */
    public static void setData(HelperDb helper, GridViewAdapter adapter, String starttime, String type, String biaoid) {
        Untils.starttime1 = starttime;
        Untils.biaoid = biaoid;
        Baseactivity.tempSelectBitmap.clear();
        Baseactivity.tempSelectBitmap.addAll(helper.getAttachmentformlist(type, starttime));
        adapter.setImage(Baseactivity.tempSelectBitmap, adapter);
    }

    /**
     * 点击返回要添加的方法
     */
    public static void cleardata() {
        Baseactivity.tempSelectBitmap.clear();
        Baseactivity.shipinlist.clear();
        Baseactivity.zhaopianlist.clear();
        Bimp.tempSelectBitmap.clear();
        Baseactivity.shipinlist.clear();
        Baseactivity.zhaopianlist.clear();
    }

    /**
     * 返回activity中onResume中添加的方法
     */
    public static void setdata(GridViewAdapter adapter) {
        if (Untils.panbie.equals("1")) {
            Baseactivity.tempSelectBitmap.addAll(Bimp.tempSelectBitmap);
            Baseactivity.tempSelectBitmap.addAll(Baseactivity.shipinlist);
        }
    }

    public static void setdata(GridViewAdapter adapter, HelperDb helper, String type) {
//        if (Untils.panbie.equals("1")) {
//            Baseactivity.tempSelectBitmap.addAll(Bimp.tempSelectBitmap);
//            Baseactivity.tempSelectBitmap.addAll(Baseactivity.shipinlist);
//        }
        Baseactivity.tempSelectBitmap.clear();
        Baseactivity.tempSelectBitmap.addAll(helper.getAttachmentformlist(type, starttime1));
        adapter.setImage(Baseactivity.tempSelectBitmap, adapter);
    }

    /**
     * activity中onPause中添加的方法
     */
    public static void clearonpause() {
        if (Untils.panbie.equals("1")) {
            Baseactivity.tempSelectBitmap.clear();
        }
    }

    /**
     * 删除附件
     */
    public static void delete(Context context, String path, int postion, GridViewAdapter adapter, String type) {
        DeleteShow deleteShow = new DeleteShow(context, "是否删除?", path, postion, adapter, type);
        deleteShow.setCanceledOnTouchOutside(false);
        deleteShow.show();
    }

    public static void delete(Context context, String path) {
        helperDb = new HelperDb(context);
        helperDb.deletefujianxiangdui(Untils.starttime, path);
    }

    /**
     * 生成附件表
     *
     * @param s
     * @return
     */
    public static String getAttachmentform(String s) {
        for (int i = 0; i < attachmentform.length; i++) {
            if (i != attachmentform.length - 1) {
                s += attachmentform[i] + " varchar , ";
            } else {
                s += attachmentform[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 生成巡查信息表
     */
    public static String getInspectionmessage(String s) {
        for (int i = 0; i < inspectionmessage.length; i++) {
            if (i != inspectionmessage.length - 1) {
                s += inspectionmessage[i] + " varchar , ";
            } else {
                s += inspectionmessage[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 生成管线表
     */
    public static String getLinepipe(String s) {
        for (int i = 0; i < linepipe.length; i++) {
            if (i != linepipe.length - 1) {
                s += linepipe[i] + " varchar , ";
            } else {
                s += linepipe[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 生成突发事件
     */
    public static String getEmergencyform(String s) {
        for (int i = 0; i < emergencyform.length; i++) {
            if (i != emergencyform.length - 1) {
                s += emergencyform[i] + " varchar , ";
            } else {
                s += emergencyform[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 生成搜索记录表
     */
    public static String getSearchForm(String s) {
        for (int i = 0; i < searchform.length; i++) {
            if (i != searchform.length - 1) {
                s += searchform[i] + " varchar , ";
            } else {
                s += searchform[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 生成大宁排空表
     */
    public static String getDaningjingForm(String s) {
        for (int i = 0; i < daningjing.length; i++) {
            if (i != daningjing.length - 1) {
                s += daningjing[i] + " varchar , ";
            } else {
                s += daningjing[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 东干渠分水口
     */
    public static String getDongganqufenshuiForm(String s) {
        for (int i = 0; i < dongganqufenshui.length; i++) {
            if (i != dongganqufenshui.length - 1) {
                s += dongganqufenshui[i] + " varchar , ";
            } else {
                s += dongganqufenshui[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 东干渠排空井
     */
    public static String getDongganqupaikongForm(String s) {
        for (int i = 0; i < dongganqupaikong.length; i++) {
            if (i != dongganqupaikong.length - 1) {
                s += dongganqupaikong[i] + " varchar , ";
            } else {
                s += dongganqupaikong[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 东干渠排气阀
     */
    public static String getDongganqupaiqiForm(String s) {
        for (int i = 0; i < dongganqupaiqi.length; i++) {
            if (i != dongganqupaiqi.length - 1) {
                s += dongganqupaiqi[i] + " varchar , ";
            } else {
                s += dongganqupaiqi[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 南干渠管线
     */
    public static String getNanganqulinepipeForm(String s) {
        for (int i = 0; i < nanganquguanxian.length; i++) {
            if (i != nanganquguanxian.length - 1) {
                s += nanganquguanxian[i] + " varchar , ";
            } else {
                s += nanganquguanxian[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 南干渠排空上
     */
    public static String getNanganqupaikongshangForm(String s) {
        for (int i = 0; i < nanganqupaikong.length; i++) {
            if (i != nanganqupaikong.length - 1) {
                s += nanganqupaikong[i] + " varchar , ";
            } else {
                s += nanganqupaikong[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 南干渠排空下
     */
//    public static String getNanganqupaikongxiaForm(String s) {
//        for (int i = 0; i < nanganqupaikongxia.length; i++) {
//            if (i != nanganqupaikongxia.length - 1) {
//                s += nanganqupaikongxia[i] + " varchar , ";
//            } else {
//                s += nanganqupaikongxia[i] + " varchar )";
//            }
//        }
//        return s;
//    }

    /**
     * 南干渠排气上
     */
    public static String getNanganqupaiqishangForm(String s) {
        for (int i = 0; i < nanganqupaiqi.length; i++) {
            if (i != nanganqupaiqi.length - 1) {
                s += nanganqupaiqi[i] + " varchar , ";
            } else {
                s += nanganqupaiqi[i] + " varchar )";
            }
        }
        return s;
    }

    /**
     * 南干渠排气下
     */
//    public static String getNanganqupaiqixiaForm(String s){
//        for (int i = 0; i < nanganqupaiqixia.length; i++) {
//            if (i != nanganqupaiqixia.length - 1) {
//                s += nanganqupaiqixia[i] + " varchar , ";
//            } else {
//                s += nanganqupaiqixia[i] + " varchar )";
//            }
//        }
//        return s;
//    }
    //
    public static String setuuid() {
        return UUID.randomUUID().toString();
    }

    public static void Finish(ImageButton view, final Context context) {
        view.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                ((Activity) context).finish();
            }
        });

    }

    public static long setTime(Chronometer chronometer) {
        Double temp;
        if (chronometer.getText()
                .toString().split(":").length >= 3) {
            temp = Double.parseDouble(chronometer.getText()
                    .toString().split(":")[1]) * 1000 * 60 + Double.parseDouble(chronometer.getText()
                    .toString().split(":")[0]) * 1000 * 60 * 60 + Double.parseDouble(chronometer.getText()
                    .toString().split(":")[2]) * 1000;
        } else {

            temp = Double.parseDouble(chronometer.getText()
                    .toString().split(":")[1]) * 1000 + Double.parseDouble(chronometer.getText()
                    .toString().split(":")[0]) * 1000 * 60;
        }
        return (long) (SystemClock.elapsedRealtime() - temp);
    }

    public static long setTime1(Chronometer chronometer) {
        Double temp;
        if (chronometer.getText()
                .toString().split(":").length >= 3) {
            temp = Double.parseDouble(chronometer.getText()
                    .toString().split(":")[1]) * 1000 * 60 + Double.parseDouble(chronometer.getText()
                    .toString().split(":")[0]) * 1000 * 60 * 60 + (Double.parseDouble(chronometer.getText()
                    .toString().split(":")[2]) + 1) * 1000;
        } else {
            temp = Double.parseDouble(chronometer.getText()
                    .toString().split(":")[1]) * 1000 + Double.parseDouble(chronometer.getText()
                    .toString().split(":")[0]) * 1000 * 60;
        }
        return (long) (SystemClock.elapsedRealtime() - temp);
    }

    public static void getTianqi(final Handler handler, Context context) {
//        final HashMap<String, String> hashMap = new HashMap<String, String>();
        final Message me = new Message();
        if (QuanXianUtils.isOnline(context)) {
            if (LongLatitudeUtils.initGPS(context)) {
                if (new LongLatitudeUtils(context).getLatLongTitude().get("纬度") != 0 && new LongLatitudeUtils(context).getLatLongTitude().get("经度") != 0) {
                    String s;
                    x.http().get(Upload.getInstance().setTianqi(URL + new LongLatitudeUtils(context).getLatLongTitude().get("经度") + "," + new LongLatitudeUtils(context).getLatLongTitude().get("纬度") + "&output=json&ak=" + AK + "&mcode=" + MCODE), new Callback.CommonCallback<String>() {
                        @Override
                        public void onSuccess(String string) {

                            try {
                                JSONObject jsonObject = new JSONObject(string);
                                JSONArray jsonArray = jsonObject.optJSONArray("results");
                                JSONObject jsonObject2 = null;
                                jsonObject2 = jsonArray.getJSONObject(0);
                                JSONArray jsonArray2 = jsonObject2.optJSONArray("weather_data");
                                JSONObject jsonObject3 = jsonArray2.getJSONObject(0);
                                String weather = jsonObject3.optString("weather");
                                String temperature = jsonObject3.optString("date");
//                        hashMap.put("weather", weather);
//                        hashMap.put("date", temperature);
//                        view.setText(weather);

                                me.obj = weather;
                                handler.handleMessage(me);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }

//                    Log.e("ddd", "onSuccess: ."+string.toString() );
                        }

                        @Override
                        public void onError(Throwable throwable, boolean b) {
//                    Log.e("onError",throwable.getMessage() );
                        }

                        @Override
                        public void onCancelled(CancelledException e) {

                        }

                        @Override
                        public void onFinished() {

                        }
                    });
                }
            } else {
                me.obj = "获取失败";
                handler.handleMessage(me);
            }
        } else {
            me.obj = "获取失败";
            handler.handleMessage(me);
        }
//        return hashMap;
    }

    public static void getweizhi(final Handler handler, double lon, double lat, Context context) {
        final Message me = new Message();
        if (QuanXianUtils.isOnline(context)) {
            if (LongLatitudeUtils.initGPS(context)) {
                if (lon != 0) {
                    String s;
                    x.http().get(Upload.getInstance().setTianqi(dataurl1 + lon + "," + lat + dataurl2), new Callback.CommonCallback<String>() {
                        @Override
                        public void onSuccess(String string) {

                            try {
                                JSONObject jsonObject = new JSONObject(string);
                                JSONObject jsonObject2 = jsonObject.getJSONObject("regeocode");
                                String weather = jsonObject2.optString("formatted_address");
                                me.obj = weather;
                                handler.handleMessage(me);
                            } catch (Exception e) {
                                e.printStackTrace();
                            }

                        }

                        @Override
                        public void onError(Throwable throwable, boolean b) {
//                    Log.e("onError",throwable.getMessage() );
                        }

                        @Override
                        public void onCancelled(CancelledException e) {

                        }

                        @Override
                        public void onFinished() {

                        }
                    });
                }
            } else {
                me.obj = "获取失败";
                handler.handleMessage(me);
            }
        } else {
            me.obj = "获取失败";
            handler.handleMessage(me);
        }
//        return hashMap;
    }

    /**
     * 添加突发上报事件详细内容
     */
    public static List<HashMap<String, String>> addTufashijianInfo(String[] info) {
        List<HashMap<String, String>> infos = new ArrayList<>();
        for (int i = 0; i < info.length; i++) {
            HashMap<String, String> map = new HashMap<>();
            map.put("name", info[i]);
            infos.add(map);
        }
        return infos;
    }

    /**
     * 复制文件
     *
     * @return
     */
    public static void copy(String oldPath, String newPath, String picName) {
        /**
         * 复制整个文件夹内容
         *
         * @param oldPath
         *            String 原文件路径 如：c:/fqf
         * @param newPath
         *            String 复制后路径 如：f:/fqf/ff
         * @return boolean
         */

        try {
            // System.out.println(oldPath.toString());
            (new File(newPath)).mkdirs(); // 如果文件夹不存在 则建立新文件夹
            File file = new File(oldPath);

            if (file.isFile()) {
                FileInputStream input = new FileInputStream(file);
                FileOutputStream output = new FileOutputStream(newPath + picName);
                byte[] b = new byte[1024 * 2];
                int len;
                while ((len = input.read(b)) != -1) {
                    output.write(b, 0, len);
                }
                output.flush();
                output.close();
                input.close();
            }
        } catch (Exception e) {
            System.out.println("复制整个文件夹内容操作出错");
            e.printStackTrace();
        }
    }

    /**
     * 递归删除文件和文件夹
     *
     * @param file 要删除的根目录
     */
    public static void DeleteFile(File file) {
        if (file.exists() == false) {
            return;
        } else {
            if (file.isFile()) {
                file.delete();
                return;
            }
            if (file.isDirectory()) {
                File[] childFile = file.listFiles();
                if (childFile == null || childFile.length == 0) {
                    file.delete();
                    return;
                }
                for (File f : childFile) {
                    DeleteFile(f);
                }
                file.delete();
            }
        }
    }

    public static boolean makeChangeSwitchButton(String choice) {
        if (choice.equals("1")) {
            return true;
        } else {
            return false;
        }
    }

}
