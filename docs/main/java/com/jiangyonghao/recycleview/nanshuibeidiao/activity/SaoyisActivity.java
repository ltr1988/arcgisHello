package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.os.Bundle;
import android.view.KeyEvent;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;

public class SaoyisActivity extends Baseactivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_saoyis);
        Baseactivity.addactvity(this);
    }
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if(keyCode==KeyEvent.KEYCODE_BACK){
            return  true;
        }
        return super.onKeyDown(keyCode, event);
    }
}
