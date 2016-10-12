package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.widget.LinearLayout;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.StringUntils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;

import java.io.File;

public class AnimationActivity extends Baseactivity {
    private LinearLayout view;
    private LayoutInflater inflater;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_animation);
//        透明状态栏
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT) {
//            Window window = getWindow();
//            // Translucent status bar
//            window.setFlags(
//                    WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS,
//                    WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS);
//        }
//        view = (LinearLayout) inflater.from(this).inflate(R.layout.activity_animation,null);
//        LinearLayout.LayoutParams lay = new LinearLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.MATCH_PARENT);
//        lay.topMargin = DataTools.getStatusHeight(this)*100;
//        setContentView(view,lay);
        new Handler().postDelayed(new Runnable() {
            public void run() {
                Intent mainIntent = new Intent(AnimationActivity.this,
                        LoginActivity.class);
                AnimationActivity.this.startActivity(mainIntent);
                AnimationActivity.this.finish();
            }

        }, 2000);
        File path = new File(Untils.SDpath+Untils.fujianpath);// 创建目录
        if (!path.exists()) {// 目 录存在返回false
            path.mkdirs();// 创建一个目录
        }
//        Log.e("dd", "onCreate: "+UploadUrl.version );
    }
}
