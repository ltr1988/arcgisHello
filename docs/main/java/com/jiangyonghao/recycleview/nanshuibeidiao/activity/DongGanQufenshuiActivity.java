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

public class DongGanQufenshuiActivity extends Baseactivity implements View.OnClickListener {
    //    头部
    private ImageButton return_comIBTN;
    private TextView title_comTV;
    //保存本地和上传
    private Button upload_btn_com, save_btn_com;
    private TextView upload_img_btn, upload_movie_btn;
    private GridView pic_mov_GV;
    private GridViewAdapter adapter;
    private ListView ganxianLV, zhiguanLV, celiuLV;
    private DongItemChoiceAdapter ganxianAdapter, zhiguanAdapter, celiuAdapter;
    private TextView timeTV;
    private EditText beizhuET, fenshuikouhaoTV;

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
    String createtime = DataTools.getLocaleTime();
    //回显id
    String UID = "";
    //    新建数据时的HashMap 最开始用于保存id
    private HashMap<String, String> map;
    private String biaoid;
    private Chronometer chor_com;
    private LinearLayout xianshi_chor;
    private Intent intent;
    private String time;
    private String fenshuikouhao;
    private LoginDilog bar;
    private boolean isinsert = false;
    private LinearLayout timeTV_linear;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_dong_gan_qufenshui);
        bar = new LoginDilog(this, "正在请求");
        Baseactivity.addactvity(this);
        Untils.initContent();
        isEcho = getIntent().getBooleanExtra("isEcho", false);
        UID = getIntent().getStringExtra("uid");
        fenshuikouhao = getIntent().getStringExtra("wellnum");
        initView();
        timeTV_linear.setVisibility(View.GONE);//日期
        if (Untils.isWode) {
            setUnable();
            initAdapter();
            setshuju();
            Untils.Finish(return_comIBTN, this);
        } else {
            Untils.setIssave();
            adapter = Untils.setpop(DongGanQufenshuiActivity.this, Untils.dongganqufenshuiType, createtime, adapter, pic_mov_GV);//yongh
            if (!isEcho) {
                newMsg();
                isinsert = false;
                Untils.issave = false;//不出提示可能是浏览
            } else {
                isinsert = true;
                Untils.issave = true;//出提示是否保存
                ID = UID;
                EchoMessage();
            }
            Untils.biaoid=ID;
            initAdapter();
            initData();
            initCtrl();
            timeTV.setText(DataTools.getLocaleDayOfMonth());

        }
    }
    private void initNetData(HashMap<String, String> EchoMsg) {
        List<String[]> listKey=new ArrayList<>();
        listKey.add(Untils.dongganqufenshuigankey);
        listKey.add(Untils.dongganqufenshuizhikey);
        listKey.add(Untils.dongganqufenshuicekey);
        List<String[]> nameKey=new ArrayList<>();
        nameKey.add(Untils.dongganqufenshuiganname);
        nameKey.add(Untils.dongganqufenshuizhiname);
        nameKey.add(Untils.dongganqufenshuicename);
        List<ListView> listViews=new ArrayList<>();
        listViews.add(ganxianLV);
        listViews.add(zhiguanLV);
        listViews.add(celiuLV);
        List<DongItemChoiceAdapter> adapters=new ArrayList<>();
        adapters.add(ganxianAdapter);
        adapters.add(zhiguanAdapter);
        adapters.add(celiuAdapter);

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
        beizhuET.setText(EchoMsg.get(Untils.dongganqufenshui[29]) == null ? null : EchoMsg.get(Untils.dongganqufenshui[29]));//备注
        fenshuikouhaoTV.setText(EchoMsg.get(Untils.dongganqufenshui[6]) == null ? null : EchoMsg.get(Untils.dongganqufenshui[6]));//井号

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
    private void initAdapter() {
        ganxianAdapter = new DongItemChoiceAdapter(this, ID, Untils.dongganqufen);
        zhiguanAdapter = new DongItemChoiceAdapter(this, ID, Untils.dongganqufen);
        celiuAdapter = new DongItemChoiceAdapter(this, ID, Untils.dongganqufen);
    }

    private void EchoMessage() {
        HashMap<String, String> EchoMsg = helper.getEchoMsg(UID, Untils.dongganqufen);
        Untils.issave = true;//yongh
        createtime = EchoMsg.get(Untils.dongganqufenshui[3]);
        biaoid = EchoMsg.get(Untils.dongganqufenshui[1]);
        Untils.setData(helper, adapter, createtime, Untils.dongganqufenshuiType, biaoid);
        beizhuET.setText(EchoMsg.get(Untils.dongganqufenshui[29]) == null ? null : EchoMsg.get(Untils.dongganqufenshui[29]));//备注
        fenshuikouhaoTV.setText(EchoMsg.get(Untils.dongganqufenshui[6]) == null ? null : EchoMsg.get(Untils.dongganqufenshui[6]));//井号
        timeTV.setText(EchoMsg.get(Untils.dongganqufenshui[30]) == null ? null : EchoMsg.get(Untils.dongganqufenshui[30]));//日期


    }

    private void newMsg() {
        map = new HashMap<>();
        map.put(Untils.dongganqufenshui[0], Untils.taskid);
        map.put(Untils.dongganqufenshui[1], ID);
        Untils.biaoid = ID;
        map.put(Untils.dongganqufenshui[2], Untils.dongganqufenshuiType);
        map.put(Untils.dongganqufenshui[3], createtime);
        map.put(Untils.dongganqufenshui[4], Untils.starttime);
        map.put(Untils.dongganqufenshui[5], isupload);
        map.put(Untils.dongganqufenshui[6], fenshuikouhao);
//        -------------------------
        map.put(Untils.dongganqufenshui[7], nochecked);//干爬井
        map.put(Untils.dongganqufenshui[8], nochecked);//干围栏
        map.put(Untils.dongganqufenshui[9], nochecked);//干井壁
        map.put(Untils.dongganqufenshui[10], nochecked);//干井底
        map.put(Untils.dongganqufenshui[11], nochecked);//干卫生
        map.put(Untils.dongganqufenshui[12], nochecked);//电动蝶阀
        map.put(Untils.dongganqufenshui[13], nochecked);//伸缩接头
        map.put(Untils.dongganqufenshui[14], nochecked);//手动蝶阀
        map.put(Untils.dongganqufenshui[15], nochecked);//手动球阀
        map.put(Untils.dongganqufenshui[16], nochecked);//支爬井
        map.put(Untils.dongganqufenshui[17], nochecked);//支围栏
        map.put(Untils.dongganqufenshui[18], nochecked);//支井壁
        map.put(Untils.dongganqufenshui[19], nochecked);//支井底
        map.put(Untils.dongganqufenshui[20], nochecked);//支卫生
        map.put(Untils.dongganqufenshui[21], nochecked);//伸缩接头
        map.put(Untils.dongganqufenshui[22], nochecked);//电动蝶阀
        map.put(Untils.dongganqufenshui[23], nochecked);//水爬井
        map.put(Untils.dongganqufenshui[24], nochecked);//水围栏
        map.put(Untils.dongganqufenshui[25], nochecked);//水井壁
        map.put(Untils.dongganqufenshui[26], nochecked);//水井底
        map.put(Untils.dongganqufenshui[27], nochecked);//水卫生
        map.put(Untils.dongganqufenshui[28], nochecked);//止回阀
        map.put(Untils.dongganqufenshui[30], DataTools.getLocaleDayOfMonth());//日期

//        创建新的数据
        helper.insertSingleData(map, Untils.dongganqufen);

    }

    private void initCtrl() {
//        Untils.Finish(return_comIBTN, this);
        return_comIBTN.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!Untils.issave) {
                    helper.delete(ID, Untils.dongganqufen);
                }
                finish();
                Untils.cleardata();
            }
        });
        timeTV.setOnClickListener(this);
