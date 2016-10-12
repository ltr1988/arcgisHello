package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.support.v7.app.AlertDialog;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.CompoundButton;
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
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.GuanXianDialog;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@ContentView(R.layout.activity_guan_xian)
public class GuanXianActivity extends Baseactivity implements CompoundButton.OnCheckedChangeListener, View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.editText_kaishizhuanghao)
    private EditText startNumber;
    @ViewInject(R.id.editText_jieshuzhuanghao)
    private EditText endNumber;
    @ViewInject(R.id.textView_data)
    private TextView data;
    @ViewInject(R.id.textView_weather)
    private TextView weather;
    @ViewInject(R.id.linear_movie_up)
    private LinearLayout linear_movie_up;
    @ViewInject(R.id.linear_photo_up)
    private LinearLayout linear_photo_up;
    @ViewInject(R.id.switch_neirong1)
    private Switch gongchengkance;
    @ViewInject(R.id.switch_neirong2)
    private Switch xinzengshigong;
    @ViewInject(R.id.switch_neirong3)
    private Switch jishui;
    @ViewInject(R.id.switch_neirong4)
    private Switch chenxian;
    @ViewInject(R.id.switch_neirong5)
    private Switch change;
    @ViewInject(R.id.switch_neirong6)
    private Switch sunhui;
    @ViewInject(R.id.textView_weitianxie)
    private TextView question;
    @ViewInject(R.id.textView_weitianxie2)
    private TextView real;
    @ViewInject(R.id.save_btn_com)
    private Button save_btn_com;//保存至本地
    @ViewInject(R.id.xianshi_chor)
    private LinearLayout xianshi_chor;
    @ViewInject(R.id.linearLayout_chulifangfa)
    private LinearLayout chulifangfa;
    @ViewInject(R.id.linearLayout_wentimiaoshi)
    private LinearLayout wentimiaoshi;
    @ViewInject(R.id.chor_com)
    private Chronometer chor_com;
    private HashMap<String, String> saveData_Map;
    private HelperDb helper = null;
    private HashMap<String, String> mapList;
    private Intent intent;
    private String time;
    private String ID;
    private GuanXianDialog dialog;
    private ArrayList<HashMap<String, String>> returnMapList = null;
    public static boolean guanxianType = false;//false为大宁管线
    private GridViewAdapter adapter;
    private String createtime = DataTools.getLocaleTime();
    @ViewInject(R.id.bcsb_GV_com)
    private GridView pic_mov_GV;
    @ViewInject(R.id.upload_btn_com)
    private Button upload_btn_com;
    @ViewInject(R.id.upload_img_btn)
    private TextView upload_img_btn;
    @ViewInject(R.id.upload_movie_btn)
    private TextView upload_movie_btn;
    private LoginDilog bar;
    private Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            String weather1 = (String) msg.obj;
            weather.setText(weather1);
            saveData_Map.put(Untils.linepipe[15], weather1);
        }
    };
    private boolean isinsert = false;
    private String stakestart, stakeend;
    private String wenti, chuli;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        Baseactivity.addactvity(this);
        bar = new LoginDilog(this, "正在上传");
        if (Untils.isWode) {
            stakestart = getIntent().getStringExtra("stakestart");
            stakeend = getIntent().getStringExtra("stakeend");
            wentimiaoshi.setOnClickListener(this);
            chulifangfa.setOnClickListener(this);
            setUnable();
//            initAdapter();
            setshuju();
            Untils.Finish(return_com, this);
        } else {
            initialUI();
        }
        Untils.biaoid = ID;
    }

    //网络请求数据
    private void initNetData(HashMap<String, String> mapList) {
        startNumber.setText(mapList.get(Untils.linepipe[2]));
        endNumber.setText(mapList.get(Untils.linepipe[3]));
        data.setText(mapList.get(Untils.linepipe[14]));
        weather.setText(mapList.get(Untils.linepipe[15]));
        gongchengkance.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[4])));
        xinzengshigong.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[5])));
        jishui.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[6])));
        chenxian.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[7])));
        change.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[8])));
        sunhui.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[18])));
        question.setText(mapList.get(Untils.linepipe[9]) == "" || mapList.get(Untils.linepipe[9]) == null || mapList.get(Untils.linepipe[9]).equals("") ? "未填写" : "已填写");//问题描述和
        wenti = mapList.get(Untils.linepipe[9]).toString();
        real.setText(mapList.get(Untils.linepipe[10]) == "" || mapList.get(Untils.linepipe[10]) == null || mapList.get(Untils.linepipe[10]).equals("") ? "未填写" : "已填写");//问题描述和
        chuli = mapList.get(Untils.linepipe[10]).toString();
        /**
         * saveData_Map中存switch的五个数据
         */
        Untils.getTianqi(handler, this);
        saveData_Map.put(Untils.linepipe[4], mapList.get(Untils.linepipe[4]));
        saveData_Map.put(Untils.linepipe[5], mapList.get(Untils.linepipe[5]));
        saveData_Map.put(Untils.linepipe[6], mapList.get(Untils.linepipe[6]));
        saveData_Map.put(Untils.linepipe[7], mapList.get(Untils.linepipe[7]));
        saveData_Map.put(Untils.linepipe[8], mapList.get(Untils.linepipe[8]));
        if (Untils.caremtype.equals(Untils.daningguanxianType)) {
            title_com.setText(Untils.daningguanxianType);//设置抬头
            saveData_Map.put(Untils.linepipe[12], Untils.daningguanxianType);//设定type:大宁管线
            guanxianType = false;
        } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
            title_com.setText(Untils.dongganquguanxianType);//设置抬头
            saveData_Map.put(Untils.linepipe[12], Untils.dongganquguanxianType);//设定type:东干渠管线
            guanxianType = true;
        }
    }

    private void setUnable() {
        if (Untils.caremtype.equals(Untils.daningguanxianType)) {
            title_com.setText(Untils.daningguanxianType);//设置抬头
        } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
            title_com.setText(Untils.dongganquguanxianType);//设置抬头
        }
        startNumber.setEnabled(false);
        endNumber.setEnabled(false);
        data.setEnabled(false);
        weather.setEnabled(false);
        gongchengkance.setEnabled(false);
        xinzengshigong.setEnabled(false);
        jishui.setEnabled(false);
        chenxian.setEnabled(false);
        change.setEnabled(false);
        sunhui.setEnabled(false);
