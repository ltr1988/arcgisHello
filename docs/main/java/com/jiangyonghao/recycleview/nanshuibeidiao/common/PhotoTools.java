package com.jiangyonghao.recycleview.nanshuibeidiao.common;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.drawable.BitmapDrawable;
import android.view.LayoutInflater;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.PopupWindow;
import android.widget.RelativeLayout;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.AlbumActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.Baseactivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.CaremActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.VideoActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Bimp;

/**
 * Created by Administrator on 2016/8/18 0018.
 */
public class PhotoTools {
    public static PopupWindow pop;
    public static View rootView;
    public static Button btn_take_photo;
    public static Button btn_pick_photo;
    public static Button btn_pick_movie;
    public static Button btn_cancel;
    public static Intent intent;
    public static LinearLayout popl;

    public static void InitPop(final Context context) {
        pop = new PopupWindow(context);
        rootView = LayoutInflater.from(context).inflate(R.layout.common_popupwindows, null);
        popl = (LinearLayout) rootView.findViewById(R.id.ll_popup);
        pop.setWidth(WindowManager.LayoutParams.MATCH_PARENT);
        pop.setHeight(WindowManager.LayoutParams.WRAP_CONTENT);
        pop.setFocusable(true);
        pop.setOutsideTouchable(true);
        pop.setContentView(rootView);
        btn_take_photo = (Button) rootView
                .findViewById(R.id.item_popupwindows_camera);
        btn_take_photo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Untils.panbie="0";
                if(Baseactivity.zhaopianlist.size()<5){
                intent = new Intent(context, CaremActivity.class);
                context.startActivity(intent);
                pop.dismiss();}
            }
        });
        btn_pick_photo = (Button) rootView
                .findViewById(R.id.item_popupwindows_Photo);
        btn_pick_photo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Untils.panbie="1";
                Bimp.tempSelectBitmap.clear();
                if (Baseactivity.tempSelectBitmap.size() > 0) {
                    Bimp.tempSelectBitmap.addAll(Baseactivity.zhaopianlist);
                    Baseactivity.tempSelectBitmap.clear();
                }
                intent = new Intent(context, AlbumActivity.class);
                context.startActivity(intent);
                pop.dismiss();
            }
        });
        btn_pick_movie = (Button) rootView
                .findViewById(R.id.item_popupwindows_video);
        btn_pick_movie.setOnClickListener((View.OnClickListener) context);
        btn_pick_movie.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                intent = new Intent(context, VideoActivity.class);
                context.startActivity(intent);
                pop.dismiss();
            }
        });
        btn_cancel = (Button) rootView
                .findViewById(R.id.item_popupwindows_cancel);
        btn_cancel.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                pop.dismiss();
            }
        });
    }
}