//        Untils.Finish(return_comIBTN, this);
        timeTV.setOnClickListener(this);

        if ("0".equals(isupload)) {
            if ((helper.getSingledata(Untils.starttime, isupload, createtime, Untils.dongganqufenshuiType, Untils.dongganqufen).size()) != 0) {
                Untils.setEditClick(this, beizhuET, ID, Untils.dongganqufenshui[29], Untils.dongganqufen); // 备注
                Untils.setTextClick(this, fenshuikouhaoTV, ID, Untils.dongganqufenshui[6], Untils.dongganqufen); // 井号
                Untils.setTextClick(this, timeTV, ID, Untils.dongganqufenshui[30], Untils.dongganqufen); // 日期
            }
        }
    }

    private void initData() {
        List<ItemSingleChoice> ganlist = new ArrayList<>();
        List<ItemSingleChoice> shilist = new ArrayList<>();
        List<ItemSingleChoice> chulist = new ArrayList<>();

        if (!isEcho) {
            ganlist = Untils.BiaodanInfo(Untils.dongganqufenshuiganname, Untils.dongganqufenshuigankey);
            ganxianAdapter.addDatas(ganlist);
            ganxianLV.setAdapter(ganxianAdapter);
            shilist = Untils.BiaodanInfo(Untils.dongganqufenshuizhiname, Untils.dongganqufenshuizhikey);
            zhiguanAdapter.addDatas(shilist);
            zhiguanLV.setAdapter(zhiguanAdapter);
            chulist = Untils.BiaodanInfo(Untils.dongganqufenshuicename, Untils.dongganqufenshuicekey);
            celiuAdapter.addDatas(chulist);
            celiuLV.setAdapter(celiuAdapter);
        } else {
            ganlist = EchoInitData(ganlist, Untils.dongganqufenshuiganname, Untils.dongganqufenshuigankey);
            ganxianAdapter.addDatas(ganlist);
            ganxianLV.setAdapter(ganxianAdapter);
            shilist = EchoInitData(shilist, Untils.dongganqufenshuizhiname, Untils.dongganqufenshuizhikey);
            zhiguanAdapter.addDatas(shilist);
            zhiguanLV.setAdapter(zhiguanAdapter);
            chulist = EchoInitData(chulist, Untils.dongganqufenshuicename, Untils.dongganqufenshuicekey);
            celiuAdapter.addDatas(chulist);
            celiuLV.setAdapter(celiuAdapter);
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
        HashMap<String, String> EchoMsg = helper.getEchoMsg(UID, Untils.dongganqufen);
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
        ganxianLV = (ListView) findViewById(R.id.ganxianjianxiuLV);
        zhiguanLV = (ListView) findViewById(R.id.zhiguanjianxiuLV);
        celiuLV = (ListView) findViewById(R.id.zhiguanceliuLV);
        timeTV = (TextView) findViewById(R.id.DshijianTV);
        fenshuikouhaoTV = (EditText) findViewById(R.id.fenshuikouhaoTV);
        beizhuET = (EditText) findViewById(R.id.DbeizhuET);
        title_comTV.setText("东干渠分水口");
        fenshuikouhaoTV.setText(fenshuikouhao);
        timeTV_linear= (LinearLayout) findViewById(R.id.timeTV_linear);

    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.DshijianTV:
                Untils.setShiJian(DongGanQufenshuiActivity.this, 1, timeTV);
                break;
            case R.id.upload_btn_com:
                setshangchuan();
                break;
            case R.id.save_btn_com:
                ToastShow.setShow(this, "已保存");
                finish();
                break;
        }
    }

    @Override
    protected void onResume() {
        super.onResume();
//        bitmaplist.clear();
//        bitmaplist.addAll(Baseactivity.tempSelectBitmap);
        //蒋勇豪添加
        if (!Untils.isWode){
            Untils.setdata(adapter, helper, Untils.dongganqufenshuiType);

        }
        //
    }

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
        map.put("userName", SharedprefrenceHelper.getInstance(DongGanQufenshuiActivity.this).getUsername());
