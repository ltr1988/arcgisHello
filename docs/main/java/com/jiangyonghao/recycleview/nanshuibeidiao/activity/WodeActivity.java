package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.app.Activity;
import android.content.DialogInterface;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.WoDeAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ListViewForScrollView;

import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;

@ContentView(R.layout.activity_wode)
public class WodeActivity extends Activity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.listview_wode)
    private ListViewForScrollView listview_wode;
    @ViewInject(R.id.button_turn_new)
    private Button button_turn_new;
    private WoDeAdapter wodeAdapter = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        Baseactivity.addactvity(this);
        title_com.setText("我的工作");
        wodeAdapter = new WoDeAdapter(this);
        ArrayList<String> list = new ArrayList<>();
        for (int i = 0; i < Untils.myWork.length; i++) {
            list.add(Untils.myWork[i]);
        }
        wodeAdapter.addDatas(list);
        listview_wode.setAdapter(wodeAdapter);

        //设定监听
        button_turn_new.setOnClickListener(this);
        return_com.setOnClickListener(this);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }
    //弹出对话框
    private void showDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("提示");
        View rootView = getLayoutInflater().inflate(R.layout.tishi, null);
        TextView msgTV = (TextView) rootView.findViewById(R.id.tuichu_TV);
        msgTV.setText("确定退出程序？");
        builder.setView(rootView);
        builder.setPositiveButton("是", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
                Baseactivity.removeallactvity();
//                finish();
            }
        });
        builder.setNegativeButton("否", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        AlertDialog dialog = builder.create();
        dialog.show();
    }
    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.button_turn_new:
                showDialog();
                break;
            case R.id.return_com:
                finish();
                break;
        }
    }
}
