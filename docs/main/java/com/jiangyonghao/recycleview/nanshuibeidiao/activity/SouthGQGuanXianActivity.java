package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
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
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;
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

@ContentView(R.layout.activity_south_gqguan_xian)
public class SouthGQGuanXianActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton title_back;
    @ViewInject(R.id.upload_btn_com)
    private Button upload_btn_com;
    @ViewInject(R.id.save_btn_com)
    private Button save_btn_com;
    @ViewInject(R.id.edittext_southdiushi)
    private EditText edittext_southdiushi;
    @ViewInject(R.id.edittext_southzijibuqing)
    private EditText edittext_southzijibuqing;
    @ViewInject(R.id.edittext_southqingxie)
    private EditText edittext_southqingxie;
    @ViewInject(R.id.edittext_southdimian)
    private EditText edittext_southdimian;
    @ViewInject(R.id.edittext_southguanxianweizhi)
    private EditText edittext_southguanxianweizhi;
    @ViewInject(R.id.edittext_southguanxiantongguo)
    private EditText edittext_southguanxiantongguo;
    @ViewInject(R.id.edittext_southguanxianfujin)
    private EditText edittext_southguanxianfujin;
    @ViewInject(R.id.edittext_southzhongzhi)
    private EditText edittext_southzhongzhi;
    @ViewInject(R.id.edittext_southkaigou)
    private EditText edittext_southkaigou;
    @ViewInject(R.id.edittext_southquanzhan)
    private EditText edittext_southquanzhan;
    @ViewInject(R.id.edittext_southduifang)
    private EditText edittext_southduifang;
    @ViewInject(R.id.edittext_southbaopo)
    private EditText edittext_southbaopo;
    @ViewInject(R.id.edittext_southqingdaolaji)
    private EditText edittext_southqingdaolaji;
    @ViewInject(R.id.edittext_southpaifangwushui)
    private EditText edittext_southpaifangwushui;
    @ViewInject(R.id.edittext_southpaishuigou)
    private EditText edittext_southpaishuigou;
    @ViewInject(R.id.edittext_southqitakeneng)
    private EditText edittext_southqitakeneng;
    @ViewInject(R.id.edittext_gqguanxian_qingkuangshuoming)
    private EditText edittext_gqguanxian_qingkuangshuoming;
    @ViewInject(R.id.textView_south_data)
    private TextView textView_south_data;
    @ViewInject(R.id.linear_photo_up)
    private LinearLayout linear_photo_up;
    @ViewInject(R.id.linear_movie_up)
    private LinearLayout linear_movie_up;
    @ViewInject(R.id.bcsb_GV_com)
    private GridView pic_mov_GV;
    @ViewInject(R.id.shuruweizhi)
    private EditText shuruweizhi;
    private GridViewAdapter adapter;
    private String createtime = DataTools.getLocaleTime();
    private HelperDb helper = null;
    private HashMap<String, String> saveData_Map;
    private String id = "";
    private HashMap<String, String> mapList;
    //    回显
    private Intent intent;
    private String time;
    @ViewInject(R.id.chor_com)
    private Chronometer chor_com;
    @ViewInject(R.id.xianshi_chor)
    private LinearLayout xianshi_chor;
    private boolean isinsert;
    private LoginDilog bar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        bar = new LoginDilog(this, "正在请求");
        Baseactivity.addactvity(this);

        if (Untils.isWode) {
            id = getIntent().getStringExtra("id");
            Baseactivity.tempSelectBitmap.clear();
            adapter = new GridViewAdapter(this);
            setUnable();
            setshuju();

            Untils.Finish(title_back, this);
        } else {
            inview();
            intrealtimesave();
        }

    }

    //网络请求数据
    private void initNetData(HashMap<String, String> EchoMsg) {
        id = EchoMsg.get(Untils.nanganquguanxian[1]);
        shuruweizhi.setText(EchoMsg.get(Untils.nanganquguanxian[24]));
        edittext_southdiushi.setText(EchoMsg.get(Untils.nanganquguanxian[6]));
        edittext_southzijibuqing.setText(EchoMsg.get(Untils.nanganquguanxian[7]));
        edittext_southqingxie.setText(EchoMsg.get(Untils.nanganquguanxian[8]));
        edittext_southdimian.setText(EchoMsg.get(Untils.nanganquguanxian[9]));
        edittext_southguanxianweizhi.setText(EchoMsg.get(Untils.nanganquguanxian[10]));
        edittext_southguanxiantongguo.setText(EchoMsg.get(Untils.nanganquguanxian[11]));
        edittext_southguanxianfujin.setText(EchoMsg.get(Untils.nanganquguanxian[12]));
        edittext_southzhongzhi.setText(EchoMsg.get(Untils.nanganquguanxian[13]));
        edittext_southkaigou.setText(EchoMsg.get(Untils.nanganquguanxian[14]));
        edittext_southquanzhan.setText(EchoMsg.get(Untils.nanganquguanxian[15]));
        edittext_southduifang.setText(EchoMsg.get(Untils.nanganquguanxian[16]));
        edittext_southbaopo.setText(EchoMsg.get(Untils.nanganquguanxian[17]));
        edittext_southqingdaolaji.setText(EchoMsg.get(Untils.nanganquguanxian[18]));
        edittext_southpaifangwushui.setText(EchoMsg.get(Untils.nanganquguanxian[19]));
        edittext_southpaishuigou.setText(EchoMsg.get(Untils.nanganquguanxian[20]));
        edittext_southqitakeneng.setText(EchoMsg.get(Untils.nanganquguanxian[21]));
        edittext_gqguanxian_qingkuangshuoming.setText(EchoMsg.get(Untils.nanganquguanxian[22]));
        textView_south_data.setText(EchoMsg.get(Untils.nanganquguanxian[23]));
    }

    private void setUnable() {
        edittext_southdiushi.setEnabled(false);
        edittext_southzijibuqing.setEnabled(false);
        edittext_southqingxie.setEnabled(false);
        edittext_southdimian.setEnabled(false);
        edittext_southguanxianweizhi.setEnabled(false);
        edittext_southguanxiantongguo.setEnabled(false);
        edittext_southguanxianfujin.setEnabled(false);
        edittext_southzhongzhi.setEnabled(false);
        edittext_southkaigou.setEnabled(false);
        edittext_southquanzhan.setEnabled(false);
        edittext_southduifang.setEnabled(false);
        edittext_southbaopo.setEnabled(false);
        edittext_southqingdaolaji.setEnabled(false);
        edittext_southpaifangwushui.setEnabled(false);
        edittext_southpaishuigou.setEnabled(false);
        edittext_southqitakeneng.setEnabled(false);
        edittext_gqguanxian_qingkuangshuoming.setEnabled(false);
        textView_south_data.setEnabled(false);
        linear_photo_up.setEnabled(false);
        linear_photo_up.setVisibility(View.GONE);
        linear_movie_up.setEnabled(false);
        linear_movie_up.setVisibility(View.GONE);
        upload_btn_com.setEnabled(false);
        upload_btn_com.setVisibility(View.GONE);
        save_btn_com.setEnabled(false);
        save_btn_com.setVisibility(View.GONE);
        xianshi_chor.setVisibility(View.GONE);
        adapter = Untils.setpop(SouthGQGuanXianActivity.this, Untils.nanganquguanxianType, createtime, adapter, pic_mov_GV);
        title_com.setText(Untils.nanganquguanxianType);//"南干渠管线";
    }

    private void intrealtimesave() {
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
//        "0taskid", "1id", "2type", "3createtime", "4starttime",
// "5isupload", "6stake_drop", "7stake_rustiness", "8stake_dip"
// , "9water_ground", "10water_nearby", "11water_part", "12water_fountain"
// , "13rules_plant", "14rules_build", "15rules_way", "16rules_stack",
// "17rules_burst", "18rules_solid", "19rules_chem", "20rules_drain",
// "21rules_other", "22remark"
        Untils.setEditClick(this, shuruweizhi, id, Untils.nanganquguanxian[24], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southdiushi, id, Untils.nanganquguanxian[6], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southzijibuqing, id, Untils.nanganquguanxian[7], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southqingxie, id, Untils.nanganquguanxian[8], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southdimian, id, Untils.nanganquguanxian[9], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southguanxianweizhi, id, Untils.nanganquguanxian[10], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southguanxiantongguo, id, Untils.nanganquguanxian[11], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southguanxianfujin, id, Untils.nanganquguanxian[12], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southzhongzhi, id, Untils.nanganquguanxian[13], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southkaigou, id, Untils.nanganquguanxian[14], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southquanzhan, id, Untils.nanganquguanxian[15], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southduifang, id, Untils.nanganquguanxian[16], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southbaopo, id, Untils.nanganquguanxian[17], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southqingdaolaji, id, Untils.nanganquguanxian[18], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southpaifangwushui, id, Untils.nanganquguanxian[19], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southpaishuigou, id, Untils.nanganquguanxian[20], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_southqitakeneng, id, Untils.nanganquguanxian[21], Untils.nanganlinepipe);
        Untils.setEditClick(this, edittext_gqguanxian_qingkuangshuoming, id, Untils.nanganquguanxian[22], Untils.nanganlinepipe);
        Untils.setTextClick(this, textView_south_data, id, Untils.nanganquguanxian[23], Untils.nanganlinepipe);

    }

    private void inview() {
        Untils.initContent();
        saveData_Map = new HashMap();
        helper = new HelperDb(this);
        Untils.setIssave();//是否保存  add
        adapter = Untils.setpop(SouthGQGuanXianActivity.this, Untils.nanganquguanxianType, createtime, adapter, pic_mov_GV);
        title_com.setText(Untils.nanganquguanxianType);//"南干渠管线";
        mapList = (HashMap<String, String>) getIntent().getSerializableExtra("此行数据");
        if (mapList != null) {//包含未完成     回显
            Untils.issave = true;//出提示是否保存
            isinsert = true;
            id = mapList.get(Untils.linepipe[0]);//得到ID值
            huixian();
        } else {
            isinsert = false;
            Untils.issave = false;//不出提示可能是浏览
            id = Untils.setuuid();
            /**
             * 新建表
             */
            textView_south_data.setText(DataTools.tian());
            saveData_Map.put(Untils.nanganquguanxian[0], Untils.taskid);
            saveData_Map.put(Untils.nanganquguanxian[1], id);
            saveData_Map.put(Untils.nanganquguanxian[2], Untils.nanganquguanxianType);
            saveData_Map.put(Untils.nanganquguanxian[3], DataTools.getLocaleTime());//设定初值creattime
            saveData_Map.put(Untils.nanganquguanxian[4], Untils.starttime);
            saveData_Map.put(Untils.nanganquguanxian[5], Untils.noupload);//默认未上报
            saveData_Map.put(Untils.nanganquguanxian[23], textView_south_data.getText().toString());
            helper.insertSingleData(saveData_Map, Untils.nanganlinepipe);
        }
        Untils.biaoid = id;
        //设定监听
        save_btn_com.setOnClickListener(this);
        title_back.setOnClickListener(this);
        textView_south_data.setOnClickListener(this);
    }

    private void huixian() {
        HashMap<String, String> EchoMsg = helper.getEchoMsg(id, Untils.nanganlinepipe);
        Untils.issave = true;
        shuruweizhi.setText(EchoMsg.get(Untils.nanganquguanxian[24]));
        createtime = EchoMsg.get(Untils.nanganquguanxian[3]);
        id = EchoMsg.get(Untils.nanganquguanxian[1]);
        Untils.setData(helper, adapter, createtime, Untils.nanganquguanxianType, id);
        edittext_southdiushi.setText(EchoMsg.get(Untils.nanganquguanxian[6]));
        edittext_southzijibuqing.setText(EchoMsg.get(Untils.nanganquguanxian[7]));
        edittext_southqingxie.setText(EchoMsg.get(Untils.nanganquguanxian[8]));
        edittext_southdimian.setText(EchoMsg.get(Untils.nanganquguanxian[9]));
        edittext_southguanxianweizhi.setText(EchoMsg.get(Untils.nanganquguanxian[10]));
        edittext_southguanxiantongguo.setText(EchoMsg.get(Untils.nanganquguanxian[11]));
        edittext_southguanxianfujin.setText(EchoMsg.get(Untils.nanganquguanxian[12]));
        edittext_southzhongzhi.setText(EchoMsg.get(Untils.nanganquguanxian[13]));
        edittext_southkaigou.setText(EchoMsg.get(Untils.nanganquguanxian[14]));
        edittext_southquanzhan.setText(EchoMsg.get(Untils.nanganquguanxian[15]));
        edittext_southduifang.setText(EchoMsg.get(Untils.nanganquguanxian[16]));
        edittext_southbaopo.setText(EchoMsg.get(Untils.nanganquguanxian[17]));
        edittext_southqingdaolaji.setText(EchoMsg.get(Untils.nanganquguanxian[18]));
        edittext_southpaifangwushui.setText(EchoMsg.get(Untils.nanganquguanxian[19]));
        edittext_southpaishuigou.setText(EchoMsg.get(Untils.nanganquguanxian[20]));
        edittext_southqitakeneng.setText(EchoMsg.get(Untils.nanganquguanxian[21]));
        edittext_gqguanxian_qingkuangshuoming.setText(EchoMsg.get(Untils.nanganquguanxian[22]));
        textView_south_data.setText(EchoMsg.get(Untils.nanganquguanxian[23]));

    }

    @Event(R.id.return_com)
    private void setOnclickback(View view) {
        finish();
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
                    helper.delete(id, Untils.nanganlinepipe);
                }
                finish();
                Untils.cleardata();//add
                break;
            case R.id.textView_south_data:
                Untils.setShiJian(SouthGQGuanXianActivity.this, 1, textView_south_data);
                break;
        }
    }

    //add
    @Override
    protected void onResume() {
        super.onResume();
//        bitmaplist.clear();
//        bitmaplist.addAll(Baseactivity.tempSelectBitmap);
        //蒋勇豪添加
        if (!Untils.isWode) {
            Untils.setdata(adapter, helper, Untils.nanganquguanxianType);
        }
        //
    }

    //add
    @Override
    protected void onPause() {
        super.onPause();
        Untils.clearonpause();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Event(R.id.upload_btn_com)
    private void setshangchuan(View view) {
        if (shuruweizhi.getText().toString().equals("")) {
            shuruweizhi.setError("请输入位置");
            ToastShow.setShow(SouthGQGuanXianActivity.this, "请输入位置");
        } else {
            setshangchuan();
        }
    }

    private void setshangchuan() {
        String action = null;
        bar.show();
        Map map = new HashMap();
        if (!isinsert) {
            map.put("operate", "insert");
        }
        map.put("taskid", Untils.taskid);
        map.put("userName", SharedprefrenceHelper.getInstance(SouthGQGuanXianActivity.this).getUsername());
//        if (Untils.caremtype.equals(Untils.daningguanxianType)) {
        action = UploadUrl.ngqline;
        //蒋勇豪添加
        map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.nanganlinepipe));
