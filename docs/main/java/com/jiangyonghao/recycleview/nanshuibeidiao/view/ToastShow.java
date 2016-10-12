package com.jiangyonghao.recycleview.nanshuibeidiao.view;

import android.content.Context;
import android.support.design.widget.Snackbar;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;

/**
 * Created by jiangyonghao on 2016/8/16.
 */
public class ToastShow {
    private static Toast toast;

    public static void setShow(Context context, String str){
        toast = new Toast(context);
        View view = LayoutInflater.from(context).inflate(R.layout.toastshow,null);
        TextView text = (TextView) view.findViewById(R.id.show);
        text.setText(str);
        toast.setView(view);
        toast.show();
    }
}
