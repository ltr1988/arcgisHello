package com.jiangyonghao.recycleview.nanshuibeidiao.apption;

import android.app.Activity;
import android.app.Application;
import android.hardware.Camera;
import android.support.multidex.MultiDex;
import android.support.multidex.MultiDexApplication;


import com.duanqu.qupai.engine.session.MovieExportOptions;
import com.duanqu.qupai.engine.session.ProjectOptions;
import com.duanqu.qupai.engine.session.ThumbnailExportOptions;
import com.duanqu.qupai.engine.session.UISettings;
import com.duanqu.qupai.engine.session.VideoSessionCreateInfo;
import com.duanqu.qupai.sdk.android.QupaiManager;
import com.duanqu.qupai.sdk.android.QupaiService;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Contant;

import org.xutils.x;

public class Apption extends MultiDexApplication {
    public static Activity activity;
    public static QupaiService qupaiService;

    @Override
    public void onCreate() {
        // TODO Auto-generated method stub
        super.onCreate();
        x.Ext.init(this);
        x.Ext.setDebug(true);
//		MyCrashHandler handler = MyCrashHandler.instance();
//		handler.init();
        intxiaoshipin();
        MultiDex.install(this);
    }

    private void intxiaoshipin() {
        qupaiService = QupaiManager
                .getQupaiService(this);
        UISettings _UISettings = new UISettings() {

                    @Override
                    public boolean hasEditor() {
                        return false;
                    }

                    @Override
                    public boolean hasImporter() {
                        return true;
                    }

                    @Override
                    public boolean hasGuide() {
                        return false;
                    }

                    @Override
                    public boolean hasSkinBeautifer() {
                        return false;
                    }
                };

        MovieExportOptions movie_options = new MovieExportOptions.Builder()
                .setVideoBitrate(Contant.DEFAULT_BITRATE)
                .configureMuxer("movflags", "+faststart")
                .build();

        ProjectOptions projectOptions = new ProjectOptions.Builder()
                .setVideoSize(640, 640)
                .setVideoFrameRate(30)
                .setDurationRange(Contant.DEFAULT_MIN_DURATION_LIMIT, Contant.DEFAULT_DURATION_LIMIT)
                .get();

        ThumbnailExportOptions thumbnailExportOptions = new ThumbnailExportOptions.Builder()
                .setCount(1).get();

        VideoSessionCreateInfo info = new VideoSessionCreateInfo.Builder()
                .setWaterMarkPath(Contant.WATER_MARK_PATH)
                .setWaterMarkPosition(1)
                .setCameraFacing(Camera.CameraInfo.CAMERA_FACING_BACK)
                .setBeautyProgress(80)
                .setBeautySkinOn(false)
                .setMovieExportOptions(movie_options)
                .setThumbnailExportOptions(thumbnailExportOptions)
                .build();

        qupaiService.initRecord(info, projectOptions, _UISettings);
    }

    public static Activity getActivity() {
//		LogUtil.e("ddd"+activity.toString());
        return activity;
    }


    public void setActivity(Activity activity) {
        this.activity = activity;
    }
}
