package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.DongItemChoiceAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.GridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ItemSingleChoice;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DongGanQupaiqiActivity extends Baseactivity implements View.OnClickListener {
    //    头部
    private ImageButton return_comIBTN;
    private TextView title_comTV;
    //保存本地和上传
    private Button upload_btn_com, save_btn_com;
    private TextView upload_img_btn, upload_movie_btn;
    private GridView pic_mov_GV;
    private GridViewAdapter adapter;
    private ListView dishangLV, dixiaLV;
    private DongItemChoiceAdapter dishangAdapter;
    private DongItemChoiceAdapter dixiaAdapter;
    private TextView timeTV;
    private EditText beizhuET, jinghaoTV;
    //
    //    回显
    private Boolean isEcho = false;
    //    isupload
    private String isupload = "0";
    //    ischecked
    private String ischecked = "1";//选中
    private String nochecked = "0";//未选中
    //    DBHelper
    private HelperDb helper = new HelperDb(this);
    //    ID和starttime
    String ID = Untils.setuuid();
    //    String starttime = DataTools.getLocaleTime();
    String createtime = DataTools.getLocaleTime();
    //回显id
    String UID = "";
    //    新建数据时的HashMap 最开始用于保存id
    private HashMap<String, String> map;
    private String biaoid;//add
    private Chronometer chor_com;
    private LinearLayout xianshi_chor;
    private Intent intent;
    private String time;
    private String jinghao;
    private LoginDilog bar;
    private boolean isinsert;
    private LinearLayout timeTV_linear;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dong_gan_qupaiqi);
        bar = new LoginDilog(this, "正在请求");
        Baseactivity.addactvity(this);
        Untils.initContent();
        isEcho = getIntent().getBooleanExtra("isEcho", false);
        UID = getIntent().getStringExtra("uid");
        jinghao = getIntent().getStringExtra("wellnum");
        initView();
         timeTV_linear.setVisibility(View.GONE);
        if (Untils.isWode) {
            setUnable();
            initAdapter();
            setshuju();
            Untils.Finish(return_comIBTN, this);
        } else {
            Untils.setIssave();
            adapter = Untils.setpop(DongGanQupaiqiActivity.this, Untils.dongganqupaiqiType, createtime, adapter, pic_mov_GV);
            if (!isEcho) {
                isinsert = false;
                newMsg();
                Untils.issave = false;//不出提示可能是浏览
            } else {
                Untils.issave = true;//出提示是否保存
                ID = UID;
                isinsert = true;
                EchoMessage();
            }
            initAdapter();
            initData();
            initCtrl();
            timeTV.setText(DataTools.getLocaleDayOfMonth());
        }
        Untils.biaoid=ID;
    }

    //初始化网络数据并绑定适配器
    private void initNetData(HashMap<String, String> EchoMsg) {
        beizhuET.setText(EchoMsg.get(Untils.dongganqupaiqi[20]) == null ? null : EchoMsg.get(Untils.dongganqupaiqi[20]));//备注
        jinghaoTV.setText(EchoMsg.get(Untils.dongganqupaiqi[6]) == null ? null : EchoMsg.get(Untils.dongganqupaiqi[6]));//井号
        timeTV.setText(EchoMsg.get(Untils.dongganqupaiqi[21]) == null ? null : EchoMsg.get(Untils.dongganqupaiqi[21]));//日期
        List<String[]> listKey=new ArrayList<>();
        listKey.add(Untils.dongganqupaiqishangkey);
        listKey.add(Untils.dongganqupaiqixiakey);
        List<String[]> nameKey=new ArrayList<>();
        nameKey.add(Untils.dongganqupaiqishangname);
        nameKey.add(Untils.dongganqupaiqixianame);
        List<ListView> listViews=new ArrayList<>();
        listViews.add(dishangLV);
        listViews.add(dixiaLV);
        List<DongItemChoiceAdapter> adapters=new ArrayList<>();
        adapters.add(dishangAdapter);
        adapters.add(dixiaAdapter);

        for (int i=0;i<listKey.size();i++){
            List<ItemSingleChoice> list = new ArrayList<>();
            for (int j = 0; j < listKey.get(i).length; j++) {
                ItemSingleChoice singleChoice = null;
                if ("1".equals(EchoMsg.get(listKey.get(i)[j]))) {
                    singleChoice = new ItemSingleChoice(nameKey.get(i)[j], true, listKey.get(i)[j]);
                } else {
                    singleChoice = new ItemSingleChoice(nameKey.get(i)[j], false, listKey.get(i)[j]);
                }
                list.add(singleChoice);
            }
            listViews.get(i).setAdapter(adapters.get(i));
            adapters.get(i).addDatas(list);
        }

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
        timeTV.setEnabled(false);
        beizhuET.setEnabled(false);

    }

    //回显数据
    private void EchoMessage() {
        HashMap<String, String> EchoMsg = helper.getEchoMsg(UID, Untils.dongganpaiqi);
        Untils.issave = true;
        createtime = EchoMsg.get(Untils.dongganqupaiqi[3]);
        biaoid = EchoMsg.get(Untils.dongganqupaiqi[1]);
        Untils.setData(helper, adapter, createtime, Untils.dongganqupaiqiType, biaoid);
//add        Untils.issave = true;
//add        createtime = EchoMsg.get(Untils.dongganqupaiqi[3]);
//add        biaoid = EchoMsg.get(Untils.dongganqupaiqi[1]);
//add        Untils.setData(helper, adapter,  createtime,Untils.dongganqupaiqiType,biaoid);
        beizhuET.setText(EchoMsg.get(Untils.dongganqupaiqi[20]) == null ? null : EchoMsg.get(Untils.dongganqupaiqi[20]));//备注
        jinghaoTV.setText(EchoMsg.get(Untils.dongganqupaiqi[6]) == null ? null : EchoMsg.get(Untils.dongganqupaiqi[6]));//井号
        timeTV.setText(EchoMsg.get(Untils.dongganqupaiqi[21]) == null ? null : EchoMsg.get(Untils.dongganqupaiqi[21]));//日期

    }

    //新数据
    private void newMsg() {
        map = new HashMap<>();
        map.put(Untils.dongganqupaiqi[0], Untils.taskid);
        map.put(Untils.dongganqupaiqi[1], ID);
        Untils.biaoid = ID;//add
        map.put(Untils.dongganqupaiqi[2], Untils.dongganqupaiqiType);
        map.put(Untils.dongganqupaiqi[3], createtime);
        map.put(Untils.dongganqupaiqi[4], Untils.starttime);
        map.put(Untils.dongganqupaiqi[5], isupload);
//        -------------------------
        map.put(Untils.dongganqupaiqi[6], jinghao);//上围栏
        map.put(Untils.dongganqupaiqi[7], nochecked);//上围栏
        map.put(Untils.dongganqupaiqi[8], nochecked);//上地面
        map.put(Untils.dongganqupaiqi[9], nochecked);//上气孔
        map.put(Untils.dongganqupaiqi[10], nochecked);//上井盖
        map.put(Untils.dongganqupaiqi[11], nochecked);//上卫生
        map.put(Untils.dongganqupaiqi[12], nochecked);//下爬梯
        map.put(Untils.dongganqupaiqi[13], nochecked);//下护栏
        map.put(Untils.dongganqupaiqi[14], nochecked);//下井壁
        map.put(Untils.dongganqupaiqi[15], nochecked);//下卫生
        map.put(Untils.dongganqupaiqi[16], nochecked);//下气阀
        map.put(Untils.dongganqupaiqi[17], nochecked);//闸阀
        map.put(Untils.dongganqupaiqi[18], nochecked);//球阀
        map.put(Untils.dongganqupaiqi[19], nochecked);//井底
        map.put(Untils.dongganqupaiqi[21], DataTools.getLocaleDayOfMonth());//日期

//        创建新的数据
        helper.insertSingleData(map, Untils.dongganpaiqi);
    }

    private void initCtrl() {
//        Untils.Finish(return_comIBTN, this);
        timeTV.setOnClickListener(this);
        return_comIBTN.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!Untils.issave) {
                    helper.delete(ID, Untils.dongganpaiqi);
                }
                finish();//add
                Untils.cleardata();//add
            }
        });

        if ("0".equals(isupload)) {
            Log.e("1111", "starttime---" + Untils.starttime + "---" + createtime);
            if ((helper.getSingledata(Untils.starttime, isupload, createtime, Untils.dongganqupaiqiType, Untils.dongganpaiqi).size()) != 0) {
                Untils.setEditClick(this, beizhuET, ID, Untils.dongganqupaiqi[20], Untils.dongganpaiqi); // 备注
                Untils.setTextClick(this, jinghaoTV, ID, Untils.dongganqupaiqi[6], Untils.dongganpaiqi); // 井号
                Untils.setTextClick(this, timeTV, ID, Untils.dongganqupaiqi[21], Untils.dongganpaiqi); // 井号

            }
        }
    }

    private void initData() {
        List<ItemSingleChoice> shanglist = new ArrayList<>();
        List<ItemSingleChoice> xialist = new ArrayList<>();
        if (!isEcho) {
            shanglist = Untils.BiaodanInfo(Untils.dongganqupaiqishangname, Untils.dongganqupaiqishangkey);
            dishangAdapter.addDatas(shanglist);
            dishangLV.setAdapter(dishangAdapter);
            xialist = Untils.BiaodanInfo(Untils.dongganqupaiqixianame, Untils.dongganqupaiqixiakey);
            dixiaAdapter.addDatas(xialist);
            dixiaLV.setAdapter(dixiaAdapter);
        } else {
            shanglist = EchoInitData(shanglist, Untils.dongganqupaiqishangname, Untils.dongganqupaiqishangkey);
            dishangAdapter.addDatas(shanglist);
            dishangLV.setAdapter(dishangAdapter);
            xialist = EchoInitData(xialist, Untils.dongganqupaiqixianame, Untils.dongganqupaiqixiakey);
            dixiaAdapter.addDatas(xialist);
            dixiaLV.setAdapter(dixiaAdapter);
        }
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

    //用于回显时候的初始化数据
    private List<ItemSingleChoice> EchoInitData(List<ItemSingleChoice> Echolists, String[] names, String[] keys) {
        HashMap<String, String> EchoMsg = helper.getEchoMsg(UID, Untils.dongganpaiqi);
        for (int i = 0; i < keys.length; i++) {
            ItemSingleChoice singleChoice;
            if ("1".equals(EchoMsg.get(keys[i]))) {
                singleChoice = new ItemSingleChoice(names[i], true, keys[i]);
            } else {
                singleChoice = new ItemSingleChoice(names[i], false, keys[i]);
            }
            Echolists.add(singleChoice);
        }
        return Echolists;
    }

    private void initAdapter() {
        dishangAdapter = new DongItemChoiceAdapter(this, ID, Untils.dongganpaiqi);
        dixiaAdapter = new DongItemChoiceAdapter(this, ID, Untils.dongganpaiqi);
//add        adapter = Untils.setpop(DongGanQupaiqiActivity.this, Untils.dongganqupaiqiType, createtime, adapter, pic_mov_GV);
    }

    private void initView() {
        xianshi_chor = (LinearLayout) findViewById(R.id.xianshi_chor);
        chor_com = (Chronometer) findViewById(R.id.chor_com);
        return_comIBTN = ((ImageButton) findViewById(R.id.return_com));
        title_comTV = (TextView) findViewById(R.id.title_com);
        upload_img_btn = (TextView) findViewById(R.id.upload_img_btn);
        upload_movie_btn = (TextView) findViewById(R.id.upload_movie_btn);
        upload_btn_com = (Button) findViewById(R.id.upload_btn_com);
        save_btn_com = (Button) findViewById(R.id.save_btn_com);
        upload_btn_com.setOnClickListener(this);
        save_btn_com.setOnClickListener(this);
        pic_mov_GV = (GridView) findViewById(R.id.bcsb_GV_com);
        dishangLV = (ListView) findViewById(R.id.dishangLV);
        dixiaLV = (ListView) findViewById(R.id.dixiaLV);
        timeTV = (TextView) findViewById(R.id.DshijianTV);
        jinghaoTV = (EditText) findViewById(R.id.jinghaoTV);
        beizhuET = (EditText) findViewById(R.id.DbeizhuET);
        title_comTV.setText("东干渠排气井");
        jinghaoTV.setText(jinghao);
        timeTV_linear= (LinearLayout) findViewById(R.id.timeTV_linear);

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.DshijianTV:
                Untils.setShiJian(DongGanQupaiqiActivity.this, 1, timeTV);
                break;
            case R.id.save_btn_com:
                finish();
                ToastShow.setShow(this, "保存成功");
                break;
            case R.id.upload_btn_com:
                setshangchuan();
                break;
        }
    }

    //add
    @Override
    protected void onResume() {
        super.onResume();
//        bitmaplist.clear();
//        bitmaplist.addAll(Baseactivity.tempSelectBitmap);
        if (!Untils.isWode) {
            //蒋勇豪添加
            Untils.setdata(adapter, helper, Untils.dongganqupaiqiType);
        }
    }

    //add
    @Override
    protected void onPause() {
        super.onPause();
        Untils.clearonpause();
    }

    private void setshangchuan() {
        bar.show();
        Map map = new HashMap();
        if (!isinsert) {
            map.put("operate", "insert");
        }
        map.put("taskid", Untils.taskid);
        map.put("userName", SharedprefrenceHelper.getInstance(DongGanQupaiqiActivity.this).getUsername());
//        if (Untils.caremtype.equals(Untils.daningguanxianType)) {
//            //蒋勇豪添加
//            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.guanxian));
//        } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
        //蒋勇豪添加
        map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.dongganpaiqi));
