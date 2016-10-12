package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
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
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.GridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.ItemChoiceAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ItemChoice;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ListViewForScrollView;
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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@ContentView(R.layout.activity_da_ning_double_pai)
public class DaNingDoublePaiActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.upload_img_btn)
    private TextView upload_img_btn;
    @ViewInject(R.id.upload_movie_btn)
    private TextView upload_movie_btn;
    @ViewInject(R.id.listview_double_shebei)
    private ListViewForScrollView listViewQingKuang;
    @ViewInject(R.id.editText_double_jinghao)
    private EditText jinghao;
    @ViewInject(R.id.editText_double_huanjingsheshi)
    private EditText huanjingsheshi;
    @ViewInject(R.id.editText_double_tianqiqingkuang)
    private TextView tianqiqingkuang;
    @ViewInject(R.id.zuoxianET_fating)
    private EditText zuoxian_fating;
    @ViewInject(R.id.youxianET_fating)
    private EditText youxian_fating;
    @ViewInject(R.id.zuoxianET_jingnei)
    private EditText zuoxian_jingnei;
    @ViewInject(R.id.youxianET_jingnei)
    private EditText youxian_jingnei;
    @ViewInject(R.id.save_btn_com)
    private Button save_btn_com;//保存至本地
    @ViewInject(R.id.editText_double_beizhu)
    private EditText beizhu;

    @ViewInject(R.id.textView_double_riqi)
    private TextView shijian;
    private GridViewAdapter adapter;
    private String createtime = DataTools.getLocaleTime();
    @ViewInject(R.id.bcsb_GV_com)
    private GridView pic_mov_GV;
    private ItemChoiceAdapter adapterQingKuang;
    private HelperDb helper = null;
    private HashMap<String, String> saveData_Map;
    private String id = "";
    //    回显
    private Boolean isEcho = false;
    public static ArrayList<ItemChoice> daningDoubleInfo = null;//大宁排空井的左手阀右手阀实体内容
    private Intent intent;
    private String time;
    @ViewInject(R.id.chor_com)
    private Chronometer chor_com;
    @ViewInject(R.id.xianshi_chor)
    private LinearLayout xianshi_chor;
    @ViewInject(R.id.upload_btn_com)
    private Button upload_btn_com;
    String jinghaostr;
    private boolean isinsert;
    private LoginDilog bar;
    private Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            String weather1 = (String) msg.obj;
            tianqiqingkuang.setText(weather1);
            saveData_Map.put(Untils.daningjing[18], weather1);
        }
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        bar = new LoginDilog(this, "正在请求");
        Baseactivity.addactvity(this);
        saveData_Map = new HashMap();
        Untils.getTianqi(handler, this);
        jinghaostr = getIntent().getStringExtra("wellnum");
        if (getIntent().getStringExtra("type").equals(Untils.daningpaiqifajing)) {//getIntent().getStringExtra("type").equals(Untils.nanganqupaikongjingshang)
            title_com.setText(Untils.daningpaiqifajing);
        } else {
            title_com.setText(Untils.daningpaikongjing);
        }
        if (Untils.isWode) {
            setUnable();
//            initAdapter();
            adapterQingKuang = new ItemChoiceAdapter(this);
            listViewQingKuang.setAdapter(adapterQingKuang);
            setshuju();
            Untils.Finish(return_com, this);
        } else {
            initialUI();
        }
    }

    private void initNetData(HashMap<String, String> EchoMsg) {
        //蒋勇豪添加
        shijian.setText(EchoMsg.get(Untils.daningjing[5]));
        tianqiqingkuang.setText(EchoMsg.get(Untils.daningjing[18]));
        jinghao.setText(EchoMsg.get(Untils.daningjing[6]));

        huanjingsheshi.setText(EchoMsg.get(Untils.daningjing[17]));


        zuoxian_fating.setText(EchoMsg.get(Untils.daningjing[19]));//左线阀体温度
        youxian_fating.setText(EchoMsg.get(Untils.daningjing[20]));
        zuoxian_jingnei.setText(EchoMsg.get(Untils.daningjing[21]));//左线井内温度
        youxian_jingnei.setText(EchoMsg.get(Untils.daningjing[22]));
        beizhu.setText(EchoMsg.get(Untils.daningjing[18]));
        huixianListData(EchoMsg);
    }

    private void setUnable() {
        xianshi_chor.setVisibility(View.GONE);
        upload_img_btn.setEnabled(false);
        upload_movie_btn.setEnabled(false);
        upload_btn_com.setEnabled(false);
        upload_btn_com.setVisibility(View.GONE);
        save_btn_com.setEnabled(false);
        save_btn_com.setVisibility(View.GONE);
        jinghao.setEnabled(false);
    }


    private void initialUI() {
        Untils.initContent();
        Untils.setIssave();
        initAdapter();
        isEcho = getIntent().getBooleanExtra("isEcho", false);

        if (getIntent().getStringExtra("type").equals(Untils.daningpaiqifajing)) {//getIntent().getStringExtra("type").equals(Untils.nanganqupaikongjingshang)
            title_com.setText(Untils.daningpaiqifajing);
//            jinghao.setText(getResources().getString(R.string.jinghao));//排气井井号
            saveData_Map.put(Untils.daningjing[2], Untils.daningpaiqifajing);//设定type大宁排气阀井
        } else {
            title_com.setText(Untils.daningpaikongjing);
//            jinghao.setText(getResources().getString(R.string.jinghao));//"井号"
            saveData_Map.put(Untils.daningjing[2], Untils.daningpaikongjing);//设定type大宁排空井
        }
        helper = new HelperDb(this);
        if (isEcho) {//包含未完成     回显
            isinsert = true;
            Untils.issave = true;//出提示是否保存
            id = getIntent().getStringExtra("uid");
            adapterQingKuang = new ItemChoiceAdapter(this, id);
            huixian();
            //---------------------------------
        } else {
            isinsert = false;
            Untils.issave = false;//不出提示可能是浏览
            id = Untils.setuuid();
            adapterQingKuang = new ItemChoiceAdapter(this, id);

            /**
             * 新建表
             */
            shijian.setText(DataTools.tian());
            jinghao.setText(jinghaostr);
            saveData_Map.put(Untils.daningjing[0], Untils.taskid);
            saveData_Map.put(Untils.daningjing[1], id);
            saveData_Map.put(Untils.daningjing[3], DataTools.getLocaleTime());//设定初值creattime
            saveData_Map.put(Untils.daningjing[4], Untils.starttime);
            saveData_Map.put(Untils.daningjing[24], Untils.noupload);//默认未上报
            saveData_Map.put(Untils.daningjing[6], jinghaostr);//默认未上报
            saveData_Map.put(Untils.daningjing[5], shijian.getText().toString());//日期

            //list的左右手阀设置初始值为false
            saveData_Map.put(Untils.daningjing[7], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[8], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[9], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[10], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[11], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[12], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[13], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[14], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[15], Untils.defaultSwitch);
            saveData_Map.put(Untils.daningjing[16], Untils.defaultSwitch);
            helper.insertSingleData(saveData_Map, Untils.daning);
            HashMap<String, String> EchoMsg = helper.getEchoMsg(id, Untils.daning);
            huixianListData(EchoMsg);
        }


        updateDatas();
        //设定监听
        return_com.setOnClickListener(this);
        shijian.setOnClickListener(this);
        save_btn_com.setOnClickListener(this);
//        adapterQingKuang.addDatas();
        listViewQingKuang.setAdapter(adapterQingKuang);
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
        tianqiqingkuang.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                helper.update(id, Untils.daningjing[18], s.toString(), Untils.daning);
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
        Untils.biaoid=id;
    }

    private void initAdapter() {

        if (Untils.caremtype.equals(Untils.daningpaiqifajing)) {
            //蒋勇豪添加
            adapter = Untils.setpop(DaNingDoublePaiActivity.this, Untils.daningpaiqifajing, createtime, adapter, pic_mov_GV);
        } else if (Untils.caremtype.equals(Untils.daningpaikongjing)) {
            //蒋勇豪添加
            adapter = Untils.setpop(DaNingDoublePaiActivity.this, Untils.daningpaikongjing, createtime, adapter, pic_mov_GV);
        }
    }

    private void updateDatas() {
        Untils.setEditClick(this, jinghao, id, Untils.daningjing[6], Untils.daning);
        Untils.setEditClick(this, huanjingsheshi, id, Untils.daningjing[17], Untils.daning);
        Untils.setEditClick(this, zuoxian_fating, id, Untils.daningjing[19], Untils.daning);
        Untils.setEditClick(this, youxian_fating, id, Untils.daningjing[20], Untils.daning);
        Untils.setEditClick(this, zuoxian_jingnei, id, Untils.daningjing[21], Untils.daning);
        Untils.setEditClick(this, youxian_jingnei, id, Untils.daningjing[22], Untils.daning);
        Untils.setTextClick(this, shijian, id, Untils.daningjing[5], Untils.daning);
        Untils.setEditClick(this, beizhu, id, Untils.daningjing[18], Untils.daning);

    }

    private void huixian() {
        HashMap<String, String> EchoMsg = helper.getEchoMsg(id, Untils.daning);
        //蒋勇豪添加
        createtime = EchoMsg.get(Untils.daningjing[3]);
        if (Untils.caremtype.equals(Untils.daningpaiqifajing)) {
            //蒋勇豪添加
            Untils.setData(helper, adapter, createtime, Untils.daningpaiqifajing, id);
        } else if (Untils.caremtype.equals(Untils.daningpaikongjing)) {
            //蒋勇豪添加
            Untils.setData(helper, adapter, createtime, Untils.daningpaikongjing, id);
        }
        shijian.setText(EchoMsg.get(Untils.daningjing[5]));
        tianqiqingkuang.setText(EchoMsg.get(Untils.daningjing[18]));
        jinghao.setText(EchoMsg.get(Untils.daningjing[6]));

        huanjingsheshi.setText(EchoMsg.get(Untils.daningjing[17]));


        zuoxian_fating.setText(EchoMsg.get(Untils.daningjing[19]));//左线阀体温度
        youxian_fating.setText(EchoMsg.get(Untils.daningjing[20]));
        zuoxian_jingnei.setText(EchoMsg.get(Untils.daningjing[21]));//左线井内温度
        youxian_jingnei.setText(EchoMsg.get(Untils.daningjing[22]));
        beizhu.setText(EchoMsg.get(Untils.daningjing[18]));
        huixianListData(EchoMsg);
    }


    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.save_btn_com://保存至本地
