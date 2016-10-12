package com.jiangyonghao.recycleview.nanshuibeidiao.view;

import android.app.*;
import android.content.Context;
import android.os.Bundle;
import android.view.Window;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;

/**
 * Created by jiangyonghao on 2016/8/28.
 */
public class LoginDilog extends android.app.Dialog{
    private LoginTextView qingiqu;
    private String s=null;
    private Context context;
    public LoginDilog(Context context) {
        super(context);
        this.context=context;
    }
    public LoginDilog(Context context,String s) {
        super(context);
        this.context=context;
        this.s=s;
    }
    public LoginDilog(Context context, int themeResId) {
        super(context, themeResId);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.logindilog);
        qingiqu = (LoginTextView) findViewById(R.id.qingqiu);
        if (s!=null) {
            qingiqu.setText(s);
        }
    }
}
