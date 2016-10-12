package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.content.res.Configuration;
import android.net.Uri;
import android.provider.MediaStore;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Bimp;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;

import java.io.File;
import java.util.HashMap;

public class CaremActivity extends Baseactivity {
    private String picName = null;
    private String create;
    private Intent intent;
    private String urlpath;
    private HelperDb helperDb;
    public static final int PHOTOHRAPH = 1;// 拍照
    private String xiangdui;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_carem);
        helperDb = new HelperDb(this);
        takePhoto();
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    private void takePhoto() {
        picName = DataTools.getLocaleTime1() + ".png";
        create = DataTools.getLocaleTime();

        if (!new File(Untils.SDpath + Untils.fujianpath + "/" + Untils.caremtype + "/image/" + DataTools.getLocaleDayOfMonth() + "/").exists()) {
            new File(Untils.SDpath + Untils.fujianpath + "/" + Untils.caremtype + "/image/" + DataTools.getLocaleDayOfMonth() + "/").mkdirs();
        }
        Uri uri = Uri.fromFile(new File(Untils.SDpath + Untils.fujianpath + "/" + Untils.caremtype + "/image/" + DataTools.getLocaleDayOfMonth() + "/",
                picName));
        urlpath = Untils.SDpath + Untils.fujianpath + "/" + Untils.caremtype + "/image/" + DataTools.getLocaleDayOfMonth() + "/" + picName;
        xiangdui = Untils.path + Untils.fujianpath + "/" + Untils.caremtype + "/image/" + DataTools.getLocaleDayOfMonth() + "/" + picName;
        // Log.e("PhotoActivity", uri.toString());
        Intent intent = new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
        intent.putExtra(MediaStore.EXTRA_OUTPUT, uri);
        startActivityForResult(intent, PHOTOHRAPH);
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        // 拍照
        Log.e("sss", "onActivityResult: "+requestCode);
        if (requestCode == PHOTOHRAPH) {
            // 设置文件保存路径这里放在跟目录下
//            create = DataTools.getLocaleTime();
            // Log.e("PhotoActivity", "拍照");
            // 循环拍照
            // takePhoto();
            Log.e("sss", "onActivityResult: "+new File(urlpath).exists()+urlpath);
            if (new File(urlpath).exists()) {
                ImageItem imageItem = new ImageItem();
                imageItem.setPath(xiangdui);
                imageItem.setImagePath(urlpath);
                imageItem.setSelected(true);
                imageItem.setType(Untils.zhaopian);
                Untils.issave = true;
                Baseactivity.tempSelectBitmap.add(imageItem);
//            ShijiansbActivity.bitmaplist.addAll(Bimp.tempSelectBitmap);
                HashMap map = new HashMap();
                map.put(Untils.attachmentform[0], Untils.setuuid());
                map.put(Untils.attachmentform[1], Untils.starttime1);
                map.put(Untils.attachmentform[2], Untils.caremtype);
                map.put(Untils.attachmentform[3], urlpath);
                map.put(Untils.attachmentform[5], "0");
                map.put(Untils.attachmentform[6], xiangdui);
                map.put(Untils.attachmentform[7], Untils.zhaopian);
                map.put(Untils.attachmentform[8],Untils.biaoid);
                Log.e("sss", "onActivityResult: "+map.toString() );
                helperDb.setinsertAttachmentform(map);
            }
            finish();
        }
    }
}