//                helper.update(id, Untils.nanganqupaikong[5], Untils.upload, Untils.nanqupaikongxia);//将未上报0改为已上报1
                ToastShow.setShow(this, "保存成功！！！");
                finish();
                break;
            case R.id.return_com:
                if (!Untils.issave) {
                    helper.delete(id, Untils.daning);
                }
                finish();
                Untils.cleardata();//add
                break;
            case R.id.textView_double_riqi:
                Untils.setShiJian(DaNingDoublePaiActivity.this, 1, shijian);
                break;
        }
    }

    /**
     * 回显list中的数据
     *
     * @param EchoMsg
     */
    private void huixianListData(HashMap<String, String> EchoMsg) {
        //    0"taskid", 1"id", 2"type", 3"createtime", 4"starttime", 5"exedate", 6"wellnum", 7"handgateleft"
        // , 8"handgateright", 9"airgateleft", 10"airgateright",11 "pondleft", 12"pondright", 13"warmleft",
        // 14"warmright", 15"negativeleft", 16"negativelright", 17"environment", 18"weather", 19"gatetemperatureleft"
        // , 20"gatetemperatureright", 21"welltemperatureleft", 22"welltemperatureright", 23"remark", 24"isupload"};
        daningDoubleInfo = new ArrayList<>();
        daningDoubleInfo.add(new ItemChoice(Untils.daningpaikongjingSwitch[0], Untils.daningpaikongjingSwitch[5], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[7]))), Untils.daningpaikongjingSwitch[6], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[8])))));
        daningDoubleInfo.add(new ItemChoice(Untils.daningpaikongjingSwitch[1], Untils.daningpaikongjingSwitch[5], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[9]))), Untils.daningpaikongjingSwitch[6], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[10])))));
        daningDoubleInfo.add(new ItemChoice(Untils.daningpaikongjingSwitch[2], Untils.daningpaikongjingSwitch[5], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[11]))), Untils.daningpaikongjingSwitch[6], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[12])))));
        daningDoubleInfo.add(new ItemChoice(Untils.daningpaikongjingSwitch[3], Untils.daningpaikongjingSwitch[5], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[13]))), Untils.daningpaikongjingSwitch[6], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[14])))));
        daningDoubleInfo.add(new ItemChoice(Untils.daningpaikongjingSwitch[4], Untils.daningpaikongjingSwitch[5], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[15]))), Untils.daningpaikongjingSwitch[6], (Untils.makeChangeSwitchButton(EchoMsg.get(Untils.daningjing[16])))));
        adapterQingKuang.addDatas(daningDoubleInfo);
        adapterQingKuang.notifyDataSetChanged();
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (!Untils.isWode) {
            if (Untils.caremtype.equals(Untils.daningpaiqifajing)) {
                //蒋勇豪添加
                Untils.setdata(adapter, helper, Untils.daningpaiqifajing);
            } else if (Untils.caremtype.equals(Untils.daningpaikongjing)) {
                //蒋勇豪添加
                Untils.setdata(adapter, helper, Untils.daningpaikongjing);
            }
        }
    }

    //add
    @Override
    protected void onPause() {
        super.onPause();
        Untils.clearonpause();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK)
            return true;
        return super.onKeyDown(keyCode, event);
    }

    @Event(R.id.upload_btn_com)
    private void setshangchuan(View view) {
        setshangchuan();
    }

    private void setshangchuan() {
        bar.show();
        String action = null;
        Map map = new HashMap();
        if (!isinsert) {
            map.put("operate", "insert");
        }
        map.put("taskid", Untils.taskid);
        map.put("userName", SharedprefrenceHelper.getInstance(DaNingDoublePaiActivity.this).getUsername());
        if (Untils.caremtype.equals(Untils.daningpaiqifajing)) {
            action = UploadUrl.dnair;
            //蒋勇豪添加
            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.daning));
        } else if (Untils.caremtype.equals(Untils.daningpaikongjing)) {
            action = UploadUrl.dnwell;
            //蒋勇豪添加
            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.daning));
        }
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(DaNingDoublePaiActivity.this).gettoken(), DaNingDoublePaiActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("dongpaiqi接口填报", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        intent = new Intent(XunChaActivity.this, XunChaActivity.class);
//                        startActivity(intent);
                        helper.update(id, Untils.daningjing[24], "1", Untils.daning);
                        for (int i = 0; i < helper.getAttachmentformlist(id).size(); i++) {
                            fujianshangchuan(helper.getAttachmentformlist(id).get(i));
                        }
                        finish();
                    }
                    ToastShow.setShow(DaNingDoublePaiActivity.this, Untils.shibie(status));
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
        map.put("wellnum", jinghaostr);
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        if (Untils.caremtype.equals(Untils.daningpaiqifajing)) {
            action = UploadUrl.dnqueryair;
        } else if (Untils.caremtype.equals(Untils.daningpaikongjing)) {
            action = UploadUrl.dnquerywell;
        }
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(DaNingDoublePaiActivity.this).gettoken(), DaNingDoublePaiActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("dong分水chaxun填报", s);
//                String s1=" {\"data\":[[{\"id\":\"ID\",\"fieldtype\":\"String\",\"title\":\"填写状态：0未填；1填写\",\"value\":\"06eef774-ff1a-4923-b519-a6a365333771\",\"showtype\":\"show\"},{\"id\":\"WELLNUM\",\"fieldtype\":\"String\",\"title\":\"井内温度右线\",\"value\":\"G0401001037\",\"showtype\":\"show\"},{\"id\":\"WEATHER\",\"fieldtype\":\"Text\",\"title\":\"情况说明\",\"value\":\"获取失败\",\"showtype\":\"show\"},{\"id\":\"EXEDATE\",\"fieldtype\":\"String\",\"title\":\"所属段\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"HANDGATELEFT\",\"fieldtype\":\"String\",\"title\":\"所属任务外键\",\"value\":\"1\",\"showtype\":\"show\"},{\"id\":\"HANDGATERIGHT\",\"fieldtype\":\"TIMESTAMP(6)\",\"title\":\"添加时间\",\"value\":\"0\",\"showtype\":\"show\"},{\"id\":\"AIRGATELEFT\",\"fieldtype\":\"String\",\"title\":\"添加人\",\"value\":\"0\",\"showtype\":\"show\"},{\"id\":\"AIRGATERIGHT\",\"fieldtype\":\"String\",\"title\":\"存储状态\",\"value\":\"0\",\"showtype\":\"show\"},{\"id\":\"PONDLEFT\",\"fieldtype\":\"String\",\"title\":\"名称\",\"value\":\"0\",\"showtype\":\"show\"},{\"id\":\"PONDRIGHT\",\"fieldtype\":\"String\",\"title\":\"ID\",\"value\":\"0\",\"showtype\":\"show\"},{\"id\":\"WARMLEFT\",\"fieldtype\":\"String\",\"title\":\"井号\",\"value\":\"1\",\"showtype\":\"show\"},{\"id\":\"WARMRIGHT\",\"fieldtype\":\"String\",\"title\":\"天气情况\",\"value\":\"0\",\"showtype\":\"show\"},{\"id\":\"NEGATIVELEFT\",\"fieldtype\":\"String\",\"title\":\"执行时间\",\"value\":\"0\",\"showtype\":\"show\"},{\"id\":\"NEGATIVELRIGHT\",\"fieldtype\":\"String\",\"title\":\"手阀情况左\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"ENVIRONMENT\",\"fieldtype\":\"String\",\"title\":\"手阀情况右\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"GATETEMPERATURELEFT\",\"fieldtype\":\"String\",\"title\":\"空气阀情况左\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"GATETEMPERATURERIGHT\",\"fieldtype\":\"String\",\"title\":\"空气阀情况右\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"WELLTEMPERATURELEFT\",\"fieldtype\":\"String\",\"title\":\"积水情况左\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"WELLTEMPERATURERIGHT\",\"fieldtype\":\"String\",\"title\":\"积水情况右\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"REMARK\",\"fieldtype\":\"String\",\"title\":\"保温设施左\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"STAGE\",\"fieldtype\":\"String\",\"title\":\"保温设施右\",\"value\":\"469cfeea-897c-43c8-8c98-2f2b2bb48b4c\",\"showtype\":\"show\"},{\"id\":\"TASKID\",\"fieldtype\":\"String\",\"title\":\"阴极保护左\",\"value\":\"8aecd19c-4709-424a-a25f-aff9f43b6537\",\"showtype\":\"show\"},{\"id\":\"ADDTIME\",\"fieldtype\":\"String\",\"title\":\"阴极保护右\",\"value\":{\"date\":\"20\",\"day\":\"2\",\"hours\":\"10\",\"minutes\":\"48\",\"month\":\"8\",\"nanos\":\"129000000\",\"seconds\":\"53\",\"time\":\"1474339733129\",\"timezoneOffset\":\"-480\",\"year\":\"116\"},\"showtype\":\"show\"},{\"id\":\"ADDUSER\",\"fieldtype\":\"String\",\"title\":\"环境设施\",\"value\":\"78b91a06-8c80-435d-ab6a-3c1b97cf929b\",\"showtype\":\"show\"},{\"id\":\"STATE\",\"fieldtype\":\"String\",\"title\":\"阀体温度左线\",\"value\":\"1\",\"showtype\":\"show\"},{\"id\":\"WELLNAME\",\"fieldtype\":\"String\",\"title\":\"阀体温度右线\",\"value\":\"\",\"showtype\":\"show\"},{\"id\":\"STATUS\",\"fieldtype\":\"String\",\"title\":\"井内温度左线\",\"value\":\"\",\"showtype\":\"show\"}]],\"msg\":\"信息反馈成功!\",\"status\":\"100\"}";
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
                    ToastShow.setShow(DaNingDoublePaiActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setFujianUpload(map, DaNingDoublePaiActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(DaNingDoublePaiActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setUpload(id, DaNingDoublePaiActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(DaNingDoublePaiActivity.this, Untils.shibie(status));
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
