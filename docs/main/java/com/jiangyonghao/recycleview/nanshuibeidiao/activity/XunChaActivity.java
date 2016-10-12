package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.app.Activity;
import android.app.ProgressDialog;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.view.Window;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.XunChaAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ListViewForScrollView;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.XunChaInfo;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ShowInsDog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ContentView(R.layout.activity_xun_cha)
public class XunChaActivity extends Activity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.upload_btn_com)
    private Button upload_btn_com;
    @ViewInject(R.id.save_btn_com)
    private Button save_btn_com;
    @ViewInject(R.id.listView_xuncha)
    private ListViewForScrollView listView;
    @ViewInject(R.id.save_Chronometer)
    private Chronometer chronometer;
    @ViewInject(R.id.timer_linear)
    private LinearLayout timerLin;
    private XunChaAdapter adapter;
    private String starttime;
    private Intent intent;
    private HelperDb helperDb;
    private boolean isPause = false;
    private String time;
    private ProgressDialog pro;
    @ViewInject(R.id.search_roadTV)
    private TextView search_roadTV;
    List<XunChaInfo> xunChaList;
    private LoginDilog bar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        bar = new LoginDilog(this,"正在请求...");
        initialUI();
        Baseactivity.addactvity(this);

    }

    private void initialUI() {
        x.view().inject(this);
        search_roadTV.setText("基本信息");
        if (!Untils.isWode){
            search_roadTV.setVisibility(View.VISIBLE);
        }
        search_roadTV.setTextColor(getResources().getColor(R.color.textColorBlack));
        search_roadTV.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ShowInsDog diog = new ShowInsDog(XunChaActivity.this);
                diog.requestWindowFeature(Window.FEATURE_NO_TITLE);
                diog.show();
            }
        });
        pro = new ProgressDialog(this);
        pro.requestWindowFeature(Window.FEATURE_NO_TITLE);
        pro.setCanceledOnTouchOutside(false);
        pro.setTitle("正在上传,请等待...");
        chronometer = (Chronometer) findViewById(R.id.save_Chronometer);
        helperDb = new HelperDb(this);
        intent = getIntent();
        starttime = Untils.starttime;
        title_com.setText(Untils.xunchaType);//设置抬头
        upload_btn_com.setText("暂停");
        save_btn_com.setText("结束任务");
        if (Untils.isWode){
            upload_btn_com.setVisibility(View.GONE);
            save_btn_com.setVisibility(View.GONE);
            timerLin.setVisibility(View.GONE);
        }
        return_com.setOnClickListener(this);
        upload_btn_com.setOnClickListener(this);
        save_btn_com.setOnClickListener(this);
        adapter = new XunChaAdapter(this);
//listView.setEmptyView(TextView);
        xunChaList = new ArrayList<>();
        XunChaInfo info1 = new XunChaInfo("大宁管线", "");
        XunChaInfo info2 = new XunChaInfo("大宁排空井", "");
        XunChaInfo info3 = new XunChaInfo("大宁排气阀井", "");

        XunChaInfo info4 = new XunChaInfo("东干渠管线", "");
        XunChaInfo info5 = new XunChaInfo("东干渠排空井", "");
        XunChaInfo info6 = new XunChaInfo("东干渠排气阀井", "");
        XunChaInfo info7 = new XunChaInfo("东干渠分水口", "");
        XunChaInfo info8 = new XunChaInfo("南干渠管线", "");
        XunChaInfo info9 = new XunChaInfo("南干渠排空井上段", "");
        XunChaInfo info10 = new XunChaInfo("南干渠排空井下段", "");
        XunChaInfo info11 = new XunChaInfo("南干渠排气阀井上段", "");
        XunChaInfo info12 = new XunChaInfo("南干渠排气阀井下段", "");
//        xunChaList.add(info1);
//        xunChaList.add(info2);
//        xunChaList.add(info3);
//        xunChaList.add(info4);
//        xunChaList.add(info5);
//        xunChaList.add(info6);
//        xunChaList.add(info7);
//        xunChaList.add(info8);
//        xunChaList.add(info9);
//        xunChaList.add(info10);
//        xunChaList.add(info11);
//        xunChaList.add(info12);
        listView.setAdapter(adapter);