//        } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
//            action= UploadUrl.dongguanaction;
//            //蒋勇豪添加
//            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.guanxian));
//        }
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(SouthGQGuanXianActivity.this).gettoken(), SouthGQGuanXianActivity.this), new Callback.CommonCallback<String>() {
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
                        helper.update(id, Untils.nanganquguanxian[5], "1", Untils.nanganlinepipe);
//                        if (helper.getAttachmentformlist(id).size() == 0) {
//                        }
                        for (int i = 0; i < helper.getAttachmentformlist(id).size(); i++) {
                            fujianshangchuan(helper.getAttachmentformlist(id).get(i));
                        }
                        finish();

                    }
                    ToastShow.setShow(SouthGQGuanXianActivity.this, Untils.shibie(status));
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
        map.put("ngqid", id);
//        map.put("stakeend",stakeend);
        map.put("source", UploadUrl.Android);
        action = UploadUrl.ngqqueryline;
        //蒋勇豪添加
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(SouthGQGuanXianActivity.this).gettoken(), SouthGQGuanXianActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("nanganquchaxun填报", s);
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
//                        Log.e("ddd", "onSuccess: "+map.toString() );
                        fujianhuixian(map.get("id").toString());
                    }
                    ToastShow.setShow(SouthGQGuanXianActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setFujianUpload(map, SouthGQGuanXianActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                Log.e("填报", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(SouthGQGuanXianActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setUpload(id, SouthGQGuanXianActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                Log.e("huixian", "onSuccess: "+s.toString());
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        String status = json.getString(UploadUrl.backkey[0]);
                        JSONObject jsonObject = json.getJSONObject(UploadUrl.backkey[2]);
                        JSONArray jrr = jsonObject.optJSONArray(UploadUrl.backkey[6]);
                        for (int i = 0; i < jrr.length(); i++) {
                            JSONArray jsonObject2 = null;
                            String id=null,name=null;
                            jsonObject2 = (JSONArray) jrr.opt(i);
                            ImageItem item = new ImageItem();
                            for (int j = 0; j < jsonObject2.length(); j++) {
                                if (((JSONObject) jsonObject2.opt(j)).optString("id").equals("ID")) {
                                    id = ((JSONObject) jsonObject2.opt(j)).optString("value");
                                } else if (((JSONObject) jsonObject2.opt(j)).optString("id").equals("NAME")) {
                                    name = ((JSONObject) jsonObject2.opt(j)).optString("value");
                                }else if (((JSONObject) jsonObject2.opt(j)).optString("id").equals("FILE_TYPE")) {
                                    if(((JSONObject) jsonObject2.opt(j)).optString("value").toString().equals("image")){
                                        item.setType(Untils.zhaopian);
                                    }else if(((JSONObject) jsonObject2.opt(j)).optString("value").toString().equals("video")){
                                        item.setType(Untils.shipin);
                                    }
                                }
                            }
                            item.setPath(Untils.path+"down/"+name);
                            Log.e("ddd",item.getPath()+"dd");
                            downupload(id,name,item);
                        }
                    }
                    ToastShow.setShow(SouthGQGuanXianActivity.this, Untils.shibie(status));
                }catch (Exception e){
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
    private void downupload(String id, String url, final ImageItem item){
        x.http().post(Upload.getInstance().setUpload(id,url,SouthGQGuanXianActivity.this),new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
//                Log.e("ss",s.toString());
                Baseactivity.tempSelectBitmap.add(item);
                adapter.setImage(Baseactivity.tempSelectBitmap);
            }

            @Override
            public void onError(Throwable throwable, boolean b) {

            }

            @Override
            public void onCancelled(CancelledException e) {

            }

            @Override
            public void onFinished() {

            }
        });
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        Baseactivity.tempSelectBitmap.clear();
    }
}
