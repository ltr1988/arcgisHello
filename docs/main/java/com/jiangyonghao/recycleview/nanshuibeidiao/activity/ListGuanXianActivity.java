package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.ListGuanXianAdapter;
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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@ContentView(R.layout.activity_list_guan_xian)
public class ListGuanXianActivity extends Baseactivity {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.listView_list_guanxian)
    private ListView listView;
    @ViewInject(R.id.button_turn_new)
    private Button button_turn_new;
    private ListGuanXianAdapter adapter;
    @ViewInject(R.id.xianshi_chor)
    private LinearLayout xianshi_chor;
    @ViewInject(R.id.chor_com)
    private Chronometer chor_com;
    private Intent intent;
    private String time;
    private HelperDb helper;
    private String code;
    private LoginDilog bar;
    ArrayList<HashMap<String, String>> mapl = new ArrayList<>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        Baseactivity.addactvity(this);
        code = getIntent().getStringExtra("code");
        bar = new LoginDilog(this,"正在请求");
        adapter = new ListGuanXianAdapter(this);

        if (Untils.isWode) {
            initialUI();
            button_turn_new.setVisibility(View.GONE);
            xianshi_chor.setVisibility(View.GONE);
        } else {
            initialUI();
        }
        listView.setAdapter(adapter);
    }

    @Override
    protected void onResume() {
        super.onResume();
        if (getIntent().getStringExtra("type").equals(Untils.daningguanxianType)) {
            if (Untils.isWode) {
                setshangchuan(code);
            } else {
                mapl = helper.getLinepipelist(Untils.daningguanxianType, Untils.starttime, Untils.noupload, Untils.guanxian);
            }
        } else if (getIntent().getStringExtra("type").equals(Untils.dongganquguanxianType)) {
            if (Untils.isWode) {
                setshangchuan(code);
            } else {
                mapl = helper.getLinepipelist(Untils.dongganquguanxianType, Untils.starttime, Untils.noupload, Untils.guanxian);
            }
        } else if (getIntent().getStringExtra("type").equals(Untils.nanganquguanxianType)) {
            if (Untils.isWode) {
                setshangchuan(code);
            } else {
                mapl = helper.getLinepipelist(Untils.nanganquguanxianType, Untils.starttime, Untils.noupload, Untils.nanganlinepipe);
            }
        }
        adapter.addDatas(mapl);
    }


    private void initialUI() {

        helper = new HelperDb(this);
//        ArrayList<HashMap<String, String>> mapList = (ArrayList<HashMap<String, String>>) getIntent().getSerializableExtra("未完成");

        if (getIntent().getStringExtra("type").equals(Untils.daningguanxianType)) {
            if (Untils.isWode) {
                setshangchuan(code);
            } else {
                mapl = helper.getLinepipelist(Untils.daningguanxianType, Untils.starttime, Untils.noupload, Untils.guanxian);
            }
        } else if (getIntent().getStringExtra("type").equals(Untils.dongganquguanxianType)) {
            if (Untils.isWode) {
                setshangchuan(code);
            } else {
                mapl = helper.getLinepipelist(Untils.dongganquguanxianType, Untils.starttime, Untils.noupload, Untils.guanxian);
            }
        } else if (getIntent().getStringExtra("type").equals(Untils.nanganquguanxianType)) {
            if (Untils.isWode) {
                setshangchuan(code);
            } else {
                mapl = helper.getLinepipelist(Untils.nanganquguanxianType, Untils.starttime, Untils.noupload, Untils.nanganlinepipe);
            }
        }
        adapter.addDatas(mapl);
        button_turn_new.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
//                Untils.isdaningUncompleted = false;
                if (getIntent().getStringExtra("type").equals(Untils.nanganquguanxianType)) {
                    Intent intent = new Intent(ListGuanXianActivity.this, SouthGQGuanXianActivity.class);
                    intent.putExtra("time", Untils.time);
                    intent.putExtra("type", title_com.getText().toString());
                    startActivity(intent);
                } else {
                    Intent intent = new Intent(ListGuanXianActivity.this, GuanXianActivity.class);
                    intent.putExtra("time", Untils.time);
                    intent.putExtra("type", title_com.getText().toString());
                    startActivity(intent);
                }

            }
        });
        /**
         * 跟计时器有关的
         */
        title_com.setText(Untils.guanxianleibiao);
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
                Untils.time = chronometer.getText().toString();
                helper.updatestarttime(Untils.starttime, Untils.inspectionmessage[3], chronometer.getText().toString(), Untils.xunchaxinxi);
//                Log.e("onChronometerTick:1 " , chronometer.getText().toString());
            }
        });
    }

    @Event(R.id.return_com)
    private void OnBack(View view) {
        finish();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
    private void setshangchuan(String code) {
        String action=null;
        if (getIntent().getStringExtra("type").equals(Untils.daningguanxianType)) {
            action=UploadUrl.dnqueryline;
        } else if (getIntent().getStringExtra("type").equals(Untils.dongganquguanxianType)) {
       action=UploadUrl.dgqqueryline;
        } else if (getIntent().getStringExtra("type").equals(Untils.nanganquguanxianType)) {
        action=UploadUrl.ngqqueryline;
        }
        bar.show();
        Map map = new HashMap();
        map.put("code", code);
        map.put("taskid", Untils.taskid);
        if (Untils.isWode){
            map.put("ishistory","Y");
        }
        x.http().post(Upload.getInstance().setUpload(map, action, SharedprefrenceHelper.getInstance(ListGuanXianActivity.this).gettoken(), ListGuanXianActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("井号列表接口", s);
                JSONObject json = null;
                mapl.clear();
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        String status = json.getString(UploadUrl.backkey[0]);
                        JSONArray jrr = json.optJSONArray(UploadUrl.backkey[2]);
                        for (int i = 0; i < jrr.length(); i++) {
                            JSONArray jsonObject2 = null;
                            jsonObject2 = (JSONArray) jrr.opt(i);
                            HashMap<String, String> hashMap = new HashMap<>();
                            hashMap.put("type",getIntent().getStringExtra("type"));
                            for (int j = 0; j < jsonObject2.length(); j++) {
                                String id = ((JSONObject)jsonObject2.opt(j)).optString("id").toString().toLowerCase();
                                String value = ((JSONObject)jsonObject2.opt(j)).optString("value").toString();
                                hashMap.put(id,value);
                            }
                                Log.e("dong分水ch", hashMap.toString());
                            mapl.add(hashMap);
                        }
                        adapter.addDatas(mapl);
                    }
                    ToastShow.setShow(ListGuanXianActivity.this, Untils.shibie(status));
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
}
