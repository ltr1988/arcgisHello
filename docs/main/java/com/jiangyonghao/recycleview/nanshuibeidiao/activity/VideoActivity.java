package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;

import com.duanqu.qupai.sdk.android.QupaiManager;
import com.duanqu.qupai.sdk.android.QupaiService;
import com.jiangyonghao.recycleview.nanshuibeidiao.apption.Apption;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.AppConfig;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.RecordResult;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.RequestCode;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.AppGlobalSetting;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;

import java.util.HashMap;

public class VideoActivity extends Baseactivity {
    private Intent intent;
    private HelperDb helperDb;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        helperDb = new HelperDb(this);
//        setContentView(R.layout.activity_video);


//        Button luzhi = (Button) findViewById(R.id.luzhi);
//        luzhi.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
                //引导，只显示一次，这里用SharedPreferences记录
                final AppGlobalSetting sp = new AppGlobalSetting(getApplicationContext());
                Boolean isGuideShow = sp.getBooleanGlobalItem(
                        AppConfig.PREF_VIDEO_EXIST_USER, true);

                /*
                 * 建议上面的initRecord只在application里面调用一次。这里为了能够开发者直观看到改变所以可以调用多次
                 */
                Apption.qupaiService.showRecordPage(VideoActivity.this, RequestCode.RECORDE_SHOW, isGuideShow);

                sp.saveGlobalConfigItem(
                        AppConfig.PREF_VIDEO_EXIST_USER, false);
//            }
//        });
    }

    String videoFile;
    String[] thum;

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (resultCode == RESULT_OK) {
            RecordResult result = new RecordResult(data);
            //得到视频地址，和缩略图地址的数组，返回十张缩略图
            videoFile = result.getPath();
            thum = result.getThumbnail();
            result.getDuration();

//            tv_result.setText("视频路径:" + videoFile + "图片路径:" + thum[0]);
            Log.e("vfv", "onActivityResult: ."+thum[0]);
//            startUpload();
            String uid = Untils.setuuid();
            Untils.copy(thum[0],Untils.SDpath+Untils.fujianpath+"/"+Untils.caremtype+"/video/"+DataTools.getLocaleDayOfMonth()+"/",uid +"2"+".png");
            Untils.copy(videoFile,Untils.SDpath+Untils.fujianpath+"/"+Untils.caremtype+"/video/"+DataTools.getLocaleDayOfMonth()+"/", uid+"2"+".mp4");
           HashMap map = new HashMap();
            Untils.issave = true;
            map.put(Untils.attachmentform[0],uid);
            map.put(Untils.attachmentform[1],Untils.starttime1);
            map.put(Untils.attachmentform[2],Untils.caremtype);
            map.put(Untils.attachmentform[3],Untils.SDpath+Untils.fujianpath+"/"+Untils.caremtype+"/video/"+DataTools.getLocaleDayOfMonth()+"/"+uid +"2"+".mp4");
            map.put(Untils.attachmentform[5],"0");
            map.put(Untils.attachmentform[6],Untils.path+Untils.fujianpath+"/"+Untils.caremtype+"/video/"+DataTools.getLocaleDayOfMonth()+"/"+uid +"2"+".mp4");
            map.put(Untils.attachmentform[7],Untils.shipin);
            map.put(Untils.attachmentform[8],Untils.biaoid);
            helperDb.setinsertAttachmentform(map);
            ImageItem imageItem = new ImageItem();
            imageItem.setPath(Untils.path+Untils.fujianpath+"/"+Untils.caremtype+"/video/"+DataTools.getLocaleDayOfMonth()+"/"+uid +"2"+".mp4");
            imageItem.setImagePath(Untils.SDpath+Untils.fujianpath+"/"+Untils.caremtype+"/video/"+DataTools.getLocaleDayOfMonth()+"/"+uid +"2"+".mp4");
            imageItem.setSelected(true);
            imageItem.setType(Untils.shipin);
            Baseactivity.shipinlist.add(imageItem);
            /**
             * 清除草稿,草稿文件将会删除。所以在这之前我们执行拷贝move操作。
             * 上面的拷贝操作请自行实现，第一版本的copyVideoFile接口不再使用
             */
            QupaiService qupaiService = QupaiManager
                    .getQupaiService(VideoActivity.this);
            qupaiService.deleteDraft(getApplicationContext(), data);

        } else {
            if (resultCode == RESULT_CANCELED) {
                ToastShow.setShow(VideoActivity.this, "录制取消");
            }
        }
        finish();
    }
}
