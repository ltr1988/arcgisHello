package com.jiangyonghao.recycleview.nanshuibeidiao.view;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.os.Environment;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.view.Window;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.Baseactivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.GridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;

import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.io.File;

public class DeleteShow extends Dialog {
    private Context context;
    private String message;
    @ViewInject(R.id.tishi_message)
    private TextView messageview;
    DisplayMetrics dm;
    private String path;
    private int postion;
    private HelperDb helperDb;
    private GridViewAdapter adapter;
    private String type;

    public DeleteShow(Context context, String message, String path, int postion, GridViewAdapter adapter, String type) {
        super(context);
        // TODO Auto-generated constructor stub
        this.context = context;
        this.message = message;
        this.path = path;
        this.postion = postion;
        this.adapter = adapter;
        this.type = type;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        // TODO Auto-generated method stub
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        helperDb = new HelperDb(context);
        View view = LayoutInflater.from(context).inflate(R.layout.tishi2, null);
        x.view().inject(this, view);
        dm = new DisplayMetrics();
        // 取得屏幕属性
        ((Activity) context).getWindowManager().getDefaultDisplay().getMetrics(dm);
        // 屏幕的宽度
        int screenWidth = dm.widthPixels;
        setContentView(view, new LayoutParams(screenWidth - 200, LayoutParams.WRAP_CONTENT));
        // view.setLayoutParams(new LinearLayout.LayoutParams(screenWidth-10,
        // screenWidth-10));
        messageview.setText(message);
    }

    @Event(R.id.tishi_fou)
    private void setFou(View view) {
        dismiss();
    }

    @Event(R.id.tishi_shi)
    private void setShi(View view) {
        helperDb.deletefujianxiangdui(Untils.starttime1, path);
        deleteFile(new File(Environment.getExternalStorageDirectory().getAbsolutePath()+path));
        if (path.endsWith(".mp4")){
            deleteFile(new File(Environment.getExternalStorageDirectory().getAbsolutePath()+path.split(".mp4")[0]+".png"));
        }
        if (type.equals(Untils.zhaopian)) {
            Baseactivity.zhaopianlist.clear();
        }else if(type.equals(Untils.shipin)){
            Baseactivity.shipinlist.clear();
        }

        Baseactivity.tempSelectBitmap.remove(postion);
        adapter.setImage(Baseactivity.tempSelectBitmap, adapter);
        dismiss();
    }
    /**
     * 功能说明：删除指定路径的sdcard存储的图片
     */
    public void deleteFile(File file) {
        if (file.exists()) {
            if (file.isFile()) {
                file.delete();
                // Log.e("OperatePicActivity", "deleFile删除的是" + file.getName());
            }
            // else if (file.isDirectory()) {
            // File[] files = file.listFiles();
            // for (int i = 0; i < files.length; i++) {
            // this.deleteFile(files[i]);
            // }
            // // Log.e("删除文件", "删除的是文件夹中所有的");
            // }
            // file.delete();
        } else {
            // Toast.makeText(this, "文件不存在！！！", 0).show();
        }

    }
}