//        if (Untils.caremtype.equals(Untils.daningguanxianType)) {
//            //蒋勇豪添加
//            map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.guanxian));
//        } else if (Untils.caremtype.equals(Untils.dongganquguanxianType)) {
        //蒋勇豪添加
        map.putAll(helper.getSingledata(Untils.starttime, "0", createtime, Untils.caremtype, Untils.dongganqufen));
//        }
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.dongfen, SharedprefrenceHelper.getInstance(DongGanQufenshuiActivity.this).gettoken(), DongGanQufenshuiActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("dong分水接口填报", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        intent = new Intent(XunChaActivity.this, XunChaActivity.class);
//                        startActivity(intent);
                        helper.update(ID, Untils.dongganqufenshui[5], "1", Untils.dongganqufen);
                        for (int i = 0; i < helper.getAttachmentformlist(ID).size(); i++) {
                            fujianshangchuan(helper.getAttachmentformlist(ID).get(i));
                        }
                        finish();
                    }
                    ToastShow.setShow(DongGanQufenshuiActivity.this, Untils.shibie(status));
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
        map.put("wellnum",fenshuikouhao);
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.dgqquerywater, SharedprefrenceHelper.getInstance(DongGanQufenshuiActivity.this).gettoken(), DongGanQufenshuiActivity.this), new Callback.CommonCallback<String>() {
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
                    ToastShow.setShow(DongGanQufenshuiActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setFujianUpload(map, DongGanQufenshuiActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(DongGanQufenshuiActivity.this, Untils.shibie(status));
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
        x.http().post(Upload.getInstance().setUpload(id, DongGanQufenshuiActivity.this), new Callback.CommonCallback<String>() {

            @Override
            public void onSuccess(String s) {
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    ToastShow.setShow(DongGanQufenshuiActivity.this, Untils.shibie(status));
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