//        question.setEnabled(false);
//        real.setEnabled(false);
        xianshi_chor.setVisibility(View.GONE);
        linear_photo_up.setEnabled(false);
        linear_photo_up.setVisibility(View.GONE);
        linear_movie_up.setEnabled(false);
        linear_movie_up.setVisibility(View.GONE);
        upload_btn_com.setEnabled(false);
        upload_btn_com.setVisibility(View.GONE);
        save_btn_com.setEnabled(false);
        save_btn_com.setVisibility(View.GONE);
    }


    /**
     * 在adapter中点击管线item时读取数据库判断isupload值
     * 当管线数据库中没有为完成任务时（isupload=1），直接跳转到新的管线activity
     * 当管线数据库中有未完成的任务时（isupload=0），跳转到新的activity界面进行选择某一未填写完成的管线activity
     * <p/>
     * <p/>
     * 数据库中starttime还没有赋值    Untils.linepipe[1]starttime
     */

    private void newOrCountune(boolean isdaningUncompleted) {


    }

    private void initAdapter() {
//        adapter = new GridViewAdapter(this);
//        pic_mov_GV.setAdapter(adapter);
        if (Untils.caremtype.equals(Untils.daningguanxianType)) {
            //蒋勇豪添加
            adapter = Untils.setpop(GuanXianActivity.this, Untils.daningguanxianType, createtime, adapter, pic_mov_GV);
        } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
            //蒋勇豪添加
            adapter = Untils.setpop(GuanXianActivity.this, Untils.dongganquguanxianType, createtime, adapter, pic_mov_GV);
        }

    }

    private void initialUI() {
        Untils.initContent();

        //蒋勇豪添加
        initAdapter();
        //
        helper = new HelperDb(this);
        saveData_Map = new HashMap();
        Untils.setIssave();
        mapList = (HashMap<String, String>) getIntent().getSerializableExtra("此行数据");
        if (mapList != null) {//包含未完成 需要回显数据
            Untils.issave = true;
            isinsert = true;
            ID = mapList.get(Untils.linepipe[0]);//得到ID值
            if (mapList.get(Untils.linepipe[2]).equals("未填写")) {
                startNumber.setText("");
            } else {
                startNumber.setText(mapList.get(Untils.linepipe[2]));
            }
            //蒋勇豪添加
            createtime = mapList.get(Untils.linepipe[16]);
            Untils.issave = true;
            if (Untils.caremtype.equals(Untils.daningguanxianType)) {
                //蒋勇豪添加
                Untils.setData(helper, adapter, createtime, Untils.daningguanxianType, ID);
            } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
                //蒋勇豪添加
                Untils.setData(helper, adapter, createtime, Untils.dongganquguanxianType, ID);
            }

            //
            endNumber.setText(mapList.get(Untils.linepipe[3]));
            data.setText(mapList.get(Untils.linepipe[14]));
            weather.setText(mapList.get(Untils.linepipe[15]));
            gongchengkance.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[4])));
            xinzengshigong.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[5])));
            jishui.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[6])));
            chenxian.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[7])));
            change.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[8])));
            sunhui.setChecked(Untils.makeChangeSwitchButton(mapList.get(Untils.linepipe[18])));
            question.setText(mapList.get(Untils.linepipe[9]) == "" || mapList.get(Untils.linepipe[9]) == null || mapList.get(Untils.linepipe[9]).equals("") ? "未填写" : "已填写");//问题描述和
            real.setText(mapList.get(Untils.linepipe[10]) == "" || mapList.get(Untils.linepipe[10]) == null || mapList.get(Untils.linepipe[10]).equals("") ? "未填写" : "已填写");//问题描述和
            /**
             * saveData_Map中存switch的五个数据
             */
            Untils.getTianqi(handler, this);
            saveData_Map.put(Untils.linepipe[4], mapList.get(Untils.linepipe[4]));
            saveData_Map.put(Untils.linepipe[5], mapList.get(Untils.linepipe[5]));
            saveData_Map.put(Untils.linepipe[6], mapList.get(Untils.linepipe[6]));
            saveData_Map.put(Untils.linepipe[7], mapList.get(Untils.linepipe[7]));
            saveData_Map.put(Untils.linepipe[8], mapList.get(Untils.linepipe[8]));
            if (Untils.caremtype.equals(Untils.daningguanxianType)) {
                title_com.setText(Untils.daningguanxianType);//设置抬头
                saveData_Map.put(Untils.linepipe[12], Untils.daningguanxianType);//设定type:大宁管线
                guanxianType = false;
            } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
                title_com.setText(Untils.dongganquguanxianType);//设置抬头
                saveData_Map.put(Untils.linepipe[12], Untils.dongganquguanxianType);//设定type:东干渠管线
                guanxianType = true;
            }
        } else {
            /**
             * 给日期和天气设定初值
             */
            isinsert = false;
            String dataTime = DataTools.getLocaleDayOfMonth();
            data.setText(dataTime);
            saveData_Map.put(Untils.linepipe[14], dataTime);
            setTextViewChange(data, Untils.linepipe[14]);
            /**
             * 先给数据库switch选项设定默认值为0
             */
            Untils.getTianqi(handler, this);
            saveData_Map.put(Untils.linepipe[4], Untils.defaultSwitch);
            saveData_Map.put(Untils.linepipe[5], Untils.defaultSwitch);
            saveData_Map.put(Untils.linepipe[6], Untils.defaultSwitch);
            saveData_Map.put(Untils.linepipe[7], Untils.defaultSwitch);
            saveData_Map.put(Untils.linepipe[8], Untils.defaultSwitch);
            saveData_Map.put(Untils.linepipe[18], Untils.defaultSwitch);
            saveData_Map.put(Untils.linepipe[11], Untils.noupload);//设定初值状态为0
            saveData_Map.put(Untils.linepipe[1], Untils.starttime);//设定starttime
            saveData_Map.put(Untils.linepipe[17], Untils.taskid);//设定taskid
            saveData_Map.put(Untils.linepipe[16], createtime);//设定creattime
            //蒋勇豪添加
            ID = Untils.setuuid();//新增项赋值新的ID
            Untils.biaoid = ID;
            //
            saveData_Map.put(Untils.linepipe[0], ID);
            saveData_Map.put(Untils.linepipe[2], "");

            if (Untils.caremtype.equals(Untils.daningguanxianType)) {
                title_com.setText(Untils.daningguanxianType);//设置抬头
                saveData_Map.put(Untils.linepipe[12], Untils.daningguanxianType);//设定type:大宁管线
                guanxianType = false;
            } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
                title_com.setText(Untils.dongganquguanxianType);//设置抬头
                saveData_Map.put(Untils.linepipe[12], Untils.dongganquguanxianType);//设定type:东干渠管线
                guanxianType = true;
            }
            helper.setinsertLinepipe(saveData_Map);
        }

        setEditTextChange(startNumber, Untils.linepipe[2]);//当开始桩号改变时，实时写入数据库
        setEditTextChange(endNumber, Untils.linepipe[3]);//当结束桩号改变时，实时写入数据库

        gongchengkance.setOnCheckedChangeListener(this);
        gongchengkance.setOnCheckedChangeListener(this);
        xinzengshigong.setOnCheckedChangeListener(this);
        jishui.setOnCheckedChangeListener(this);
        chenxian.setOnCheckedChangeListener(this);
        change.setOnCheckedChangeListener(this);
        sunhui.setOnCheckedChangeListener(this);
        save_btn_com.setOnClickListener(this);
        return_com.setOnClickListener(this);
        data.setOnClickListener(this);
        weather.setOnClickListener(this);
        //设置问题描述和处理方法的监听
        chulifangfa.setOnClickListener(this);
        wentimiaoshi.setOnClickListener(this);
        weather.setOnClickListener(this);

        /**
         * 跟计时器有关的
         */
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
        weather.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                helper.update(ID, Untils.linepipe[15], s.toString(), Untils.guanxian);
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    @Override
    public void onCheckedChanged(CompoundButton buttonView, boolean isChecked) {
        switch (buttonView.getId()) {
            case R.id.switch_neirong1://gongchengkance
//                if (setstartNumberNotNull()) {
                if (isChecked) {
                    saveData_Map.put(Untils.linepipe[4], Untils.choiceSwitch);
                    helper.update(ID, Untils.linepipe[4], Untils.choiceSwitch + "", Untils.guanxian);
                    Untils.issave = true;
                } else {
                    saveData_Map.put(Untils.linepipe[4], Untils.defaultSwitch);
                    helper.update(ID, Untils.linepipe[4], Untils.defaultSwitch + "", Untils.guanxian);
//                    Untils.issave = false;
                }
                Untils.setHidden(this);
//                } else {
////                    gongchengkance.setChecked(false);
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
            case R.id.switch_neirong2://xinzengshigong
//                if (setstartNumberNotNull()) {
                if (isChecked) {
                    Untils.issave = true;
                    saveData_Map.put(Untils.linepipe[5], Untils.choiceSwitch);
                    helper.update(ID, Untils.linepipe[5], Untils.choiceSwitch + "", Untils.guanxian);
                } else {
//                    Untils.issave = false;
                    saveData_Map.put(Untils.linepipe[5], Untils.defaultSwitch);
                    helper.update(ID, Untils.linepipe[5], Untils.defaultSwitch + "", Untils.guanxian);
                }
                Untils.setHidden(this);
//                } else {
////                    xinzengshigong.setChecked(false);
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
            case R.id.switch_neirong3://jishui
//                if (setstartNumberNotNull()) {
                if (isChecked) {
                    Untils.issave = true;
                    saveData_Map.put(Untils.linepipe[6], Untils.choiceSwitch);
                    helper.update(ID, Untils.linepipe[6], Untils.choiceSwitch + "", Untils.guanxian);
                } else {
//                    Untils.issave = false;
                    saveData_Map.put(Untils.linepipe[6], Untils.defaultSwitch);
                    helper.update(ID, Untils.linepipe[6], Untils.defaultSwitch + "", Untils.guanxian);
                }
                Untils.setHidden(this);
//                } else {
////                    jishui.setChecked(false);
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
            case R.id.switch_neirong4://chenxian
//                if (setstartNumberNotNull()) {
                if (isChecked) {
                    Untils.issave = true;
                    saveData_Map.put(Untils.linepipe[7], Untils.choiceSwitch);
                    helper.update(ID, Untils.linepipe[7], Untils.choiceSwitch + "", Untils.guanxian);
                } else {
//                    Untils.issave = false;
                    saveData_Map.put(Untils.linepipe[7], Untils.defaultSwitch);
                    helper.update(ID, Untils.linepipe[7], Untils.defaultSwitch + "", Untils.guanxian);
                }
                Untils.setHidden(this);
//                } else {
////                    chenxian.setChecked(false);
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
            case R.id.switch_neirong5://change
//                if (setstartNumberNotNull()) {
                if (isChecked) {
                    Untils.issave = true;
                    saveData_Map.put(Untils.linepipe[8], Untils.choiceSwitch);
                    helper.update(ID, Untils.linepipe[8], Untils.choiceSwitch + "", Untils.guanxian);
                } else {
//                    Untils.issave = false;
                    saveData_Map.put(Untils.linepipe[8], Untils.defaultSwitch);
                    helper.update(ID, Untils.linepipe[8], Untils.defaultSwitch + "", Untils.guanxian);
                }
                Untils.setHidden(this);
//                } else {
////                    change.setChecked(false);
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
            case R.id.switch_neirong6://change
//                if (setstartNumberNotNull()) {
                if (isChecked) {
                    Untils.issave = true;
                    saveData_Map.put(Untils.linepipe[18], Untils.choiceSwitch);
                    helper.update(ID, Untils.linepipe[18], Untils.choiceSwitch + "", Untils.guanxian);
                } else {
//                    Untils.issave = false;
                    saveData_Map.put(Untils.linepipe[18], Untils.defaultSwitch);
                    helper.update(ID, Untils.linepipe[18], Untils.defaultSwitch + "", Untils.guanxian);
                }
                Untils.setHidden(this);
//                } else {
////                    change.setChecked(false);
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.save_btn_com://保存至本地
//                if (!setstartNumberNotNull()) {//有开始柱号为空的项先删了
//                    helper.delete(ID, Untils.guanxian);
//                }
////                if (setstartNumberNotNull()) {
//                helper.update(ID, Untils.linepipe[11], Untils.upload, Untils.guanxian);//将未上报0改为已上报1
//                    DataToLinePipe(true);
                ToastShow.setShow(this, "保存成功！！！");
                finish();
                Untils.setHidden(this);
//                } else {
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
            case R.id.return_com:
                if (!Untils.issave) {
                    helper.delete(ID, Untils.guanxian);
                    finish();
                } else {
                    if (!setstartNumberNotNull()) {//有开始柱号为空的项先删了
//                    helper.delete(ID, Untils.guanxian);
                        alarmDialog();
                    } else {
                        finish();
                    }
//                    Untils.isUncompleted = true;
                }
                //蒋勇豪添加
                Untils.cleardata();
                break;
            case R.id.linearLayout_wentimiaoshi:
//                if (setstartNumberNotNull()) {
                if (!Untils.isWode) {
                    dialog = new GuanXianDialog(GuanXianActivity.this, "问题描述", ID, new GuanXianDialog.PriorityListener() {
                        @Override
                        public void refreshPriorityUI(String string) {
                            question.setText(string);
                            if (string.equals("已填写")) {
                                Untils.issave = true;
                            } else {
//                            Untils.issave = false;
                            }
                        }
                    });
                } else {
                    dialog = new GuanXianDialog(GuanXianActivity.this, "问题描述", wenti);
                }
                dialog.setCanceledOnTouchOutside(true);
                dialog.show();
//                } else {
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
            case R.id.linearLayout_chulifangfa:
//                if (setstartNumberNotNull()) {
                if (!Untils.isWode) {
                    dialog = new GuanXianDialog(GuanXianActivity.this, "处理方法", ID, new GuanXianDialog.PriorityListener() {
                        @Override
                        public void refreshPriorityUI(String string) {
                            real.setText(string);
                            if (string.equals("已填写")) {
                                Untils.issave = true;
                            } else {
//                            Untils.issave = false;
                            }
                        }
                    });
                } else {
                    dialog = new GuanXianDialog(GuanXianActivity.this, "处理方法", chuli);
                }
                dialog.setCanceledOnTouchOutside(true);
                dialog.show();
//                } else {
//                    ToastShow.setShow(this, "请先填写开始桩号");
//                }
                break;
            case R.id.textView_weather:
//                ToastShow.setShow(this, "功能未添加");
                break;
            case R.id.textView_data:
                Untils.setShiJian(GuanXianActivity.this, 1, data);
                break;
        }
    }

    /**
     * 设置开始桩号为最先改变的控件
     *
     * @return
     */
    private boolean setstartNumberNotNull() {
        boolean backNumber = false;
        if (startNumber.getText().toString() != null && !startNumber.getText().toString().equals("")) {
            backNumber = true;
        } else {
            backNumber = false;
        }
        return backNumber;
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    private void setTextViewChange(final TextView ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                helper.update(ID, key, s.toString(), Untils.guanxian);
                Untils.issave = true;
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    private void setEditTextChange(final EditText ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                helper.update(ID, key, charSequence.toString(), Untils.guanxian);
//                if (!"".equals(charSequence.toString()) && charSequence.toString() != null) {
                Untils.issave = true;
//                } else {
//                    Untils.issave = false;
//                }

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

    private void alarmDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setMessage("您未填写开始桩号，是否填写？");
        builder.setTitle("返回提示");
        builder.setPositiveButton("否", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
//                startNumber.setText("未填写");
//                startNumber.setTextColor(Color.parseColor("#999999"));
                helper.update(ID, Untils.linepipe[2], "未填写", Untils.guanxian);
                dialog.dismiss();
                finish();
            }
        });
        builder.setNegativeButton("是", null);
        builder.create().show();
    }

    //蒋勇豪添加
    @Override
    protected void onResume() {
        super.onResume();
//        bitmaplist.clear();
//        bitmaplist.addAll(Baseactivity.tempSelectBitmap);
        if (!Untils.isWode) {
            if (Untils.caremtype.equals(Untils.daningguanxianType)) {
                //蒋勇豪添加
                Untils.setdata(adapter, helper, Untils.daningguanxianType);
            } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
                //蒋勇豪添加
                Untils.setdata(adapter, helper, Untils.dongganquguanxianType);
            }
        }

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
        if (startNumber.getText().toString().equals("")) {
            startNumber.setError("开始桩号不能为空");
            ToastShow.setShow(GuanXianActivity.this, "开始桩号不能为空");
        } else if (endNumber.getText().toString().equals("")) {
            endNumber.setError("结束桩号不能为空");
            ToastShow.setShow(GuanXianActivity.this, "结束桩号不能为空");
        } else {
            setshangchuan();
        }
        Untils.setHidden(this);
    }

    private void setshangchuan() {
        String action = null;
        bar.show();
        Map map = new HashMap();
        if (!isinsert) {
            map.put("operate", "insert");
        }
        map.put("taskid", Untils.taskid);
        map.put("userName", SharedprefrenceHelper.getInstance(GuanXianActivity.this).getUsername());
        if (Untils.caremtype.equals(Untils.daningguanxianType)) {
            action = UploadUrl.daline;
            //蒋勇豪添加
            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.guanxian));
        } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
            action = UploadUrl.dongguanaction;
            //蒋勇豪添加
            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.guanxian));
        }
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(GuanXianActivity.this).gettoken(), GuanXianActivity.this), new Callback.CommonCallback<String>() {
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
                        helper.update(ID, Untils.linepipe[11], "1", Untils.guanxian);
                        for (int i = 0; i < helper.getAttachmentformlist(ID).size(); i++) {
                            fujianshangchuan(helper.getAttachmentformlist(ID).get(i));
                        }
                        finish();
                    }
                    ToastShow.setShow(GuanXianActivity.this, Untils.shibie(status));
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
        String action = null;
        bar.show();
        Map map = new HashMap();
        map.put("taskid", Untils.taskid);
        map.put("stakestart", stakestart);
        map.put("stakeend", stakeend);
        map.put("source", UploadUrl.Android);
        if (Untils.caremtype.equals(Untils.daningguanxianType)) {
            action = UploadUrl.dnqueryline;
            //蒋勇豪添加
        } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
            action = UploadUrl.dgqqueryline;
            //蒋勇豪添加
        }
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(GuanXianActivity.this).gettoken(), GuanXianActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("guanxianchaxun填报", s);
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
                    ToastShow.setShow(GuanXianActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setFujianUpload(map, GuanXianActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(GuanXianActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setUpload(id, GuanXianActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(GuanXianActivity.this, Untils.shibie(status));
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