//        }
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.dongqi, SharedprefrenceHelper.getInstance(DongGanQupaiqiActivity.this).gettoken(), DongGanQupaiqiActivity.this), new Callback.CommonCallback<String>() {
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
                        helper.update(ID, Untils.dongganqupaiqi[5], "1", Untils.dongganpaiqi);
                        for (int i = 0; i < helper.getAttachmentformlist(ID).size(); i++) {
                            fujianshangchuan(helper.getAttachmentformlist(ID).get(i));
                        }
                        finish();
                    }
                    ToastShow.setShow(DongGanQupaiqiActivity.this, Untils.shibie(status));
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
    private void setshuju(){
        bar.show();
        Map map = new HashMap();
        map.put("taskid", Untils.taskid);
        map.put("wellnum",jinghao);
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.dgqqueryair, SharedprefrenceHelper.getInstance(DongGanQupaiqiActivity.this).gettoken(), DongGanQupaiqiActivity.this), new Callback.CommonCallback<String>() {
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
                                map.put(((JSONObject)jsonObject2.opt(j)).optString("id").toLowerCase(),((JSONObject) jsonObject2.opt(j)).optString("value"));
                            }
                        }
                        initNetData(map);
                        fujianhuixian(map.get("id").toString());
                    }
                    ToastShow.setShow(DongGanQupaiqiActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setFujianUpload(map, DongGanQupaiqiActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(DongGanQupaiqiActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setUpload(id, DongGanQupaiqiActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(DongGanQupaiqiActivity.this, Untils.shibie(status));
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
