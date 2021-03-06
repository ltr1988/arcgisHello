package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Context;
import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Environment;
import android.support.v4.view.PagerAdapter;
import android.support.v4.view.ViewPager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Bimp;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.PublicWay;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import uk.co.senab.photoview.PhotoView;

public class GalleryActivity extends Baseactivity {
    private Intent intent;
    // 返回按钮
    private Button back_bt;
    // 发送按钮
    private Button send_bt;
    //删除按钮
    private Button del_bt;
    //顶部显示预览图片位置的textview
    private TextView positionTextView;
    //获取前一个activity传过来的position
    private int position;
    //当前的位置
    private int location = 0;

    private ArrayList<View> listViews = null;
    private ViewPager pager;
    private MyPageAdapter adapter;

    public List<Bitmap> bmp = new ArrayList<Bitmap>();
    public List<String> drr = new ArrayList<String>();
    public List<String> del = new ArrayList<String>();

    private Context mContext;

    RelativeLayout photo_relativeLayout;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_gallery);
        mContext = this;
        back_bt = (Button) findViewById(R.id.gallery_back);
        send_bt = (Button) findViewById(R.id.send_button);
        del_bt = (Button)findViewById(R.id.gallery_del);
        back_bt.setOnClickListener(new BackListener());
        send_bt.setOnClickListener(new GallerySendListener());
        del_bt.setOnClickListener(new DelListener());
        intent = getIntent();
        Bundle bundle = intent.getExtras();
        position = Integer.parseInt(intent.getStringExtra("position"));
        isShowOkBt();
        // 为发送按钮设置文字
        pager = (ViewPager) findViewById(R.id.gallery01);
        pager.setOnPageChangeListener(pageChangeListener);
        for (int i = 0; i < Bimp.tempSelectBitmap.size(); i++) {
            initListViews( Bimp.tempSelectBitmap.get(i).getBitmap() );
        }

        adapter = new MyPageAdapter(listViews);
        pager.setAdapter(adapter);
        pager.setPageMargin((int)getResources().getDimensionPixelOffset(R.dimen.ui_10_dip));
        int id = intent.getIntExtra("ID", 0);
        pager.setCurrentItem(id);
    }

    private ViewPager.OnPageChangeListener pageChangeListener = new ViewPager.OnPageChangeListener() {

        public void onPageSelected(int arg0) {
            location = arg0;
        }

        public void onPageScrolled(int arg0, float arg1, int arg2) {

        }

        public void onPageScrollStateChanged(int arg0) {

        }
    };

    private void initListViews(Bitmap bm) {
        if (listViews == null)
            listViews = new ArrayList<View>();
        PhotoView img = new PhotoView(this);
        img.setBackgroundColor(0xff000000);
        img.setImageBitmap(bm);
        img.setLayoutParams(new LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT,LinearLayout.LayoutParams.MATCH_PARENT));
        listViews.add(img);
    }

    // 返回按钮添加的监听器
    private class BackListener implements View.OnClickListener {

        public void onClick(View v) {
            intent.setClass(GalleryActivity.this, ImageFile.class);
            startActivity(intent);
        }
    }

    // 删除按钮添加的监听器
    private class DelListener implements View.OnClickListener {

        public void onClick(View v) {
            if (listViews.size() == 1) {
                Bimp.tempSelectBitmap.clear();
                Bimp.max = 0;
                send_bt.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size() + "/"+ PublicWay.num+")");
                Intent intent = new Intent("data.broadcast.action");
                sendBroadcast(intent);
                finish();
            } else {
                Untils.DeleteFile(new File(Environment.getExternalStorageDirectory()+Bimp.tempSelectBitmap.get(location).getPath()));
                Untils.delete(GalleryActivity.this,Bimp.tempSelectBitmap.get(location).getPath());
                Bimp.tempSelectBitmap.remove(location);
                Bimp.max--;
                pager.removeAllViews();
                listViews.remove(location);
                adapter.setListViews(listViews);
                send_bt.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size() + "/"+PublicWay.num+")");
                adapter.notifyDataSetChanged();
            }
        }
    }

    // 完成按钮的监听
    private class GallerySendListener implements View.OnClickListener {
        public void onClick(View v) {
//            if(Bimp.tempSelectBitmap.size()>0){
//                for (int i=0;i<Bimp.tempSelectBitmap.size();i++){
//                    Untils.copy(Bimp.tempSelectBitmap.get(i).imagePath,Untils.SDpath+Untils.fujianpath+"/"+Untils.caremtype+"/images/"+ DataTools.getLocaleDayOfMonth()+"/", DataTools.getLocaleTime());
//                }
//            }
            finish();
//            intent.setClass(mContext,MainActivity.class);
//            startActivity(intent);
        }

    }

    public void isShowOkBt() {
        if (Bimp.tempSelectBitmap.size() > 0) {
            send_bt.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size() + "/"+PublicWay.num+")");
            send_bt.setPressed(true);
            send_bt.setClickable(true);
            send_bt.setTextColor(Color.WHITE);
        } else {
            send_bt.setPressed(false);
            send_bt.setClickable(false);
            send_bt.setTextColor(Color.parseColor("#E1E0DE"));
        }
    }

    /**
     * 监听返回按钮
     */
    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {

        if (keyCode == KeyEvent.KEYCODE_BACK) {
            if(position==1){
                this.finish();
                intent.setClass(GalleryActivity.this, AlbumActivity.class);
                startActivity(intent);
            }else if(position==2){
                this.finish();
//                intent.setClass(GalleryActivity.this, ShowAllPhoto.class);
//                startActivity(intent);
            }
        }
        return true;
    }


    class MyPageAdapter extends PagerAdapter {

        private ArrayList<View> listViews;

        private int size;
        public MyPageAdapter(ArrayList<View> listViews) {
            this.listViews = listViews;
            size = listViews == null ? 0 : listViews.size();
        }

        public void setListViews(ArrayList<View> listViews) {
            this.listViews = listViews;
            size = listViews == null ? 0 : listViews.size();
        }

        public int getCount() {
            return size;
        }

        public int getItemPosition(Object object) {
            return POSITION_NONE;
        }

        public void destroyItem(View arg0, int arg1, Object arg2) {
            ((ViewPager) arg0).removeView(listViews.get(arg1 % size));
        }

        public void finishUpdate(View arg0) {
        }

        public Object instantiateItem(View arg0, int arg1) {
            try {
                ((ViewPager) arg0).addView(listViews.get(arg1 % size), 0);

            } catch (Exception e) {
            }
            return listViews.get(arg1 % size);
        }

        public boolean isViewFromObject(View arg0, Object arg1) {
            return arg0 == arg1;
        }

    }
}
