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
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.imagedealtool.Utils;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.HashMap;
import java.util.Map;

@ContentView(R.layout.activity_xunchatb)
public class StartXunchatbActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.xuncharenxingming)
    private EditText xuncharenname;
    @ViewInject(R.id.xunchaguanlixingming)
    private EditText xunchaguanliname;
    @ViewInject(R.id.tianqi)
    private TextView tianqi;
    @ViewInject(R.id.shijianTV)
    private TextView shijian;
    @ViewInject(R.id.likai)
    private LinearLayout likai;
    @ViewInject(R.id.xinyiqi)
    private LinearLayout xinyiqi;
    private HelperDb helperDb;
    private HashMap<String, String> map;
    private String id;
    private Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            String weather = (String) msg.obj;
            tianqi.setText(weather);
            map.put(Untils.inspectionmessage[6], weather);
        }
    };
    String starttime;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        map = new HashMap<>();
        Untils.initContent();
        Baseactivity.addactvity(this);
        initialUI();
        Untils.Finish(return_com, this);
        inupdate();
    }

    private void inupdate() {
        helperDb = new HelperDb(this);
        id = Untils.setuuid();
        map.put(Untils.inspectionmessage[0], id);
        starttime = DataTools.getLocaleTime();
        map.put(Untils.inspectionmessage[1], starttime);
        map.put(Untils.inspectionmessage[7], "0");
        setTextchange(xuncharenname, Untils.inspectionmessage[4]);
        setTextchange(xunchaguanliname, Untils.inspectionmessage[5]);
        setTextViewchange(shijian, Untils.inspectionmessage[8]);
        map.put(Untils.inspectionmessage[3], "00:00");
        map.put(Untils.inspectionmessage[8], shijian.getText().toString() == null ? "" : shijian.getText().toString());
        map.put(Untils.inspectionmessage[9], SharedprefrenceHelper.getInstance(this).getUsername());
    }

    private void setTextchange(EditText ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                map.put(key, charSequence.toString());
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }
    private void setTextViewchange(TextView ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence charSequence, int i, int i1, int i2) {

            }

            @Override
            public void onTextChanged(CharSequence charSequence, int i, int i1, int i2) {
                map.put(key, charSequence.toString());
            }

            @Override
            public void afterTextChanged(Editable editable) {

            }
        });
    }

    private void initialUI() {
        x.view().inject(this);
        title_com.setText(getResources().getText(R.string.xinxitianbao));
        shijian.setText(DataTools.tian());
        shijian.setOnClickListener(this);
        String ID = Untils.setuuid();
        Untils.taskid = ID;
        likai.setOnClickListener(this);
        return_com.setOnClickListener(this);
        xinyiqi.setOnClickListener(this);
        Untils.getTianqi(handler, this);
    }

    private boolean setisFull(EditText edit) {
        if (edit.getText().toString().equals("")) {
            edit.setError("不准为空!");
            return false;
        } else
            return true;
    }

    @Override
    public void onClick(View v) {

        switch (v.getId()) {
            case R.id.likai:
            case R.id.return_com:
                finish();
                break;
            case R.id.xinyiqi:
                if (setisFull(xuncharenname) && setisFull(xunchaguanliname)) {
                    helperDb.setinsertInspectionmessage(map);
                    finish();
//                    Untils.isUncompleted = false;
                    setshangchuan();

                }
                break;
            case R.id.shijianTV:
                Untils.setShiJian(StartXunchatbActivity.this, 1, shijian);
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

    private void setshangchuan() {
        Map map = new HashMap();
        map.putAll(helperDb.getInspectionmessage(starttime));
        map.put("status", "1");
        map.put("source", UploadUrl.Android);
        map.put("userName", SharedprefrenceHelper.getInstance(StartXunchatbActivity.this).getUsername());
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.jibentianbao, SharedprefrenceHelper.getInstance(StartXunchatbActivity.this).gettoken(), StartXunchatbActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("巡查任务接口", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
                        helperDb.update(Untils.taskid, Untils.inspectionmessage[7], "1", Untils.xunchaxinxi);
                        Intent intent = new Intent(StartXunchatbActivity.this, XunChaActivity.class);
                        Untils.starttime = starttime;
                        intent.putExtra("starttime", starttime);
                        Untils.taskid = id;
                        startActivity(intent);
                        finish();
                    }

                    ToastShow.setShow(StartXunchatbActivity.this, Untils.shibie(status));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onError(Throwable throwable, boolean b) {
                ToastShow.setShow(StartXunchatbActivity.this, "请求失败");
                Intent intent = new Intent(StartXunchatbActivity.this, XunChaActivity.class);
                Untils.starttime = starttime;
                Untils.taskid = id;
                intent.putExtra("starttime", starttime);
                startActivity(intent);
            }

            @Override
            public void onCancelled(CancelledException e) {

            }

            @Override
            public void onFinished() {

            }
        });
    }
}
