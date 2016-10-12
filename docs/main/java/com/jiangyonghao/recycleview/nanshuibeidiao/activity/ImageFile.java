package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Context;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.GridView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.FolderAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Bimp;

public class ImageFile extends Baseactivity {
    private FolderAdapter folderAdapter;
    private Button bt_cancel;
    private Context mContext;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_image_file);
        mContext = this;
        bt_cancel = (Button) findViewById(R.id.cancel);
        bt_cancel.setOnClickListener(new CancelListener());
        GridView gridView = (GridView) findViewById(R.id.fileGridView);
        TextView textView = (TextView) findViewById(R.id.headerTitle);
        textView.setText(getResources().getString(R.string.photo));
        folderAdapter = new FolderAdapter(this);
        gridView.setAdapter(folderAdapter);
    }
    private class CancelListener implements View.OnClickListener {// 取消按钮的监听
        public void onClick(View v) {
            //清空选择的图片
//            Bimp.tempSelectBitmap.clear();
            finish();
        }
    }
}
