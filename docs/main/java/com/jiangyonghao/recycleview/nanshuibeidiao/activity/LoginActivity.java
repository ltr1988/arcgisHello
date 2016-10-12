package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.EditText;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.MD5;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.StringUntils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;

import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.HashMap;

@ContentView(R.layout.activity_login)
public class LoginActivity extends Activity {
    @ViewInject(R.id.username)
    private EditText username;
    @ViewInject(R.id.userpassword)
    private EditText pass;
    LoginDilog dilog;
    private boolean ischange = false;
    private HelperDb helper;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_login);
        x.view().inject(this);
        helper = new HelperDb(this);
        inint();
         dilog= new LoginDilog(this);

    }

    private void inint() {

        if (!SharedprefrenceHelper.getInstance(LoginActivity.this).getUsername().equals("") && !SharedprefrenceHelper.getInstance(LoginActivity.this).getUserpass().equals("")) {
            username.setText(SharedprefrenceHelper.getInstance(LoginActivity.this).getUsername());
            pass.setText(SharedprefrenceHelper.getInstance(LoginActivity.this).getUserpass());
        }
        pass.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                ischange=true;
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    @Event(R.id.login)
    private void OnLoginClick(View view) {
        if (StringUntils.isOnline(LoginActivity.this)) {
            dilog.show();
            setlogin();
        } else {
            ToastShow.setShow(LoginActivity.this, "请先连接网络");
        }

    }

    @Event(R.id.wangji)
    private void OnWangjiClick(View view) {
        ToastShow.setShow(LoginActivity.this, "功能未开发");
    }

    @Event(R.id.zhuce)
    private void OnZhuCeClick(View view) {
        ToastShow.setShow(LoginActivity.this, "功能未开发");
    }

    private void setlogin() {
//        Log.e("dd", pass.getText().toString()+"setlogin: "+ MD5.md5(pass.getText().toString()) );
//        "userName", "userPwd", "model", "serialnumber", "devicename", "systemnumber"
        if (ischange){
            pass.setText(MD5.md5(pass.getText().toString()));
        }
        HashMap map = new HashMap();
        map.put(Untils.loginkey[0], username.getText().toString());
        map.put(Untils.loginkey[1], pass.getText().toString());
        map.put(Untils.loginkey[2], StringUntils.getPhototype());
        map.put(Untils.loginkey[3], StringUntils.getDeviceIMEI(LoginActivity.this));
        map.put(Untils.loginkey[4], StringUntils.getPhotobrand());
        map.put(Untils.loginkey[5], StringUntils.getSystemnumber());
        x.http().post(Upload.getInstance().setLogin(map, LoginActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("dd", "onError: "+s );
//                Gson gson = new Gson();
//                ArrayList<HashMap<String,String>> maplist = gson.fromJson(s.toString(),new TypeToken<HashMap<String,String>>(){}.getType());
                try {
                    JSONObject json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if(status.equals("100")){
                        JSONObject jrr = new JSONObject(json.getString(UploadUrl.backkey[2]));
                        SharedprefrenceHelper.getInstance(LoginActivity.this).settoken(jrr.getString(UploadUrl.backkey[3]));
                        if(!SharedprefrenceHelper.getInstance(LoginActivity.this).getUsername().equals(username.getText().toString())){
                            Untils.taskid = helper.getInspectionmessage1().get(Untils.inspectionmessage[0]);
                            helper.update(Untils.taskid,Untils.inspectionmessage[7],"1",Untils.xunchaxinxi);
                        }
                        SharedprefrenceHelper.getInstance(LoginActivity.this).setUsername(username.getText().toString());

                        SharedprefrenceHelper.getInstance(LoginActivity.this).setUserpass(pass.getText().toString());
                        Intent intent = new Intent(LoginActivity.this, MainActivity.class);
                        startActivity(intent);
                        finish();
//                    }else{
                    }
                    ToastShow.setShow(LoginActivity.this, json.getString(UploadUrl.backkey[1]).toString());
                } catch (Exception e) {
                    e.printStackTrace();
                }
                dilog.dismiss();
            }

            @Override
            public void onError(Throwable throwable, boolean b) {
//                SharedprefrenceHelper.getInstance(LoginActivity.this).setUsername(username.getText().toString());
//                SharedprefrenceHelper.getInstance(LoginActivity.this).setUserpass(pass.getText().toString());
//                Intent intent = new Intent(LoginActivity.this, MainActivity.class);
//                startActivity(intent);
//                finish();
//                Log.e("dd", "onError: "+throwable.getMessage() );
                dilog.dismiss();
                    if(b){
                        ToastShow.setShow(LoginActivity.this, "网络异常");
                    }
            }

            @Override
            public void onCancelled(CancelledException e) {

            }

            @Override
            public void onFinished() {
                ischange=false;
            }
        });
    }
}
