package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.Switch;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.GridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.HashMap;
import java.util.Map;

/**
 * 南干渠排气阀井上段和下段 部分UI不同 用隐藏来实现
 */
@ContentView(R.layout.activity_south_gqpai_qf)
public class SouthGQPaiQFActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton title_back;
    @ViewInject(R.id.save_btn_com)
    private Button save_btn_com;
    @ViewInject(R.id.upload_img_btn)
    private TextView upload_img_btn;
    @ViewInject(R.id.upload_movie_btn)
    private TextView upload_movie_btn;
    @ViewInject(R.id.upload_btn_com)
    private Button upload_btn_com;
    @ViewInject(R.id.edittext_south_gq_paiqifa_jh)
    private EditText ed_jh;
    @ViewInject(R.id.edittext_south_gq_paiqifa_shijian)
    private EditText ed_shijian;
    @ViewInject(R.id.edittext_south_gq_paiqifa_zuozuigao)
    private EditText ed_zuozuigao;
    @ViewInject(R.id.edittext_south_gq_paiqifa_zuozuidi)
    private EditText ed_zuozuidi;
    @ViewInject(R.id.edittext_south_gq_paiqifa_youzuigao)
    private EditText ed_youzuigao;
    @ViewInject(R.id.edittext_south_gq_paiqifa_youzuidi)
    private EditText ed_youzuidi;
    @ViewInject(R.id.edittext_south_gq_xia_snwd)
    private EditText ed_xia_snwd;
    @ViewInject(R.id.edittext_south_gq_xia_swwd)
    private EditText ed_xia_swwd;
    @ViewInject(R.id.switch_south_gq_paiqifa_jinchanglu)
    private Switch sw_jinchanglu;
    @ViewInject(R.id.switch_south_gq_paiqifa_weilan)
    private Switch sw_weilan;
    @ViewInject(R.id.switch_south_gq_paiqifa_huwaishebeijian)
    private Switch sw_huwaishebeijian;
    @ViewInject(R.id.switch_south_gq_paiqifa_shoujing)
    private Switch sw_shoujing;
    @ViewInject(R.id.switch_south_gq_paiqifa_tongqikong)
    private Switch sw_tongqikong;
    @ViewInject(R.id.switch_south_gq_paiqifa_zuojinggai)
    private Switch sw_zuojinggai;
    @ViewInject(R.id.switch_south_gq_paiqifa_zuofuti)
    private Switch sw_zuofuti;
    @ViewInject(R.id.switch_south_gq_paiqifa_zuojingshi)
    private Switch sw_zuojingshi;
    @ViewInject(R.id.switch_south_gq_paiqifa_zuofati)
    private Switch sw_zuofati;
    @ViewInject(R.id.switch_south_gq_paiqifa_yougjinggai)
    private Switch sw_yougjinggai;
    @ViewInject(R.id.switch_south_gq_paiqifa_yougfuti)
    private Switch sw_yougfuti;
    @ViewInject(R.id.switch_south_gq_paiqifa_yougjingshi)
    private Switch sw_yougjingshi;
    @ViewInject(R.id.switch_south_gq_paiqifa_youfati)
    private Switch sw_youfati;
    @ViewInject(R.id.switch_south_gq_xia_jinggai)
    private Switch sw_xia_jinggai;
    @ViewInject(R.id.switch_south_gq_xia_futi)
    private Switch sw_xia_futi;
    @ViewInject(R.id.switch_south_gq_xia_jingshi)
    private Switch sw_xia_jingshi;
    @ViewInject(R.id.switch_south_gq_xia_fati)
    private Switch sw_xia_fati;
    @ViewInject(R.id.include_shangduan)
    private LinearLayout include_shangduan;
    @ViewInject(R.id.include_xiaduan)
    private LinearLayout include_xiaduan;
    private GridViewAdapter adapter;
    private String createtime = DataTools.getLocaleTime();
    @ViewInject(R.id.bcsb_GV_com)
    private GridView pic_mov_GV;
    private HelperDb helper = null;
    private HashMap<String, String> saveData_Map;
    private String id = "";
    //    回显
    private Boolean isEcho = false;
    private Intent intent;
    private String time;
    @ViewInject(R.id.chor_com)
    private Chronometer chor_com;
    @ViewInject(R.id.xianshi_chor)
    private LinearLayout xianshi_chor;
    private String jinghao;
    private boolean isinsert = false;
    private LoginDilog bar;

    public SouthGQPaiQFActivity() {
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        bar = new LoginDilog(this, "正在请求");
        Baseactivity.addactvity(this);
        jinghao = getIntent().getStringExtra("wellnum");
        if (Untils.isWode) {
            setUnable();
            initAdapter();
            if (getIntent().getStringExtra("type").equals(Untils.nanganqupaiqifashang)) {//true默认为南干渠排气阀上段
                title_com.setText(Untils.nanganqupaiqifashang);
                include_xiaduan.setVisibility(View.GONE);
            } else {//false默认为南干渠排气阀下段
                title_com.setText(Untils.nanganqupaiqifaxia);
                include_shangduan.setVisibility(View.GONE);
            }
            setshuju();
            Untils.Finish(title_back, this);
        } else {
            initialUI();
        }
        Untils.biaoid=id;
    }

    //初始化网络数据
    private void initNetData(HashMap<String, String> EchoMsg) {
        ed_jh.setText(EchoMsg.get(Untils.nanganqupaiqi[6]));
        ed_shijian.setText(EchoMsg.get(Untils.nanganqupaiqi[8]));
        ed_zuozuigao.setText(EchoMsg.get(Untils.nanganqupaiqi[20]));
        ed_zuozuidi.setText(EchoMsg.get(Untils.nanganqupaiqi[25]));
        ed_youzuigao.setText(EchoMsg.get(Untils.nanganqupaiqi[14]));
        ed_youzuidi.setText(EchoMsg.get(Untils.nanganqupaiqi[19]));
        ed_xia_snwd.setText(EchoMsg.get(Untils.nanganqupaiqi[26]));
        ed_xia_swwd.setText(EchoMsg.get(Untils.nanganqupaiqi[27]));
        sw_jinchanglu.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[9])));
        sw_weilan.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[10])));
        sw_huwaishebeijian.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[11])));
        sw_shoujing.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[12])));
        sw_tongqikong.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[13])));
        sw_zuojinggai.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[21])));
        sw_zuofuti.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[23])));
        sw_zuojingshi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[22])));
        sw_zuofati.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[24])));
        sw_yougjinggai.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[15])));
        sw_yougfuti.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[17])));
        sw_yougjingshi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[16])));
        sw_youfati.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[18])));
        sw_xia_jinggai.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[28])));
        sw_xia_futi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[30])));
        sw_xia_jingshi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[29])));
        sw_xia_fati.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[31])));

    }

    //从我的进入设置不可点击
    private void setUnable() {
        xianshi_chor.setVisibility(View.GONE);
        upload_img_btn.setEnabled(false);
        upload_movie_btn.setEnabled(false);
        upload_btn_com.setEnabled(false);
        upload_btn_com.setVisibility(View.GONE);
        save_btn_com.setEnabled(false);
        save_btn_com.setVisibility(View.GONE);
        ed_jh.setEnabled(false);
        ed_shijian.setEnabled(false);
        ed_zuozuigao.setEnabled(false);
        ed_zuozuidi.setEnabled(false);
        ed_youzuigao.setEnabled(false);
        ed_youzuidi.setEnabled(false);
        ed_xia_snwd.setEnabled(false);
        ed_xia_swwd.setEnabled(false);
        sw_jinchanglu.setEnabled(false);
        sw_weilan.setEnabled(false);
        sw_huwaishebeijian.setEnabled(false);
        sw_shoujing.setEnabled(false);
        sw_tongqikong.setEnabled(false);
        sw_zuojinggai.setEnabled(false);
        sw_zuofuti.setEnabled(false);
        sw_zuojingshi.setEnabled(false);
        sw_zuofati.setEnabled(false);
        sw_yougjinggai.setEnabled(false);
        sw_yougfuti.setEnabled(false);
        sw_yougjingshi.setEnabled(false);
        sw_youfati.setEnabled(false);
        sw_xia_jinggai.setEnabled(false);
        sw_xia_futi.setEnabled(false);
        sw_xia_jingshi.setEnabled(false);
        sw_xia_fati.setEnabled(false);
    }

    private void initialUI() {
        Untils.initContent();
        initAdapter();
        isEcho = getIntent().getBooleanExtra("isEcho", false);

        saveData_Map = new HashMap();
        helper = new HelperDb(this);
        if (getIntent().getStringExtra("type").equals(Untils.nanganqupaiqifashang)) {//true默认为南干渠排气阀上段
            title_com.setText(Untils.nanganqupaiqifashang);
            include_xiaduan.setVisibility(View.GONE);
            saveData_Map.put(Untils.nanganqupaiqi[2], Untils.nanganqupaiqifashang);//设定type为南干渠排气阀上段
        } else {//false默认为南干渠排气阀下段
            title_com.setText(Untils.nanganqupaiqifaxia);
            include_shangduan.setVisibility(View.GONE);
            saveData_Map.put(Untils.nanganqupaiqi[2], Untils.nanganqupaiqifaxia);//设定type为南干渠排气阀下段
        }
        if (isEcho) {//包含未完成
            //  回显
            isinsert = true;
            Untils.issave = true;//出提示是否保存
            id = getIntent().getStringExtra("uid");
            huixian();
        } else {
            isinsert = false;
            Untils.issave = false;//不出提示可能是浏览
            id = Untils.setuuid();
            /**
             * 新建表
             */
            ed_shijian.setText(DataTools.tian());
            ed_jh.setText(jinghao);
            saveData_Map.put(Untils.nanganqupaiqi[0], Untils.taskid);
            saveData_Map.put(Untils.nanganqupaiqi[1], id);
            saveData_Map.put(Untils.nanganqupaiqi[3], DataTools.getLocaleTime());//设定初值creattime
            saveData_Map.put(Untils.nanganqupaiqi[4], Untils.starttime);
            saveData_Map.put(Untils.nanganqupaiqi[5], Untils.noupload);//默认未上报
            saveData_Map.put(Untils.nanganqupaikong[6], jinghao);//默认未上报
            saveData_Map.put(Untils.nanganqupaiqi[8], DataTools.getLocaleDayOfMonth());//exedate


            //switch设定默认0
            saveData_Map.put(Untils.nanganqupaiqi[9], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[10], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[11], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[12], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[13], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[21], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[22], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[23], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[24], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[15], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[16], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[17], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[18], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[28], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[29], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[30], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaiqi[31], Untils.defaultSwitch);
            helper.insertSingleData(saveData_Map, Untils.nanganpaiqishang);
        }
        updateDatas();
        //设定监听
        save_btn_com.setOnClickListener(this);
        title_back.setOnClickListener(this);
        ed_shijian.setOnClickListener(this);

        sw_jinchanglu.setOnClickListener(this);
        sw_weilan.setOnClickListener(this);
        sw_huwaishebeijian.setOnClickListener(this);
        sw_shoujing.setOnClickListener(this);
        sw_tongqikong.setOnClickListener(this);
        sw_zuojinggai.setOnClickListener(this);
        sw_zuofuti.setOnClickListener(this);
        sw_zuojingshi.setOnClickListener(this);
        sw_zuofati.setOnClickListener(this);
        sw_yougjinggai.setOnClickListener(this);
        sw_yougfuti.setOnClickListener(this);
        sw_yougjingshi.setOnClickListener(this);
        sw_youfati.setOnClickListener(this);
        sw_xia_jinggai.setOnClickListener(this);
        sw_xia_futi.setOnClickListener(this);
        sw_xia_jingshi.setOnClickListener(this);
        sw_xia_fati.setOnClickListener(this);
        /**
         * 跟计时器有关的
         */
        xianshi_chor.setVisibility(View.VISIBLE);
        intent = getIntent();
        time = intent.getStringExtra("time");
        if (time != null) {
            chor_com.setText(time);
            chor_com.setBase(Untils.setTime1(chor_com));
            xianshi_chor.setVisibility(View.VISIBLE);
            intent = getIntent();
            time = intent.getStringExtra("time");
            if (time != null) {
                chor_com.setText(time);
                chor_com.setBase(Untils.setTime1(chor_com));
            }
            chor_com.start();
            chor_com.setOnChronometerTickListener(new Chronometer.OnChronometerTickListener() {
                @Override
                public void onChronometerTick(Chronometer chronometer) {
//                helper.updatestarttime(Untils.starttime, Untils.inspectionmessage[3], chronometer.getText().toString(), Untils.xunchaxinxi);
                    Untils.time = chronometer.getText().toString();
                    helper.updatestarttime(Untils.starttime, Untils.inspectionmessage[3], chronometer.getText().toString(), Untils.xunchaxinxi);
//                Log.e("onChronometerTick:1 " , chronometer.getText().toString());
                }
            });
        }
    }


    private void initAdapter() {
        if (Untils.caremtype.equals(Untils.nanganqupaiqifashang)) {
            //蒋勇豪添加
            adapter = Untils.setpop(SouthGQPaiQFActivity.this, Untils.nanganqupaiqifashang, createtime, adapter, pic_mov_GV);
        } else if (Untils.caremtype.equals(Untils.nanganqupaiqifaxia)) {
            //蒋勇豪添加
            adapter = Untils.setpop(SouthGQPaiQFActivity.this, Untils.nanganqupaiqifaxia, createtime, adapter, pic_mov_GV);
        }
    }

    private void updateDatas() {
        Untils.setEditClick(this, ed_jh, id, Untils.nanganqupaiqi[6], Untils.nanganpaiqishang);
        setTextViewChange(ed_shijian,Untils.nanganqupaiqi[8]);
        Untils.setEditClick(this, ed_zuozuigao, id, Untils.nanganqupaiqi[20], Untils.nanganpaiqishang);
        Untils.setEditClick(this, ed_zuozuidi, id, Untils.nanganqupaiqi[25], Untils.nanganpaiqishang);
        Untils.setEditClick(this, ed_youzuigao, id, Untils.nanganqupaiqi[14], Untils.nanganpaiqishang);
        Untils.setEditClick(this, ed_youzuidi, id, Untils.nanganqupaiqi[19], Untils.nanganpaiqishang);
        Untils.setEditClick(this, ed_xia_snwd, id, Untils.nanganqupaiqi[26], Untils.nanganpaiqishang);
        Untils.setEditClick(this, ed_xia_swwd, id, Untils.nanganqupaiqi[27], Untils.nanganpaiqishang);

        Untils.setSwitchClick(this, sw_jinchanglu, id, Untils.nanganqupaiqi[9], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_weilan, id, Untils.nanganqupaiqi[10], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_huwaishebeijian, id, Untils.nanganqupaiqi[11], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_shoujing, id, Untils.nanganqupaiqi[12], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_tongqikong, id, Untils.nanganqupaiqi[13], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_zuojinggai, id, Untils.nanganqupaiqi[21], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_zuofuti, id, Untils.nanganqupaiqi[23], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_zuojingshi, id, Untils.nanganqupaiqi[22], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_zuofati, id, Untils.nanganqupaiqi[24], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_yougjinggai, id, Untils.nanganqupaiqi[15], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_yougfuti, id, Untils.nanganqupaiqi[15], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_yougjingshi, id, Untils.nanganqupaiqi[15], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_youfati, id, Untils.nanganqupaiqi[18], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_xia_jinggai, id, Untils.nanganqupaiqi[28], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_xia_futi, id, Untils.nanganqupaiqi[30], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_xia_jingshi, id, Untils.nanganqupaiqi[29], Untils.nanganpaiqishang);
        Untils.setSwitchClick(this, sw_xia_fati, id, Untils.nanganqupaiqi[31], Untils.nanganpaiqishang);

//        setEditTextChange(ed_jh, Untils.nanganqupaiqi[6]);
//        setEditTextChange(ed_shijian, Untils.nanganqupaiqi[8]);
//        setEditTextChange(ed_zuozuigao, Untils.nanganqupaiqi[20]);
//        setEditTextChange(ed_zuozuidi, Untils.nanganqupaiqi[25]);
//        setEditTextChange(ed_youzuigao, Untils.nanganqupaiqi[14]);
//        setEditTextChange(ed_youzuidi, Untils.nanganqupaiqi[19]);
//        setEditTextChange(ed_xia_snwd, Untils.nanganqupaiqi[26]);
//        setEditTextChange(ed_xia_swwd, Untils.nanganqupaiqi[27]);

    }

    //   0"taskid"  1"id", 2"type", 3"createtime",4 "starttime", 5"isupload", 6"wellnum", 7"weather",
