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
 * 南干渠排空井上下段
 */
@ContentView(R.layout.activity_south_gqpai_kj)
public class SouthGQPaiKJActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton title_back;
    @ViewInject(R.id.upload_btn_com)
    private Button upload_btn_com;
    @ViewInject(R.id.save_btn_com)
    private Button save_btn_com;
    @ViewInject(R.id.upload_img_btn)
    private TextView upload_img_btn;
    @ViewInject(R.id.upload_movie_btn)
    private TextView upload_movie_btn;

    @ViewInject(R.id.edittext_south_gq_jh)
    private EditText tv_jh;
    @ViewInject(R.id.linearlayout_south_gq_swwd)
    private LinearLayout ll_swwd;//上段需要隐藏的室外温度;
    @ViewInject(R.id.edittext_south_gq_sj)
    private EditText ed_sj;
    @ViewInject(R.id.edittext_south_gq_snwd)
    private EditText ed_snwd;
    @ViewInject(R.id.edittext_south_gq_swwd)
    private EditText ed_swwd;
    @ViewInject(R.id.edittext_south_gq_qingkuangshuoming)
    private EditText ed_qingkuangshuoming;
    @ViewInject(R.id.switch_south_gq_jcl)
    private Switch sw_jcl;
    @ViewInject(R.id.switch_south_gq_wl)
    private Switch sw_wl;
    @ViewInject(R.id.switch_south_gq_hwsbj)
    private Switch sw_hwsbj;
    @ViewInject(R.id.switch_south_gq_shoujing)
    private Switch sw_shoujing;
    @ViewInject(R.id.switch_south_gq_tqk)
    private Switch sw_tqk;
    @ViewInject(R.id.switch_south_gq_jinggai)
    private Switch sw_jinggai;
    @ViewInject(R.id.switch_south_gq_jingshi)
    private Switch sw_jingshi;
    @ViewInject(R.id.switch_south_gq_pati)
    private Switch sw_pati;
    @ViewInject(R.id.switch_south_gq_jianxiudiefa)
    private Switch sw_jianxiudiefa;
    @ViewInject(R.id.switch_south_gq_gongzuodiefa)
    private Switch sw_gongzuodiefa;
    @ViewInject(R.id.switch_south_gq_chukoudiefa)
    private Switch sw_chukoudiefa;
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
    String jinghao;
    private boolean isinsert;
    private LoginDilog bar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Untils.initContent();
        x.view().inject(this);
        bar = new LoginDilog(this, "正在请求");
        Baseactivity.addactvity(this);
        if (Untils.isWode) {
            if (getIntent().getStringExtra("type").equals(Untils.nanganqupaikongjingshang)) {//true默认为南干渠排空井上段
                title_com.setText(Untils.nanganqupaikongjingshang);
                tv_jh.setText(getResources().getString(R.string.paikongjingjh));//排空井井号
                ll_swwd.setVisibility(View.GONE);
            } else {//false默认为南干渠排空井下段
                title_com.setText(Untils.nanganqupaikongjingxia);
                tv_jh.setText(getResources().getString(R.string.jinghao));//"井号"
            }
            setUnable();
            initAdapter();
            setshuju();
            Untils.Finish(title_back, this);
        } else {
            initialUI();
        }
        Untils.biaoid=id;
    }

    //    初始化网络数据
    private void initNetData(HashMap<String, String> EchoMsg) {

        tv_jh.setText(EchoMsg.get(Untils.nanganqupaikong[6]));
        ed_swwd.setText(EchoMsg.get(Untils.nanganqupaikong[14]));
        ed_snwd.setText(EchoMsg.get(Untils.nanganqupaikong[15]));
        ed_qingkuangshuoming.setText(EchoMsg.get(Untils.nanganqupaikong[22]));
        //swtich回显
        sw_jcl.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[9])));
        sw_wl.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[10])));
        sw_hwsbj.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[11])));
        sw_shoujing.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[12])));
        sw_tqk.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[13])));
        sw_jinggai.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[16])));
        sw_pati.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[17])));
        sw_jingshi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[18])));
        sw_jianxiudiefa.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[19])));
        sw_gongzuodiefa.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[20])));
        sw_chukoudiefa.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[21])));
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
        ed_sj.setEnabled(false);
        ed_snwd.setEnabled(false);
        ed_swwd.setEnabled(false);
        tv_jh.setEnabled(false);
        sw_jcl.setEnabled(false);
        sw_wl.setEnabled(false);
        sw_hwsbj.setEnabled(false);
        sw_shoujing.setEnabled(false);
        sw_tqk.setEnabled(false);
        sw_jinggai.setEnabled(false);
        sw_jingshi.setEnabled(false);
        sw_pati.setEnabled(false);
        sw_jianxiudiefa.setEnabled(false);
        sw_gongzuodiefa.setEnabled(false);
        sw_chukoudiefa.setEnabled(false);
        ed_qingkuangshuoming.setEnabled(false);
    }

    private void initialUI() {
        Untils.setIssave();
        initAdapter();
        isEcho = getIntent().getBooleanExtra("isEcho", false);
        jinghao = getIntent().getStringExtra("wellnum");
        saveData_Map = new HashMap();


        if (getIntent().getStringExtra("type").equals(Untils.nanganqupaikongjingshang)) {//true默认为南干渠排空井上段
            title_com.setText(Untils.nanganqupaikongjingshang);
            tv_jh.setText(getResources().getString(R.string.paikongjingjh));//排空井井号
            ll_swwd.setVisibility(View.GONE);
            saveData_Map.put(Untils.nanganqupaikong[2], Untils.nanganqupaikongjingshang);//设定type为南干渠排空井上段
        } else {//false默认为南干渠排空井下段
            title_com.setText(Untils.nanganqupaikongjingxia);
            tv_jh.setText(getResources().getString(R.string.jinghao));//"井号"
            saveData_Map.put(Untils.nanganqupaikong[2], Untils.nanganqupaikongjingxia);//设定type为南干渠排空井下段
        }
        helper = new HelperDb(this);
        if (isEcho) {//包含未完成     回显
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
            tv_jh.setText(jinghao);
            ed_sj.setText(DataTools.tian());

            saveData_Map.put(Untils.nanganqupaikong[0], Untils.taskid);
            saveData_Map.put(Untils.nanganqupaikong[1], id);
            saveData_Map.put(Untils.nanganqupaikong[3], DataTools.getLocaleTime());//设定初值creattime
            saveData_Map.put(Untils.nanganqupaikong[4], Untils.starttime);
            saveData_Map.put(Untils.nanganqupaikong[5], Untils.noupload);//默认未上报
            saveData_Map.put(Untils.nanganqupaikong[6], jinghao);//默认未上报
            saveData_Map.put(Untils.nanganqupaikong[8], DataTools.getLocaleDayOfMonth());//exedate
            //switch设定默认0
            saveData_Map.put(Untils.nanganqupaikong[9], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[10], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[11], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[12], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[13], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[16], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[17], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[18], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[19], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[20], Untils.defaultSwitch);
            saveData_Map.put(Untils.nanganqupaikong[21], Untils.defaultSwitch);
            helper.insertSingleData(saveData_Map, Untils.nanqupaikongxia);
        }
        updateDatas();
        //设定监听
        save_btn_com.setOnClickListener(this);
        title_back.setOnClickListener(this);
        ed_sj.setOnClickListener(this);
        sw_chukoudiefa.setOnClickListener(this);
        sw_jcl.setOnClickListener(this);
        sw_wl.setOnClickListener(this);
        sw_hwsbj.setOnClickListener(this);
        sw_shoujing.setOnClickListener(this);
        sw_tqk.setOnClickListener(this);
        sw_jinggai.setOnClickListener(this);
        sw_jingshi.setOnClickListener(this);
        sw_pati.setOnClickListener(this);
        sw_jianxiudiefa.setOnClickListener(this);
        sw_gongzuodiefa.setOnClickListener(this);
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

    }

    private void initAdapter() {
        if (Untils.caremtype.equals(Untils.nanganqupaikongjingshang)) {
            //蒋勇豪添加
            adapter = Untils.setpop(SouthGQPaiKJActivity.this, Untils.nanganqupaikongjingshang, createtime, adapter, pic_mov_GV);
        } else if (Untils.caremtype.equals(Untils.nanganqupaikongjingxia)) {
            //蒋勇豪添加
            adapter = Untils.setpop(SouthGQPaiKJActivity.this, Untils.nanganqupaikongjingxia, createtime, adapter, pic_mov_GV);
        }
    }

    private void huixian() {

        HashMap<String, String> EchoMsg = helper.getEchoMsg(id, Untils.nanqupaikongxia);
        tv_jh.setText(EchoMsg.get(Untils.nanganqupaikong[6]));
        ed_swwd.setText(EchoMsg.get(Untils.nanganqupaikong[14]));
        ed_snwd.setText(EchoMsg.get(Untils.nanganqupaikong[15]));
        ed_qingkuangshuoming.setText(EchoMsg.get(Untils.nanganqupaikong[22]));
        ed_sj.setText(EchoMsg.get(Untils.nanganqupaikong[8]));
        createtime = EchoMsg.get(Untils.nanganqupaikong[3]);
        Untils.issave = true;
        id = EchoMsg.get(Untils.nanganqupaikong[1]);
        if (Untils.caremtype.equals(Untils.nanganqupaikongjingshang)) {
            //蒋勇豪添加
            Untils.setData(helper, adapter, createtime, Untils.nanganqupaikongjingshang, id);
        } else if (Untils.caremtype.equals(Untils.nanganqupaikongjingxia)) {
            //蒋勇豪添加
            Untils.setData(helper, adapter, createtime, Untils.nanganqupaikongjingxia, id);
        }

        //swtich回显
        sw_jcl.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[9])));
        sw_wl.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[10])));
        sw_hwsbj.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[11])));
        sw_shoujing.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[12])));
        sw_tqk.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[13])));
        sw_jinggai.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[16])));
        sw_pati.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[17])));
        sw_jingshi.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[18])));
        sw_jianxiudiefa.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[19])));
        sw_gongzuodiefa.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[20])));
        sw_chukoudiefa.setChecked(Untils.makeChangeSwitchButton(EchoMsg.get(Untils.nanganqupaikong[21])));
    }

    /**
     * 实时保存edittext和switch数据
     */
    private void updateDatas() {

        Untils.setTextClick(this, tv_jh, id, Untils.nanganqupaikong[6], Untils.nanqupaikongxia);
        setTextViewChange(ed_sj, Untils.nanganqupaikong[8]);
        Untils.setSwitchClick(this, sw_jcl, id, Untils.nanganqupaikong[9], Untils.nanqupaikongxia);
        Untils.setSwitchClick(this, sw_wl, id, Untils.nanganqupaikong[10], Untils.nanqupaikongxia);
        //0."taskid" 1."id" 2. "type" 3."createtime"
// 4. "starttime" 5."isupload" 6. "wellnum"
// 7. "weather" 8. "exedate" 9."march" 10. "crawl"
// 11. "deviceroom" 12. "handwell" 13. "arihole" 154. "temperatureout"
// 15. "temperaturein" 16. "welllid" 17. "ladder" 18. "wellroom"
// 19. "repairgate" 20. "workgate" 21. "exitgate" 22. "remark"
        Untils.setSwitchClick(this, sw_hwsbj, id, Untils.nanganqupaikong[11], Untils.nanqupaikongxia);
        Untils.setSwitchClick(this, sw_shoujing, id, Untils.nanganqupaikong[12], Untils.nanqupaikongxia);
        Untils.setSwitchClick(this, sw_tqk, id, Untils.nanganqupaikong[13], Untils.nanqupaikongxia);


        Untils.setEditClick(this, ed_swwd, id, Untils.nanganqupaikong[14], Untils.nanqupaikongxia);
        Untils.setEditClick(this, ed_snwd, id, Untils.nanganqupaikong[15], Untils.nanqupaikongxia);


        Untils.setSwitchClick(this, sw_jinggai, id, Untils.nanganqupaikong[16], Untils.nanqupaikongxia);
        Untils.setSwitchClick(this, sw_pati, id, Untils.nanganqupaikong[17], Untils.nanqupaikongxia);
        Untils.setSwitchClick(this, sw_jingshi, id, Untils.nanganqupaikong[18], Untils.nanqupaikongxia);
        Untils.setSwitchClick(this, sw_jianxiudiefa, id, Untils.nanganqupaikong[19], Untils.nanqupaikongxia);
        Untils.setSwitchClick(this, sw_gongzuodiefa, id, Untils.nanganqupaikong[20], Untils.nanqupaikongxia);
        Untils.setSwitchClick(this, sw_chukoudiefa, id, Untils.nanganqupaikong[21], Untils.nanqupaikongxia);

        Untils.setEditClick(this, ed_qingkuangshuoming, id, Untils.nanganqupaikong[22], Untils.nanqupaikongxia);

//
//        setEditTextChange(ed_jh, Untils.nanganqupaikong[6]);
//        setEditTextChange(ed_swwd, Untils.nanganqupaikong[14]);
//        setEditTextChange(ed_snwd, Untils.nanganqupaikong[15]);
//        setEditTextChange(ed_qingkuangshuoming, Untils.nanganqupaikong[22]);


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
                    helper.delete(id, Untils.nanqupaikongxia);
                }
                finish();
                //蒋勇豪添加
                Untils.cleardata();
                break;
            case R.id.edittext_south_gq_sj:
                Untils.setShiJian(SouthGQPaiKJActivity.this, 1, ed_sj);
                break;

            case R.id.switch_south_gq_chukoudiefa:
            case R.id.switch_south_gq_jcl:
            case R.id.switch_south_gq_wl:
            case R.id.switch_south_gq_hwsbj:
            case R.id.switch_south_gq_shoujing:
            case R.id.switch_south_gq_tqk:
            case R.id.switch_south_gq_jinggai:
            case R.id.switch_south_gq_jingshi:
            case R.id.switch_south_gq_pati:
            case R.id.switch_south_gq_jianxiudiefa:
            case R.id.switch_south_gq_gongzuodiefa:
                Untils.setHidden(this);
                break;
        }
    }
