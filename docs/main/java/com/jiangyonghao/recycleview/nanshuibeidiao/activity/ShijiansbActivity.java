package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.GridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.Dialog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.GuanXianDialog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ShijianDialog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * 突发事件上报
 */
public class ShijiansbActivity extends Baseactivity implements View.OnClickListener {
    //    头部
    private ImageButton return_comIBTN;
    private TextView title_comTV;
    //保存本地和上传
    private Button upload_btn_com, save_btn_com;
    private TextView upload_img_btn, upload_movie_btn;
    //    事件名称,地点，情报部门，情报人员
    private EditText ShijianmcET, DidianET, QingbaobmET, QingbaoryET;
    //事件类型，事件性质，等级初判断 初步原因,事发时间，位置，事件情况，先期处理情况
    private TextView ShijianlxTV, ShijianxzTV, DengjicpTV, ChubuyyTV, ShifasjTV, WeizhiTV, ZuobiaoTV, ShijianqkTV, XianqichuliTV;
    //    地图选点
    private ImageButton DituxdIBTN;
    //    回显
    private Boolean isEcho = false;
    //    isupload
    private String isupload = "0";
    //    DBHelper
    private HelperDb helper = new HelperDb(this);
    //    ID和starttime
    String ID = Untils.setuuid();
    String starttime = DataTools.getLocaleTime();
    //    新建数据时的HashMap 最开始用于保存id
    private HashMap<String, String> map;
    //回显id
    String UID = "";
    //    事件类型请求码
    private final int XIANGQING = 1;
    private GridView pic_mov_GV;
    private GridViewAdapter adapter;
    public static ArrayList<ImageItem> bitmaplist;
    private ShijianDialog dialog;
    private String biaoid;
    private final int DITUXD = 4;
    private LoginDilog bar;
    private boolean isinsert;
    private String upload, shijian, chuli;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_shijiansb);
        Baseactivity.addactvity(this);
        bar = new LoginDilog(this, "正在请求");
        Untils.initContent();
        initView();
        isEcho = getIntent().getBooleanExtra("isEcho", false);
        UID = getIntent().getStringExtra("uid");
        initAdapter();
        Untils.setIssave();
        upload = getIntent().getStringExtra("upload");
        if (upload == null) {
            if (!isEcho) {
                isinsert = false;
//       不是回显即关闭显示未上报的Activiy,用户要上报新情况
                newMsg();
            } else {
                isinsert = true;
                EchoMessage();
            }
            initCtrl();
            Untils.biaoid = ID;
        } else {
            map = (HashMap<String, String>) getIntent().getSerializableExtra("zhi");
            EchoMessage1(map);
            Untils.Finish(return_comIBTN, ShijiansbActivity.this);
        }

