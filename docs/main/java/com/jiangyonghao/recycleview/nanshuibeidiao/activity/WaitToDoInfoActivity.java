package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.WaitAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ShiJianWSB;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.WaitInfo;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ListViewForScrollView;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
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
import java.util.Map;

@ContentView(R.layout.activity_wait_to_do_info)
public class WaitToDoInfoActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.listview_waittodoinfo)
    private ListViewForScrollView listview_wait;
    private WaitAdapter waitAdapter;
    private LoginDilog bar;
    ArrayList<WaitInfo> infoList;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        Baseactivity.addactvity(this);
        bar = new LoginDilog(WaitToDoInfoActivity.this, "正在请求");
        infoList = new ArrayList<>();
        title_com.setText("待办应急任务");
        initAdapter();
        setshangchuan();


//        for (int i = 0; i < 5; i++) {
//            infoList.add(new WaitInfo("岳各庄调压塔水管泄露", "2016-01-02 8:39:21", "丰台区岳各庄桥下", "团城湖管理处-水正科发现", "应急调度", "二级"));
//        }
//
        //设定监听
        return_com.setOnClickListener(this);
    }

    private void initAdapter() {
        waitAdapter = new WaitAdapter(this);
        listview_wait.setAdapter(waitAdapter);

    }

    private void setshangchuan() {
        bar.show();
        Map map = new HashMap();
        HashMap map1 = new HashMap();
//        map.put("taskid", Untils.taskid);
//        map.put("state", "1");
//        map.put("source", UploadUrl.Android);
        map.put("incidentSource", "YDSB");

        map.put("pageNo", "1");
        map.put("pageSize", "10");
        map1.put("userName", SharedprefrenceHelper.getInstance(WaitToDoInfoActivity.this).getUsername());
        Log.e("1212", "name---" + SharedprefrenceHelper.getInstance(WaitToDoInfoActivity.this).getUsername());
// map.put("status", "");//所有状态
        map1.put("userScope", "3");//分发人员范围内的事件
        if (Untils.isWode) {
            map.put("ishistory", "Y");
        }
        map.put("data", map1);
        x.http().post(Upload.getInstance().setwodetufa(map, UploadUrl.tufashangbao, SharedprefrenceHelper.getInstance(WaitToDoInfoActivity.this).gettoken(), WaitToDoInfoActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("1212", "WaitTodo---" + s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
                        JSONObject object = json.getJSONObject(UploadUrl.backkey[2]);
                        String total = object.getString(UploadUrl.backkey[7]);
                        String pageNo = object.getString(UploadUrl.backkey[8]);
                        String pageSize = object.getString(UploadUrl.backkey[9]);
                        JSONArray rows = object.optJSONArray(UploadUrl.backkey[6]);
                        for (int i = 0; i < rows.length(); i++) {
                            JSONObject jsonObject2 = null;
                            jsonObject2 = rows.getJSONObject(i);
                            WaitInfo entity = null;
                            String id = jsonObject2.optString(UploadUrl.backkey[20]);
                            Log.e("1111", "id---" + id);
                            String title = jsonObject2.optString(UploadUrl.backkey[10]);
                            Log.e("1111", "title---" + title);
                            String occurTime = jsonObject2.optString(UploadUrl.backkey[13]);
                            String departName = jsonObject2.optString(UploadUrl.backkey[17]);
                            String creatorName = jsonObject2.optString(UploadUrl.backkey[18]);
                            String occurLocation = jsonObject2.optString(UploadUrl.backkey[19]);
                            String category=jsonObject2.optString(UploadUrl.backkey[21]);
                            String responseLevel=jsonObject2.optString(UploadUrl.backkey[22]);
                            entity = new  WaitInfo(id,title,occurTime,occurLocation,creatorName,departName,category,responseLevel);
                            infoList.add(entity);
                        }
                        waitAdapter.setDatas(infoList);
                    }
                    ToastShow.setShow(WaitToDoInfoActivity.this, Untils.shibie(status));
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


    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.return_com:
                finish();
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
}
