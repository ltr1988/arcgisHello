package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Bitmap;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Environment;
import android.view.KeyEvent;
import android.view.View;
import android.widget.Button;
import android.widget.GridView;
import android.widget.TextView;
import android.widget.ToggleButton;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.AlbumGridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.AlbumHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Bimp;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageBucket;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.PublicWay;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class AlbumActivity extends Baseactivity {
    //显示手机里的所有图片的列表控件
    private GridView gridView;
    //当手机里没有图片时，提示用户没有图片的控件
    private TextView tv;
    //gridView的adapter
    private AlbumGridViewAdapter gridImageAdapter;
    //完成按钮
    private Button okButton;
    // 返回按钮
    private Button back;
    // 取消按钮
    private Button cancel;
    private Intent intent;
    // 预览按钮
    private Button preview;
    private Context mContext;
    private ArrayList<ImageItem> dataList;
    private AlbumHelper helper;
    public static List<ImageBucket> contentList;
    public static Bitmap bitmap;
    private HelperDb helperDb;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_album);
        mContext = this;
        helperDb = new HelperDb(this);
        //注册一个广播，这个广播主要是用于在GalleryActivity进行预览时，防止当所有图片都删除完后，再回到该页面时被取消选中的图片仍处于选中状态
        IntentFilter filter = new IntentFilter("data.broadcast.action");
        registerReceiver(broadcastReceiver, filter);
        init();
        initListener();
        //这个函数主要用来控制预览和完成按钮的状态
        isShowOkBt();
    }
    private boolean removeOneData(ImageItem imageItem) {
        if (Bimp.tempSelectBitmap.contains(imageItem)) {
            Bimp.tempSelectBitmap.remove(imageItem);
            okButton.setText(getResources().getString(R.string.finish)+"(" +Bimp.tempSelectBitmap.size() + "/"+PublicWay.num+")");
            return true;
        }
        return false;
    }
    private void initListener() {

        gridImageAdapter
                .setOnItemClickListener(new AlbumGridViewAdapter.OnItemClickListener() {

                    @Override
                    public void onItemClick(final ToggleButton toggleButton,
                                            int position, boolean isChecked,Button chooseBt) {
                        if (Bimp.tempSelectBitmap.size() >= PublicWay.num) {
                            toggleButton.setChecked(false);
                            chooseBt.setVisibility(View.GONE);
                            if (!removeOneData(dataList.get(position))) {
                                ToastShow.setShow(AlbumActivity.this, getResources().getString(R.string.only_choose_num));
                            }
                            return;
                        }
                        Untils.issave = true;
                        if (isChecked) {
                            String uid =Untils.setuuid() ;
                            chooseBt.setVisibility(View.VISIBLE);
                            Untils.copy(dataList.get(position).imagePath,Untils.SDpath+Untils.fujianpath+"/"+Untils.caremtype+"/image/"+DataTools.getLocaleDayOfMonth()+"/",uid+".png");
                            dataList.get(position).setPath(Untils.path+Untils.fujianpath+"/"+Untils.caremtype+"/image/"+DataTools.getLocaleDayOfMonth()+"/"+uid+".png");
                            Bimp.tempSelectBitmap.add(dataList.get(position));
                            HashMap map = new HashMap();
                            map.put(Untils.attachmentform[0],Untils.setuuid());
                            map.put(Untils.attachmentform[1],Untils.starttime1);
                            map.put(Untils.attachmentform[2],Untils.caremtype);
                            map.put(Untils.attachmentform[3],dataList.get(position).imagePath);
                            map.put(Untils.attachmentform[5],"0");
                            map.put(Untils.attachmentform[6],dataList.get(position).getPath());
                            map.put(Untils.attachmentform[7],Untils.zhaopian);
                            map.put(Untils.attachmentform[8],Untils.biaoid);

                            helperDb.setinsertAttachmentform(map);
//                }
                            okButton.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size()
                                    + "/"+PublicWay.num+")");
                        } else {
                            Untils.DeleteFile(new File(Environment.getExternalStorageDirectory()+dataList.get(position).getPath()));
                            Untils.delete(AlbumActivity.this,dataList.get(position).getPath());
                            Bimp.tempSelectBitmap.remove(dataList.get(position));
                            chooseBt.setVisibility(View.GONE);
                            okButton.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size() + "/"+PublicWay.num+")");
                        }
                        isShowOkBt();
                    }
                });

        okButton.setOnClickListener(new AlbumSendListener());

    }
    // 完成按钮的监听
    private class AlbumSendListener implements View.OnClickListener {
        public void onClick(View v) {
//            overridePendingTransition(R.anim.activity_translate_in, R.anim.activity_translate_out);
//            intent.setClass(mContext, MainActivity.class);
//            startActivity(intent);
//            if(Bimp.tempSelectBitmap.size()>0){
//                for (int i=0;i<Bimp.tempSelectBitmap.size();i++){
//
//            }

            finish();
        }

    }

    public void isShowOkBt() {
        if (Bimp.tempSelectBitmap.size() > 0) {
            okButton.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size() + "/"+PublicWay.num+")");
            preview.setPressed(true);
            okButton.setPressed(true);
            preview.setClickable(true);
            okButton.setClickable(true);
            okButton.setTextColor(Color.WHITE);
            preview.setTextColor(Color.WHITE);
        } else {
            okButton.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size() + "/"+PublicWay.num+")");
            preview.setPressed(false);
            preview.setClickable(false);
            okButton.setPressed(false);
            okButton.setClickable(false);
            okButton.setTextColor(Color.parseColor("#E1E0DE"));
            preview.setTextColor(Color.parseColor("#E1E0DE"));
        }
    }
    private void init() {
        helper = AlbumHelper.getHelper();
        helper.init(getApplicationContext());

        contentList = helper.getImagesBucketList(false);
        dataList = new ArrayList<ImageItem>();
        for(int i = 0; i<contentList.size(); i++){
            dataList.addAll(contentList.get(i).imageList );
        }

        back = (Button) findViewById(R.id.back);
        cancel = (Button) findViewById(R.id.cancel);
        cancel.setOnClickListener(new CancelListener());
        back.setOnClickListener(new BackListener());
        preview = (Button) findViewById(R.id.preview);
        preview.setOnClickListener(new PreviewListener());
        intent = getIntent();
        Bundle bundle = intent.getExtras();
        gridView = (GridView) findViewById(R.id.myGrid);
        gridImageAdapter = new AlbumGridViewAdapter(this,dataList,
                Bimp.tempSelectBitmap);
        gridView.setAdapter(gridImageAdapter);
        tv = (TextView) findViewById(R.id.myText);
        gridView.setEmptyView(tv);
        okButton = (Button) findViewById(R.id.ok_button);
        okButton.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size()
                + "/"+ PublicWay.num+")");
    }
    // 预览按钮的监听
    private class PreviewListener implements View.OnClickListener {
        public void onClick(View v) {
            if (Bimp.tempSelectBitmap.size() > 0) {
                intent.putExtra("position", "1");
                intent.setClass(AlbumActivity.this, GalleryActivity.class);
                startActivity(intent);
            }else{
                ToastShow.setShow(AlbumActivity.this,"请选择照片!");
            }
        }

    }

    // 取消按钮的监听
    private class CancelListener implements View.OnClickListener {
        public void onClick(View v) {
//            Bimp.tempSelectBitmap.clear();
//            intent.setClass(mContext, MainActivity.class);
//            startActivity(intent);
            finish();
        }
    }
    // 返回按钮监听
    private class BackListener implements View.OnClickListener {
        public void onClick(View v) {
            intent.setClass(AlbumActivity.this, ImageFile.class);
            startActivity(intent);
            finish();
        }
    }

    BroadcastReceiver broadcastReceiver = new BroadcastReceiver() {

        @Override
        public void onReceive(Context context, Intent intent) {
            //mContext.unregisterReceiver(this);
            // TODO Auto-generated method stub
            isShowOkBt();
            gridImageAdapter.notifyDataSetChanged();
        }
    };

    @Override
    protected void onDestroy() {
        super.onDestroy();
        unregisterReceiver(broadcastReceiver);
    }
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
           finish();
        }
        return false;

    }
}