//        bitmaplist = new ArrayList<>();
//        bitmaplist= Bimp.tempSelectBitmap;
    }//        adapter.setImage(Baseactivity.tempSelectBitmap, adapter);    }


    private void initAdapter() {
        //蒋勇豪添加
        adapter = Untils.setpop(ShijiansbActivity.this, Untils.tufaType, starttime, adapter, pic_mov_GV);
    }


    //  新添数据
    private void newMsg() {
        map = new HashMap<>();
        map.put(Untils.emergencyform[0], ID);
        Untils.biaoid = ID;
        Untils.starttime = starttime;
//         记录开始时间和 type isupload
        map.put(Untils.emergencyform[1], starttime);
        map.put(Untils.emergencyform[15], Untils.tufaType);
        map.put(Untils.emergencyform[16], isupload);
        map.put(Untils.emergencyform[8], DataTools.getLocaleDayOfMonth());
        map.put(Untils.emergencyform[18], Baseactivity.address);//地点
        map.put(Untils.emergencyform[10], Baseactivity.lon + "," + Baseactivity.lat);//坐标
        map.put(Untils.emergencyform[17], Untils.taskid);

//        创建新的数据
        helper.insertSingleData(map, Untils.tufashijian);
    }

    //回显该界面信息
    private void EchoMessage1(HashMap map) {
        HashMap<String, String> EchoMsg = map;
//        将回显ID赋值给ID 以便在回显时实时保存
        ID = UID;
        Untils.biaoid = ID;
        //蒋勇豪添加
        Untils.issave = true;
        starttime = EchoMsg.get(Untils.emergencyform[1]);
        Untils.starttime = starttime;
        biaoid = EchoMsg.get(Untils.emergencyform[0]);
//        Untils.setData(helper, adapter, starttime, Untils.tufaType, biaoid);
        //
        ShijianmcET.setText(EchoMsg.get(Untils.emergencyform[3]) == null ? null : EchoMsg.get(Untils.emergencyform[3]));
        DidianET.setText(EchoMsg.get(Untils.emergencyform[9]) == null ? null : EchoMsg.get(Untils.emergencyform[9]));
        QingbaobmET.setText(EchoMsg.get(Untils.emergencyform[11]) == null ? null : EchoMsg.get(Untils.emergencyform[11]));
        QingbaoryET.setText(EchoMsg.get(Untils.emergencyform[12]) == null ? null : EchoMsg.get(Untils.emergencyform[12]));
//        ShijianlxTV.setText(EchoMsg.get(Untils.emergencyform[4]) == null ? getResources().getString(R.string.qingxuanze) : EchoMsg.get(Untils.emergencyform[4]));

        switch (EchoMsg.get(Untils.emergencyform[4])) {
            //                  SZWR 水质污染  GCAQ 工程安全    YJDD应急调度  FXQX 防汛抢险
//                1 一级响应  2 二级响应  3 三级响应  4 四级响应 5 五级响应
            case "SZWR":
                ShijianlxTV.setText(Untils.shijianlxInfo[0]);
                ShijianlxTV.setTextColor(Color.BLACK);
                break;
            case "GCAQ":
                ShijianlxTV.setText(Untils.shijianlxInfo[1]);
                ShijianlxTV.setTextColor(Color.BLACK);
                break;
            case "YJDD":
                ShijianlxTV.setText(Untils.shijianlxInfo[2]);
                ShijianlxTV.setTextColor(Color.BLACK);
                break;
            case "FXQX":
                ShijianlxTV.setText(Untils.shijianlxInfo[3]);
                ShijianlxTV.setTextColor(Color.BLACK);
                break;
            case "":
                ShijianlxTV.setText(R.string.weitianxie);
                break;
        }

        ShijianxzTV.setText(EchoMsg.get(Untils.emergencyform[5]) == null ? getResources().getString(R.string.qingxuanze) : EchoMsg.get(Untils.emergencyform[5]));
        if (EchoMsg.get(Untils.emergencyform[5]) != null) {
            ShijianxzTV.setTextColor(Color.BLACK);
        }
//        DengjicpTV.setText(EchoMsg.get(Untils.emergencyform[6]) == null ? getResources().getString(R.string.qingxuanze) : EchoMsg.get(Untils.emergencyform[6]));

        switch (EchoMsg.get(Untils.emergencyform[6])) {
            //                  SZWR 水质污染  GCAQ 工程安全    YJDD应急调度  FXQX 防汛抢险
//                1 一级响应  2 二级响应  3 三级响应  4 四级响应 5 五级响应
            case "1":
                DengjicpTV.setText(Untils.dengjicpInfo[0]);
                DengjicpTV.setTextColor(Color.BLACK);
                break;
            case "2":
                DengjicpTV.setText(Untils.dengjicpInfo[1]);
                DengjicpTV.setTextColor(Color.BLACK);
                break;
            case "3":
                DengjicpTV.setText(Untils.dengjicpInfo[2]);
                DengjicpTV.setTextColor(Color.BLACK);
                break;
            case "4":
                DengjicpTV.setText(Untils.dengjicpInfo[3]);
                DengjicpTV.setTextColor(Color.BLACK);
                break;
            case "5":
                DengjicpTV.setText(Untils.dengjicpInfo[4]);
                DengjicpTV.setTextColor(Color.BLACK);
                break;
            case "":
                DengjicpTV.setText(R.string.weitianxie);
                break;
        }

        ChubuyyTV.setText(EchoMsg.get(Untils.emergencyform[7]) == null ? getResources().getString(R.string.qingxuanze) : EchoMsg.get(Untils.emergencyform[7]));
        if (EchoMsg.get(Untils.emergencyform[7]) != null) {
            ChubuyyTV.setTextColor(Color.BLACK);
        }
        ShifasjTV.setText(EchoMsg.get(Untils.emergencyform[8]) == null ? null : EchoMsg.get(Untils.emergencyform[8]));
        if ("".equals(EchoMsg.get(Untils.emergencyform[13])) || (EchoMsg.get(Untils.emergencyform[13]) == null)) {
            ShijianqkTV.setText("未填写");

            ShijianqkTV.setTextColor(Color.GRAY);
        } else {
            shijian = EchoMsg.get(Untils.emergencyform[13]);
            ShijianqkTV.setText("已填写");
            ShijianqkTV.setTextColor(Color.BLACK);
        }
        if ("".equals(EchoMsg.get(Untils.emergencyform[14])) || (EchoMsg.get(Untils.emergencyform[14]) == null)) {
            XianqichuliTV.setText("未填写");
            XianqichuliTV.setTextColor(Color.GRAY);

        } else {
            chuli = EchoMsg.get(Untils.emergencyform[14]);
            XianqichuliTV.setText("已填写");
            XianqichuliTV.setTextColor(Color.BLACK);
        }
//        坐标    位置
        ZuobiaoTV.setText(EchoMsg.get(Untils.emergencyform[10]) == null ? getResources().getString(R.string.weizhi) : EchoMsg.get(Untils.emergencyform[10]));
        WeizhiTV.setText(EchoMsg.get(Untils.emergencyform[18]) == null ? getResources().getString(R.string.wodeweizhi) : EchoMsg.get(Untils.emergencyform[18]));
        upload_img_btn.setOnClickListener(this);
        upload_movie_btn.setOnClickListener(this);
        upload_btn_com.setOnClickListener(this);
        save_btn_com.setOnClickListener(this);
        DituxdIBTN.setOnClickListener(this);
        ShijianlxTV.setOnClickListener(this);
        ShijianxzTV.setOnClickListener(this);
        ChubuyyTV.setOnClickListener(this);
        DengjicpTV.setOnClickListener(this);
        ShifasjTV.setOnClickListener(this);
        ShijianqkTV.setOnClickListener(this);
        XianqichuliTV.setOnClickListener(this);
    }

    private void EchoMessage() {
        HashMap<String, String> EchoMsg = helper.getEchoMsg(UID, Untils.tufashijian);
//        将回显ID赋值给ID 以便在回显时实时保存
        ID = UID;
        //蒋勇豪添加
        Untils.issave = true;
        starttime = EchoMsg.get(Untils.emergencyform[1]);
        Untils.starttime = starttime;
        biaoid = EchoMsg.get(Untils.emergencyform[0]);
        Untils.setData(helper, adapter, starttime, Untils.tufaType, biaoid);
        //
        ShijianmcET.setText(EchoMsg.get(Untils.emergencyform[3]) == null ? null : EchoMsg.get(Untils.emergencyform[3]));
        DidianET.setText(EchoMsg.get(Untils.emergencyform[9]) == null ? null : EchoMsg.get(Untils.emergencyform[9]));
        QingbaobmET.setText(EchoMsg.get(Untils.emergencyform[11]) == null ? null : EchoMsg.get(Untils.emergencyform[11]));
        QingbaoryET.setText(EchoMsg.get(Untils.emergencyform[12]) == null ? null : EchoMsg.get(Untils.emergencyform[12]));
        ShijianlxTV.setText(EchoMsg.get(Untils.emergencyform[4]) == null ? getResources().getString(R.string.qingxuanze) : EchoMsg.get(Untils.emergencyform[4]));
        if (EchoMsg.get(Untils.emergencyform[4]) != null) {
            ShijianlxTV.setTextColor(Color.BLACK);
        }
        ShijianxzTV.setText(EchoMsg.get(Untils.emergencyform[5]) == null ? getResources().getString(R.string.qingxuanze) : EchoMsg.get(Untils.emergencyform[5]));
        if (EchoMsg.get(Untils.emergencyform[5]) != null) {
            ShijianxzTV.setTextColor(Color.BLACK);
        }
        DengjicpTV.setText(EchoMsg.get(Untils.emergencyform[6]) == null ? getResources().getString(R.string.qingxuanze) : EchoMsg.get(Untils.emergencyform[6]));
        if (EchoMsg.get(Untils.emergencyform[6]) != null) {
            DengjicpTV.setTextColor(Color.BLACK);
        }
        ChubuyyTV.setText(EchoMsg.get(Untils.emergencyform[7]) == null ? getResources().getString(R.string.qingxuanze) : EchoMsg.get(Untils.emergencyform[7]));
        if (EchoMsg.get(Untils.emergencyform[7]) != null) {
            ChubuyyTV.setTextColor(Color.BLACK);
        }
        ShifasjTV.setText(EchoMsg.get(Untils.emergencyform[8]) == null ? null : EchoMsg.get(Untils.emergencyform[8]));
        if ("".equals(EchoMsg.get(Untils.emergencyform[13])) || (EchoMsg.get(Untils.emergencyform[13]) == null)) {
            ShijianqkTV.setText("未填写");
            ShijianqkTV.setTextColor(Color.GRAY);
        } else {
            ShijianqkTV.setText("已填写");
            ShijianqkTV.setTextColor(Color.BLACK);
        }
        if ("".equals(EchoMsg.get(Untils.emergencyform[14])) || (EchoMsg.get(Untils.emergencyform[14]) == null)) {
            XianqichuliTV.setText("未填写");
            XianqichuliTV.setTextColor(Color.GRAY);
        } else {
            XianqichuliTV.setText("已填写");
            XianqichuliTV.setTextColor(Color.BLACK);
        }
//        坐标    位置
        ZuobiaoTV.setText(EchoMsg.get(Untils.emergencyform[10]) == null ? getResources().getString(R.string.weizhi) : EchoMsg.get(Untils.emergencyform[10]));
        WeizhiTV.setText(EchoMsg.get(Untils.emergencyform[18]) == null ? getResources().getString(R.string.wodeweizhi) : EchoMsg.get(Untils.emergencyform[18]));

    }

    private void initCtrl() {
        return_comIBTN.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!Untils.issave) {
                    helper.delete(ID, Untils.tufashijian);
                    finish();
                } else {
                    if (helper.getEchoMsg(ID, Untils.tufashijian).get(Untils.emergencyform[3]) == null) {
                        showDialog();
                    } else {
                        if (isEcho) {
                            helper.update(UID, Untils.emergencyform[2], DataTools.getLocaleTime(), Untils.tufashijian);
                        } else {
                            helper.update(ID, Untils.emergencyform[2], DataTools.getLocaleTime(), Untils.tufashijian);
                        }
                        finish();
                    }
                }
                //蒋勇豪添加
                Untils.cleardata();
                //
            }
        });
        upload_img_btn.setOnClickListener(this);
        upload_movie_btn.setOnClickListener(this);
        upload_btn_com.setOnClickListener(this);
        save_btn_com.setOnClickListener(this);
        DituxdIBTN.setOnClickListener(this);
        if (isupload == "0") {
            if ((helper.getEmergencyform(Untils.tufaType, starttime).size()) != 0) {
                saveIntime(ShijianmcET, Untils.emergencyform[3]); // 事件名称事实保存
                saveIntime(DidianET, Untils.emergencyform[9]);//  地点实时保存
                saveIntime(QingbaobmET, Untils.emergencyform[11]);//  情报部门实时保存
                saveIntime(QingbaoryET, Untils.emergencyform[12]);//   情报人员实时保存
                saveIntime1(ShijianlxTV, Untils.emergencyform[4]);//   事件类型实时保存
                saveIntime1(ShijianxzTV, Untils.emergencyform[5]);//  事件性质
                saveIntime1(DengjicpTV, Untils.emergencyform[6]);//  等级初判
                saveIntime1(ChubuyyTV, Untils.emergencyform[7]);//  初步原因
                saveIntime1(ShifasjTV, Untils.emergencyform[8]);//  事发时间
                saveIntime1(WeizhiTV, Untils.emergencyform[18]);//  位置
                saveIntime1(ZuobiaoTV, Untils.emergencyform[10]);//  坐标
            }

            ShijianlxTV.setOnClickListener(this);
            ShijianxzTV.setOnClickListener(this);
            ChubuyyTV.setOnClickListener(this);
            DengjicpTV.setOnClickListener(this);
            ShifasjTV.setOnClickListener(this);
            ShijianqkTV.setOnClickListener(this);
            XianqichuliTV.setOnClickListener(this);
        }
    }

    /**
     * Edittext实时保存
     *
     * @param editText
     * @param key
     */
    private void saveIntime(final EditText editText, final String key) {
        editText.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
//                s.toString().equals("")
//                SZWR 水质污染  GCAQ 工程安全
//                YJDD应急调度  FXQX 防汛抢险

                helper.update(ID, key, s.toString(), Untils.tufashijian);
                if (!isEcho) {
                    Untils.issave = true;
                }
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    /**
     * TextView 实时保存
     *
     * @param textView
     * @param key
     */
    private void saveIntime1(final TextView textView, final String key) {
        textView.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
//                  SZWR 水质污染  GCAQ 工程安全    YJDD应急调度  FXQX 防汛抢险
//                1 一级响应  2 二级响应  3 三级响应  4 四级响应 5 五级响应
                switch (s.toString()) {
                    case "水质污染":
                        helper.update(ID, key, "SZWR", Untils.tufashijian);
                        break;
                    case "工程安全":
                        helper.update(ID, key, "GCAQ", Untils.tufashijian);
                        break;
                    case "应急调度":
                        helper.update(ID, key, "YJDD", Untils.tufashijian);
                        break;
                    case "防汛抢险":
                        helper.update(ID, key, "FXQX", Untils.tufashijian);
                        break;
                    case "一级响应":
                        helper.update(ID, key, "1", Untils.tufashijian);
                        break;
                    case "二级响应":
                        helper.update(ID, key, "2", Untils.tufashijian);
                        break;
                    case "三级响应":
                        helper.update(ID, key, "3", Untils.tufashijian);
                        break;
                    case "四级响应":
                        helper.update(ID, key, "4", Untils.tufashijian);
                        break;
                    case "五级响应":
                        helper.update(ID, key, "5", Untils.tufashijian);
                        break;
                    default:
                        helper.update(ID, key, s.toString(), Untils.tufashijian);
                        break;

                }

                if (!isEcho) {
                    Untils.issave = true;
                }
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    private void initView() {
        pic_mov_GV = (GridView) findViewById(R.id.bcsb_GV_com);
        return_comIBTN = ((ImageButton) findViewById(R.id.return_com));
        title_comTV = (TextView) findViewById(R.id.title_com);
        upload_img_btn = (TextView) findViewById(R.id.upload_img_btn);
        upload_movie_btn = (TextView) findViewById(R.id.upload_movie_btn);
        upload_btn_com = (Button) findViewById(R.id.upload_btn_com);
        save_btn_com = (Button) findViewById(R.id.save_btn_com);
        ShijianmcET = (EditText) findViewById(R.id.ShijianmcET);
        DidianET = (EditText) findViewById(R.id.DidianET);
        QingbaobmET = (EditText) findViewById(R.id.QingbaobmET);
        QingbaoryET = (EditText) findViewById(R.id.QingbaoryET);
        ShijianlxTV = (TextView) findViewById(R.id.ShijianlxTV);
        ShijianxzTV = (TextView) findViewById(R.id.ShijianxzTV);
        DengjicpTV = (TextView) findViewById(R.id.DengjicpTV);
        ChubuyyTV = (TextView) findViewById(R.id.ChubuyyTV);
        ShifasjTV = (TextView) findViewById(R.id.ShifasjTV);
        WeizhiTV = (TextView) findViewById(R.id.WeizhiTV);
        ShijianqkTV = (TextView) findViewById(R.id.ShijianqkTV);
        XianqichuliTV = (TextView) findViewById(R.id.XianqichuliTV);
        DituxdIBTN = (ImageButton) findViewById(R.id.DituxdIBTN);
        title_comTV.setText(getResources().getText(R.string.tufasjsb));
        ZuobiaoTV = (TextView) findViewById(R.id.ZuobiaoTV);
        ShifasjTV.setText(DataTools.getLocaleDayOfMonth());
        WeizhiTV.setText(Baseactivity.address);
        ZuobiaoTV.setText(Untils.zhesuan(Baseactivity.lon) + "," + Untils.zhesuan(Baseactivity.lat));
    }

    private void setshangchuan() {
        bar.show();
        Map map = new HashMap();
        if (!isinsert) {
            map.put("operate", "insert");
        }
        map.put("taskid", Untils.taskid);
        map.put("userName", SharedprefrenceHelper.getInstance(ShijiansbActivity.this).getUsername());
        //蒋勇豪添加
        map.putAll(helper.getSingletufa("0", starttime, Untils.caremtype, Untils.tufashijian));
//        }
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        map.put("incidentSource", "YDSB");

        map.put("alarmPerson", "alarmPerson");
        map.put("alarmPersonContacts", "1234");
        map.put("spacePosition_x", "1234");
        map.put("spacePosition_y", "1234");
        map.put("description", "qwer");

        x.http().post(Upload.getInstance().setUpload2(map, UploadUrl.tufashangbao, SharedprefrenceHelper.getInstance(ShijiansbActivity.this).gettoken(), ShijiansbActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("dongpaiqi接口填报", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
                        helper.update(ID, Untils.emergencyform[16], "1", Untils.tufashijian);
                        for (int i = 0; i < helper.getAttachmentformlist(ID).size(); i++) {
                            fujianshangchuan(helper.getAttachmentformlist(ID).get(i));
                        }
                        finish();
                    }
                    ToastShow.setShow(ShijiansbActivity.this, Untils.shibie(status));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onError(Throwable throwable, boolean b) {

            }

            @Override
            public void onCancelled(CancelledException e) {

            }

            @Override
            public void onFinished() {
                bar.dismiss();
                isinsert = true;
            }
        });
    }

    private void fujianshangchuan(Map map) {
        bar.show();
        x.http().post(Upload.getInstance().setFujianUpload(map, ShijiansbActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                Log.e("1111", "JG--" + s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(ShijiansbActivity.this, Untils.shibie(status));
                } catch (Exception e) {

                }
            }

            @Override
            public void onError(Throwable throwable, boolean b) {

            }

            @Override
            public void onCancelled(CancelledException e) {

            }

            @Override
            public void onFinished() {
                bar.dismiss();
                isinsert = true;
            }
        });
    }

    @Override
    public void onClick(View v) {
        Intent intent = new Intent(this, ShijiansbDetailActivity.class);
        switch (v.getId()) {
            case R.id.upload_img_btn:
                break;
            case R.id.upload_movie_btn:
                break;
            case R.id.upload_btn_com:
                setshangchuan();
                break;
            case R.id.save_btn_com:
                finish();
                ToastShow.setShow(this, "保存成功");
                break;
            case R.id.DituxdIBTN:
                Intent intent1 = new Intent(this, ShowInfoMapActivity.class);
                startActivityForResult(intent1, DITUXD);
                break;
            case R.id.ShijianlxTV:
                intent.putExtra("name", getResources().getString(R.string.shijianlx));
                intent.putExtra("type", ShijianlxTV.getText().toString());
                startActivityForResult(intent, XIANGQING);
                break;
            case R.id.ShijianxzTV:
                intent.putExtra("name", getResources().getString(R.string.shijianxz));
                intent.putExtra("type", ShijianxzTV.getText().toString());
                startActivityForResult(intent, XIANGQING);
                break;
            case R.id.DengjicpTV:
                intent.putExtra("name", getResources().getString(R.string.dengjicp));
                intent.putExtra("type", DengjicpTV.getText().toString());
                startActivityForResult(intent, XIANGQING);
                break;
            case R.id.ChubuyyTV:
                intent.putExtra("name", getResources().getString(R.string.chubuyy));
                intent.putExtra("type", ChubuyyTV.getText().toString());
                startActivityForResult(intent, XIANGQING);
                break;
            case R.id.ShifasjTV:
                Untils.setShiJian(ShijiansbActivity.this, 1, ShifasjTV);
                break;
            case R.id.ShijianqkTV:
                if (upload == null) {
                    dialog = new ShijianDialog(this, getResources().getString(R.string.shijianqk), ID, new ShijianDialog.PriorityListener() {
                        @Override
                        public void refreshPriorityUI(String string) {
                            ShijianqkTV.setText(string);
                            if (string.equals("未填写")) {
                                ShijianqkTV.setTextColor(Color.GRAY);
                            } else {
                                ShijianqkTV.setTextColor(Color.BLACK);
                            }
                        }
                    });
                } else {
                    dialog = new ShijianDialog(this, getResources().getString(R.string.shijianqk), shijian, true);
                }
                dialog.setCanceledOnTouchOutside(true);
                dialog.show();
                break;
            case R.id.XianqichuliTV:
                if (upload == null) {
                    dialog = new ShijianDialog(this, getResources().getString(R.string.xianqichuliqk), ID, new ShijianDialog.PriorityListener() {
                        @Override
                        public void refreshPriorityUI(String string) {
                            XianqichuliTV.setText(string);
                            if (string.equals("未填写")) {
                                XianqichuliTV.setTextColor(Color.GRAY);
                            } else {
                                XianqichuliTV.setTextColor(Color.BLACK);
                            }
                        }

                    });
                } else {
                    dialog = new ShijianDialog(this, getResources().getString(R.string.shijianqk), chuli, true);
                }
                dialog.setCanceledOnTouchOutside(true);
                dialog.show();
                break;

        }
    }


    //弹出对话框
    private void showDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("提示");
        View rootView = getLayoutInflater().inflate(R.layout.tishi, null);
        TextView msgTV = (TextView) rootView.findViewById(R.id.tuichu_TV);
        msgTV.setText("突发事件名称为空是否退出？");
        builder.setView(rootView);
        builder.setPositiveButton("是", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                if (isEcho) {
                    helper.update(UID, Untils.emergencyform[2], DataTools.getLocaleTime(), Untils.tufashijian);
                } else {
                    helper.update(ID, Untils.emergencyform[2], DataTools.getLocaleTime(), Untils.tufashijian);
                }
                finish();
            }
        });
        builder.setNegativeButton("否", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        AlertDialog dialog = builder.create();
        dialog.show();

    }

    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        switch (requestCode) {
            case XIANGQING:
                if (resultCode == Activity.RESULT_OK) {
                    String result = data.getStringExtra("name");
//                    ShijianlxTV.setText(result);
                    switch (data.getStringExtra("who")) {
                        case "事件类型":
                            ShijianlxTV.setText(result);
                            if (!"请选择".equals(ShijianlxTV.getText().toString())) {
                                ShijianlxTV.setTextColor(Color.BLACK);
                            }
                            break;
                        case "事件性质":
                            ShijianxzTV.setText(result);
                            if (!"请选择".equals(ShijianxzTV.getText().toString())) {
                                ShijianxzTV.setTextColor(Color.BLACK);
                            }
                            break;
                        case "等级初判":
                            DengjicpTV.setText(result);
                            if (!"请选择".equals(DengjicpTV.getText().toString())) {
                                DengjicpTV.setTextColor(Color.BLACK);
                            }
                            break;
                        case "初步原因":
                            ChubuyyTV.setText(result);
                            if (!"请选择".equals(ChubuyyTV.getText().toString())) {
                                ChubuyyTV.setTextColor(Color.BLACK);
                            }
                            break;
                    }

                }
                break;
            case DITUXD:
                if (resultCode == Activity.RESULT_OK) {
                    WeizhiTV.setText(data.getStringExtra("address") == "" ? Baseactivity.address : data.getStringExtra("address"));
                    String zuobiaoStr = String.valueOf(Untils.zhesuan(data.getDoubleExtra("lon", Baseactivity.lon))) + "," + String.valueOf(Untils.zhesuan(data.getDoubleExtra("lat", Baseactivity.lat)));
                    ZuobiaoTV.setText(zuobiaoStr);
                }
                break;
        }
    }


    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
    //蒋勇豪添加


    @Override
    protected void onResume() {
        super.onResume();
        //蒋勇豪添加
        Untils.setdata(adapter, helper, Untils.tufaType);
        //
    }

    @Override
    protected void onPause() {
        super.onPause();
        Untils.clearonpause();
    }
}
