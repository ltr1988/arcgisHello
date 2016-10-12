package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.util.Log;
import android.view.KeyEvent;
import android.view.LayoutInflater;
import android.view.MotionEvent;
import android.view.SurfaceView;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.MediaController;
import android.widget.VideoView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.imagedealtool.FinalBitmap;

import java.io.File;

import uk.co.senab.photoview.PhotoView;

public class ShowPhotoActivity extends Baseactivity implements View.OnClickListener {
    private int position;
    private Button op_pic_delete, op_pic_ret;
    private LinearLayout op_picBt_ll;

    private ImageButton operate_pic_backBt;
    private HelperDb sqlService = new HelperDb(this);
    private ViewPager mViewPager;
    private SamplePagerAdapter samplePagerAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_show_photo);
        Baseactivity.addactvity(this);
//        Baseactivity.tempSelectBitmap.clear();
//        Baseactivity.tempSelectBitmap.addAll(Baseactivity.zhaopianlist);
//        Baseactivity.tempSelectBitmap.addAll(Baseactivity.shipinlist);
        Baseactivity.tempSelectBitmap.clear();
        Baseactivity.tempSelectBitmap.addAll(sqlService.getAttachmentformlist(Untils.caremtype, Untils.starttime1));
        op_picBt_ll = (LinearLayout) findViewById(R.id.op_picBt_ll);
        op_pic_delete = (Button) findViewById(R.id.op_pic_delete);
        op_pic_ret = (Button) findViewById(R.id.op_pic_ret);
        operate_pic_backBt = (ImageButton) findViewById(R.id.operate_pic_backBt);

        position = getIntent().getIntExtra("position", -1);
        mViewPager = (ViewPager) findViewById(R.id.op_viewpager);
        samplePagerAdapter = new SamplePagerAdapter();
        // setContentView(mViewPager);
        mViewPager.setAdapter(samplePagerAdapter);

        // getDataSource();
        // viewpager.setAdapter(pagerAdapter);
        mViewPager.setCurrentItem(position, false);
        setOnclikListener();
    }

    /**
     * 功能说明：删除按钮
     */
    public void delete_pic() {
        // MonitorActivity.pics.remove(mViewPager.getCurrentItem());
        // Log.e("OperatePicActivity", "删除的是第几个" + mViewPager.getCurrentItem());
        if(Baseactivity.tempSelectBitmap.size()>0){
        this.position = mViewPager.getCurrentItem();
        deleteFile(Baseactivity.tempSelectBitmap.get(position).getPath(),
                new File(Environment.getExternalStorageDirectory().toString() + Baseactivity.tempSelectBitmap.get(position).getPath()));
        Baseactivity.tempSelectBitmap.remove(position);
            if(Baseactivity.tempSelectBitmap.size()==0){finish();}
        samplePagerAdapter = new SamplePagerAdapter();
        mViewPager.setAdapter(samplePagerAdapter);}else{finish();}

    }

    /**
     * 功能说明：删除指定路径的sdcard存储的图片
     */
    public void deleteFile(String path, File file) {
        if (file.exists()) {
            if (file.isFile()) {
                file.delete();
                sqlService.deletefujianxiangdui(Untils.starttime1, path);
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

    class SamplePagerAdapter extends PagerAdapter {

        @Override
        public int getCount() {
            return Baseactivity.tempSelectBitmap.size();
        }

        @Override
        public View instantiateItem(ViewGroup container, int position) {
            LinearLayout linearLayout = (LinearLayout) LayoutInflater.from(ShowPhotoActivity.this).inflate(R.layout.itemviewpager,null);
            PhotoView photoView = (PhotoView) linearLayout.findViewById(R.id.photo);
            final VideoView surfaceView = (VideoView) linearLayout.findViewById(R.id.video111);
            FinalBitmap bitmapUtils = new FinalBitmap(ShowPhotoActivity.this);
            // photoView.setImageURI(uri);
            // Log.e("dd",
            // PhotoAcitivty.images_path +
            // DailyWorkFragment.pic_list.get(position).get("xiangdui")
            // + DailyWorkFragment.pic_list.get(position).get("path")
            // + DailyWorkFragment.pic_list.get(position).get("name"));
            Log.e("dd",Baseactivity.tempSelectBitmap.get(position).getType()+Baseactivity.tempSelectBitmap.get(position).getPath());
            if (Baseactivity.tempSelectBitmap.get(position).getType().equals(Untils.zhaopian)) {
                surfaceView.setVisibility(View.GONE);
                photoView.setVisibility(View.VISIBLE);
                bitmapUtils.display(photoView,
                        Environment.getExternalStorageDirectory().toString() + Baseactivity.tempSelectBitmap.get(position).getPath());
            } else {
                surfaceView.setVisibility(View.VISIBLE);
                photoView.setVisibility(View.GONE);
                // 播放相应的视频
//                surfaceView.setMediaController(new MediaController(container.getContext()));
//                surfaceView.setVideoURI(Uri.parse(Environment.getExternalStorageDirectory().toString() + Baseactivity.tempSelectBitmap.get(position).getPath()));
//                surfaceView.start();
//                surfaceView.setMediaController(new MediaController(ShowPhotoActivity.this));
                surfaceView.setVideoPath(Environment.getExternalStorageDirectory().toString() + Baseactivity.tempSelectBitmap.get(position).getPath());
                surfaceView.start();
                surfaceView.setOnTouchListener(new View.OnTouchListener() {
                    @Override
                    public boolean onTouch(View view, MotionEvent motionEvent) {
                        if(surfaceView.isPlaying()){
                            surfaceView.pause();
                        }else{
                            surfaceView.start();
                        }
                        return false;
                    }
                });
            }

            // Now just add PhotoView to ViewPager and return it
            container.addView(linearLayout, LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.MATCH_PARENT);

            return linearLayout;
        }

        @Override
        public void destroyItem(ViewGroup container, int position, Object object) {
            container.removeView((View) object);
        }

        @Override
        public boolean isViewFromObject(View view, Object object) {
            return view == object;
        }

    }

    /**
     * 功能说明：设置监听
     */
    private void setOnclikListener() {
        // TODO Auto-generated method stub

        op_pic_delete.setOnClickListener(this);
        op_pic_ret.setOnClickListener(this);
        operate_pic_backBt.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        // TODO Auto-generated method stub
        switch (v.getId()) {
            case R.id.op_pic_ret:
                Baseactivity.tempSelectBitmap.clear();
                finish();
                break;
            case R.id.op_pic_delete:
                delete_pic();
                break;
            case R.id.operate_pic_backBt:
                Baseactivity.tempSelectBitmap.clear();
                finish();
                break;

            default:
                break;
        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode==KeyEvent.KEYCODE_BACK){
            Baseactivity.tempSelectBitmap.clear();
        }
        return super.onKeyDown(keyCode, event);
    }
}