//        adapter.addDatas(xunChaList);
        setqingqiu();
        if (starttime != null) {
            if (helperDb.getInspectionmessage(starttime).size() > 0) {
                chronometer.setText(helperDb.getInspectionmessage(starttime).get(Untils.inspectionmessage[3]));
            }
        }
        chronometer
                .setBase(Untils.setTime(chronometer));
        chronometer.start();
        chronometer.setOnChronometerTickListener(new Chronometer.OnChronometerTickListener() {
            @Override
            public void onChronometerTick(Chronometer chronometer) {
                Untils.time = chronometer.getText().toString();
                helperDb.updatestarttime(starttime, Untils.inspectionmessage[3], chronometer.getText().toString(), Untils.xunchaxinxi);
//                Log.e("onChronometerTick: ",chronometer.getText().toString());
            }
        });
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.return_com:
                helperDb.updatestarttime(starttime, Untils.inspectionmessage[3], chronometer.getText().toString(), Untils.xunchaxinxi);
                helperDb.updatestarttime(starttime, Untils.inspectionmessage[2], DataTools.getLocaleTime(), Untils.xunchaxinxi);
                finish();
//                Untils.isUncompleted = true;
                break;
            case R.id.upload_btn_com:
                if (!isPause) {
                    chronometer.stop();
                    isPause = true;
                    upload_btn_com.setText("继续计时");
                } else {
                    chronometer
                            .setBase(Untils.setTime(chronometer));
                    chronometer.start();
                    pauseText();
                }
                setshangchuan(1);
                break;
            case R.id.save_btn_com:
//                pro.show();
                setshangchuan(0);
                helperDb.updatestarttime(starttime, Untils.inspectionmessage[2], DataTools.getLocaleTime(), Untils.xunchaxinxi);
                finish();
                break;
        }
    }
private void setqingqiu(){
    bar.show();
    Map map = new HashMap();
    map.put("id", Untils.taskid);
    x.http().post(Upload.getInstance().setUpload(map, UploadUrl.renwuliebiaoaction, SharedprefrenceHelper.getInstance(XunChaActivity.this).gettoken(), XunChaActivity.this), new Callback.CommonCallback<String>() {
        @Override
        public void onSuccess(String s) {
            Log.e("巡查任务列表", s);
            JSONObject json = null;
            try {
                json = new JSONObject(s);
                String status = json.getString(UploadUrl.backkey[0]);
                if (status.equals("100")) {
                    JSONArray jrr = json.optJSONArray(UploadUrl.backkey[2]);
                    for(int i=0;i<jrr.length();i++){
                        JSONObject jsonObject2 = null;
                        jsonObject2 = jrr.getJSONObject(i);
                        String key = jsonObject2.optString(UploadUrl.backkey[4]);
                        XunChaInfo info12 = new XunChaInfo(Untils.biaoming().get(key).toString(), "",key);
                        xunChaList.add(info12);
                    }
                    adapter.addDatas(xunChaList);

                }
                ToastShow.setShow(XunChaActivity.this, Untils.shibie(status));
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @Override
        public void onError(Throwable throwable, boolean b) {
                ToastShow.setShow(XunChaActivity.this,"请求失败");
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
    private void setshangchuan(int i) {
        Map map = new HashMap();
        map.put("id", Untils.taskid);
        if(i!=0){
        if (!isPause) {
            map.put("status", "0");
        }else{
            map.put("status", "1");
        }}else{
            map.put("status", "2");
        }
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.xunchaaction, SharedprefrenceHelper.getInstance(XunChaActivity.this).gettoken(), XunChaActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("巡查任务接口", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        intent = new Intent(XunChaActivity.this, XunChaActivity.class);
//                        startActivity(intent);
                    }
                    ToastShow.setShow(XunChaActivity.this, Untils.shibie(status));
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

            }
        });
    }

    @Override
    protected void onPause() {
        super.onPause();
        Log.e("onPause: ", Untils.time);
    }

    // 设置处于暂停状态时，pause按钮的文字显示
    public void pauseText() {
        if (isPause) {
            upload_btn_com.setText("暂停");
            isPause = false;
        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

}