// 8"exedate", 9"march", 10"crawl",11 "deviceroom", 12"handwell", 13"arihole", 14"right_temperatureinh",
// 15"right_welllid", 16"right_wellroom", 17"right_ladder",18 "right_gate",19 "right_temperatureinl",
// 20"left_temperatureinh",21 "left_welllid",22 "left_wellroom",23 "left_ladder", 24"left_gate",
// 25"left_temperatureinl",26 "temperaturein",27 "temperatureout", 28"welllid", 29"wellroom", 30"ladder",31 "gate", 32"remark"
    private void huixian() {
        HashMap<String, String> EchoMsg = helper.getEchoMsg(id, Untils.nanganpaiqishang);
        createtime = EchoMsg.get(Untils.nanganqupaiqi[3]);

        if (Untils.caremtype.equals(Untils.nanganqupaiqifashang)) {
            //蒋勇豪添加
            Untils.setData(helper, adapter, createtime, Untils.nanganqupaiqifashang, id);
        } else if (Untils.caremtype.equals(Untils.nanganqupaiqifaxia)) {
            //蒋勇豪添加
            Untils.setData(helper, adapter, createtime, Untils.nanganqupaiqifaxia, id);
        }
        ed_jh.setText(EchoMsg.get(Untils.nanganqupaiqi[6]));
        ed_shijian.setText(EchoMsg.get(Untils.nanganqupaiqi[8]));
        ed_zuozuigao.setText(EchoMsg.get(Untils.nanganqupaiqi[20]));
        ed_zuozuidi.setText(EchoMsg.get(Untils.nanganqupaiqi[25]));
        ed_youzuigao.setText(EchoMsg.get(Untils.nanganqupaiqi[14]));
        ed_youzuidi.setText(EchoMsg.get(Untils.nanganqupaiqi[19]));
        ed_xia_snwd.setText(EchoMsg.get(Untils.nanganqupaiqi[26]));
        ed_xia_swwd.setText(EchoMsg.get(Untils.nanganqupaiqi[27]));
        sw_jinchanglu.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[9])));
        sw_weilan.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[10])));
        sw_huwaishebeijian.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[11])));
        sw_shoujing.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[12])));
        sw_tongqikong.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[13])));
        sw_zuojinggai.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[21])));
        sw_zuofuti.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[23])));
        sw_zuojingshi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[22])));
        sw_zuofati.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[24])));
        sw_yougjinggai.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[15])));
        sw_yougfuti.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[17])));
        sw_yougjingshi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[16])));
        sw_youfati.setChecked((Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[18]))));
        sw_xia_jinggai.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[28])));
        sw_xia_futi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[30])));
        sw_xia_jingshi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[29])));
        sw_xia_fati.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaiqi[31])));

    }
    private void setTextViewChange(final TextView ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                Log.e("1111",charSequence.toString());
                helper.update(id, key, charSequence.toString(), Untils.nanganpaiqishang);
                if (!"".equals(charSequence.toString()) && charSequence.toString() != null) {
                    Untils.issave = true;
                }

            }

            @Override
            public void afterTextChanged(Editable editable) {
//                if (editable.toString()!=null||!editable.toString().equals("")||editable.toString()!=""){
//                    Untils.issave = true;
//                }else {
//                    Untils.issave = false;
//                }
            }
        });
    }
    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.save_btn_com://保存至本地
                ToastShow.setShow(this, "保存成功！！！");
                finish();
                break;
            case R.id.return_com:
                if (!Untils.issave) {
                    helper.delete(id, Untils.nanganpaiqishang);
                }//蒋勇豪添加
                Untils.cleardata();
                finish();
                break;
            case R.id.edittext_south_gq_paiqifa_shijian:
                Untils.setShiJian(SouthGQPaiQFActivity.this, 1, ed_shijian);
                break;
            case R.id.switch_south_gq_paiqifa_weilan:
            case R.id.switch_south_gq_paiqifa_huwaishebeijian:
            case R.id.switch_south_gq_paiqifa_shoujing:
            case R.id.switch_south_gq_paiqifa_tongqikong:
            case R.id.switch_south_gq_paiqifa_zuojinggai:
            case R.id.switch_south_gq_paiqifa_zuofuti:
            case R.id.switch_south_gq_paiqifa_zuojingshi:
            case R.id.switch_south_gq_paiqifa_zuofati:
            case R.id.switch_south_gq_paiqifa_yougjinggai:
            case R.id.switch_south_gq_paiqifa_yougfuti:
            case R.id.switch_south_gq_paiqifa_yougjingshi:
            case R.id.switch_south_gq_paiqifa_youfati:
            case R.id.switch_south_gq_xia_jinggai:
            case R.id.switch_south_gq_xia_futi:
            case R.id.switch_south_gq_xia_jingshi:
            case R.id.switch_south_gq_xia_fati:
                Untils.setHidden(this);
                break;
        }
    }

    private void setEditTextChange(final EditText ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                helper.update(id, key, charSequence.toString(), Untils.nanganpaiqishang);
                if (!"".equals(charSequence.toString()) && charSequence.toString() != null) {
                    Untils.issave = true;
                } else {
                    Untils.issave = false;
                }

            }

            @Override
            public void afterTextChanged(Editable editable) {
//                if (editable.toString()!=null||!editable.toString().equals("")||editable.toString()!=""){
//                    Untils.issave = true;
//                }else {
//                    Untils.issave = false;
//                }
            }
        });
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
//        bitmaplist.clear();
//        bitmaplist.addAll(Baseactivity.tempSelectBitmap);
        if (!Untils.isWode) {
            if (Untils.caremtype.equals(Untils.nanganqupaiqifashang)) {
                //蒋勇豪添加
                Untils.setdata(adapter, helper, Untils.nanganqupaiqifashang);
            } else if (Untils.caremtype.equals(Untils.nanganqupaiqifaxia)) {
                //蒋勇豪添加
                Untils.setdata(adapter, helper, Untils.nanganqupaiqifaxia);
            }
        }


        //
    }

    //
    //蒋勇豪添加
    @Override
    protected void onPause() {
        super.onPause();
        Untils.clearonpause();
    }

    @Event(R.id.upload_btn_com)
    private void setshangchuan(View view) {
        setshangchuan();
    }

    private void setshangchuan() {
        String action = null;
        bar.show();
        Map map = new HashMap();
        if (!isinsert) {
            map.put("operate", "insert");
        }
        map.put("taskid", Untils.taskid);
        map.put("userName", SharedprefrenceHelper.getInstance(SouthGQPaiQFActivity.this).getUsername());
        if (Untils.caremtype.equals(Untils.nanganqupaiqifashang)) {
            action = UploadUrl.ngqair;
            //蒋勇豪添加
            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.nanganpaiqishang));
        } else if (Untils.caremtype.equals(Untils.nanganqupaiqifaxia)) {
            action = UploadUrl.ngqair;
//            //蒋勇豪添加
            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.nanganpaiqishang));
        }
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(SouthGQPaiQFActivity.this).gettoken(), SouthGQPaiQFActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("管线接口填报", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        intent = new Intent(XunChaActivity.this, XunChaActivity.class);
//                        startActivity(intent);
                        helper.update(id, Untils.nanganqupaiqi[5], "1", Untils.nanganpaiqishang);
                        for (int i = 0; i < helper.getAttachmentformlist(id).size(); i++) {
                            fujianshangchuan(helper.getAttachmentformlist(id).get(i));
                        }
                        finish();
                    }
                    ToastShow.setShow(SouthGQPaiQFActivity.this, Untils.shibie(status));
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

    private void setshuju() {
        bar.show();
        Map map = new HashMap();
        map.put("taskid", Untils.taskid);
        map.put("wellnum", jinghao);
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.ngqqueryair, SharedprefrenceHelper.getInstance(SouthGQPaiQFActivity.this).gettoken(), SouthGQPaiQFActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("dong分水chaxun填报", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
                        HashMap map = new HashMap();
//                        JSONObject jsonObject = json.getJSONObject(UploadUrl.backkey[2]);
                        JSONArray jrr = json.optJSONArray(UploadUrl.backkey[2]);
                        for (int i = 0; i < jrr.length(); i++) {
                            JSONArray jsonObject2 = null;
                            jsonObject2 = (JSONArray) jrr.opt(i);
                            for (int j = 0; j < jsonObject2.length(); j++) {
//                                Log.e("dong分水ch", ((JSONObject)jsonObject2.opt(j)).optString("id").toLowerCase()+((JSONObject) jsonObject2.opt(j)).optString("value"));
                                map.put(((JSONObject) jsonObject2.opt(j)).optString("id").toLowerCase(), ((JSONObject) jsonObject2.opt(j)).optString("value"));
                            }
                        }
                        initNetData(map);
                        fujianhuixian(map.get("id").toString());
                    }
                    ToastShow.setShow(SouthGQPaiQFActivity.this, Untils.shibie(status));
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
            }
        });
    }
    private void fujianshangchuan(Map map) {
        bar.show();
        x.http().post(Upload.getInstance().setFujianUpload(map, SouthGQPaiQFActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(SouthGQPaiQFActivity.this, Untils.shibie(status));
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
            }
        });
    }
    private void fujianhuixian(String id) {
        bar.show();
        x.http().post(Upload.getInstance().setUpload(id, SouthGQPaiQFActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(SouthGQPaiQFActivity.this, Untils.shibie(status));
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
            }
        });
    }
}