//    private void setEditTextChange(final EditText ed, final String key) {
//        ed.addTextChangedListener(new TextWatcher() {
//            @Override
//            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {
//
//            }
//
//            @Override
//            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
//                Log.e("1111",charSequence.toString());
//                helper.update(id, key, charSequence.toString(), Untils.nanqupaikongxia);
//                if (!"".equals(charSequence.toString()) && charSequence.toString() != null) {
//                    Untils.issave = true;
//                }
//
//            }
//
//            @Override
//            public void afterTextChanged(Editable editable) {
////                if (editable.toString()!=null||!editable.toString().equals("")||editable.toString()!=""){
////                    Untils.issave = true;
////                }else {
////                    Untils.issave = false;
////                }
//            }
//        });
//    }

    private void setTextViewChange(final TextView ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                Log.e("1111",charSequence.toString());
                helper.update(id, key, charSequence.toString(), Untils.nanqupaikongxia);
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
            if (Untils.caremtype.equals(Untils.nanganqupaikongjingshang)) {
                //蒋勇豪添加
                Untils.setdata(adapter, helper, Untils.nanganqupaikongjingshang);
            } else if (Untils.caremtype.equals(Untils.nanganqupaikongjingxia)) {
                //蒋勇豪添加
                Untils.setdata(adapter, helper, Untils.nanganqupaikongjingxia);
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

    //
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
        map.put("userName", SharedprefrenceHelper.getInstance(SouthGQPaiKJActivity.this).getUsername());
        if (Untils.caremtype.equals(Untils.nanganqupaikongjingshang)) {
            action = UploadUrl.ngqwell;
            //蒋勇豪添加
            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.nanqupaikongxia));
        } else if (Untils.caremtype.equals(Untils.nanganqupaikongjingxia)) {
            action = UploadUrl.ngqwell;
//            //蒋勇豪添加
            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.nanqupaikongxia));
        }
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(SouthGQPaiKJActivity.this).gettoken(), SouthGQPaiKJActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("南干渠排空接口填报", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        intent = new Intent(XunChaActivity.this, XunChaActivity.class);
//                        startActivity(intent);
                        helper.update(id, Untils.nanganqupaikong[5], "1", Untils.nanqupaikongxia);
                        for (int i = 0; i < helper.getAttachmentformlist(id).size(); i++) {
                            fujianshangchuan(helper.getAttachmentformlist(id).get(i));
                        }
                        finish();
                    }
                    ToastShow.setShow(SouthGQPaiKJActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.ngqquerywell, SharedprefrenceHelper.getInstance(SouthGQPaiKJActivity.this).gettoken(), SouthGQPaiKJActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("dong分水chaxun填报", s);
                JSONObject json = null;
                try {//15767.2
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
                    ToastShow.setShow(SouthGQPaiKJActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setFujianUpload(map, SouthGQPaiKJActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(SouthGQPaiKJActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setUpload(id, SouthGQPaiKJActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(SouthGQPaiKJActivity.this, Untils.shibie(status));
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