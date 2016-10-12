package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.graphics.Color;
import android.os.Bundle;
import android.os.Environment;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.GridView;
import android.widget.ProgressBar;
import android.widget.TextView;
import android.widget.ToggleButton;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.AlbumGridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Bimp;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.PublicWay;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;

public class ShowAllPhoto extends Baseactivity {
    private GridView gridView;
    private ProgressBar progressBar;
    private AlbumGridViewAdapter gridImageAdapter;
    // 完成按钮
    private Button okButton;
    // 预览按钮
    private Button preview;
    // 返回按钮
    private Button back;
    // 取消按钮
    private Button cancel;
    // 标题
    private TextView headTitle;
    private Intent intent;
    private Context mContext;
    private HelperDb helperDb;
    public static ArrayList<ImageItem> dataList = new ArrayList<ImageItem>();
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_show_all_photo);
        Baseactivity.addactvity(this);
        mContext = this;
        helperDb = new HelperDb(this);
        back = (Button) findViewById(R.id.showallphoto_back);
        cancel = (Button) findViewById(R.id.showallphoto_cancel);
        preview = (Button) findViewById(R.id.showallphoto_preview);
        okButton = (Button) findViewById(R.id.showallphoto_ok_button);
        headTitle = (TextView) findViewById(R.id.showallphoto_headtitle);
        this.intent = getIntent();
        String folderName = intent.getStringExtra("folderName");
//        if (folderName.length() > 8) {
//            folderName = folderName.substring(0, 9) + "...";
//        }
        headTitle.setText(folderName+"");
        cancel.setOnClickListener(new CancelListener());
        back.setOnClickListener(new BackListener(intent));
        preview.setOnClickListener(new PreviewListener());
        init();
        initListener();
        isShowOkBt();
    }
    BroadcastReceiver broadcastReceiver = new BroadcastReceiver() {

        @Override
        public void onReceive(Context context, Intent intent) {
            // TODO Auto-generated method stub
            gridImageAdapter.notifyDataSetChanged();
        }
    };
    private class PreviewListener implements OnClickListener {
        public void onClick(View v) {
            if (Bimp.tempSelectBitmap.size() > 0) {
                intent.putExtra("position", "2");
                intent.setClass(ShowAllPhoto.this, GalleryActivity.class);
                startActivity(intent);
            }
        }

    }

    private class BackListener implements OnClickListener {// 返回按钮监听
        Intent intent;

        public BackListener(Intent intent) {
            this.intent = intent;
        }

        public void onClick(View v) {
            intent.setClass(ShowAllPhoto.this, ImageFile.class);
            startActivity(intent);
        }

    }

    private class CancelListener implements OnClickListener {// 取消按钮的监听
        public void onClick(View v) {
            //清空选择的图片
//            Bimp.tempSelectBitmap.clear();
//            intent.setClass(mContext, MainActivity.class);
//            startActivity(intent);
            finish();
        }
    }

    private void init() {
        IntentFilter filter = new IntentFilter("data.broadcast.action");
        registerReceiver(broadcastReceiver, filter);
        progressBar = (ProgressBar) findViewById(R.id.showallphoto_progressbar);
        progressBar.setVisibility(View.GONE);
        gridView = (GridView) findViewById(R.id.showallphoto_myGrid);
        gridImageAdapter = new AlbumGridViewAdapter(this,dataList,
                Bimp.tempSelectBitmap);
        gridView.setAdapter(gridImageAdapter);
        okButton = (Button) findViewById(R.id.showallphoto_ok_button);
    }

    private void initListener() {

        gridImageAdapter
                .setOnItemClickListener(new AlbumGridViewAdapter.OnItemClickListener() {
                    public void onItemClick(final ToggleButton toggleButton,
                                            int position, boolean isChecked,
                                            Button button) {
                        if (Bimp.tempSelectBitmap.size() >= PublicWay.num&&isChecked) {
                            button.setVisibility(View.GONE);
                            toggleButton.setChecked(false);
                            ToastShow.setShow(ShowAllPhoto.this, getResources().getString(R.string.only_choose_num));
                            return;
                        }

                        if (isChecked) {
                            button.setVisibility(View.VISIBLE);
                            String uid =Untils.setuuid() ;
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
                            okButton.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size()
                                    + "/"+PublicWay.num+")");
                        } else {
                            Untils.DeleteFile(new File(Environment.getExternalStorageDirectory()+dataList.get(position).getPath()));
                            Untils.delete(ShowAllPhoto.this,dataList.get(position).getPath());
                            button.setVisibility(View.GONE);
                            Bimp.tempSelectBitmap.remove(dataList.get(position));
                            okButton.setText(getResources().getString(R.string.finish)+"(" + Bimp.tempSelectBitmap.size() + "/"+PublicWay.num+")");
                        }
                        isShowOkBt();
                    }
                });

        okButton.setOnClickListener(new OnClickListener() {

            @Override
            public void onClick(View v) {
                okButton.setClickable(false);
//				if (PublicWay.photoService != null) {
//					PublicWay.selectedDataList.addAll(Bimp.tempSelectBitmap);
//					Bimp.tempSelectBitmap.clear();
//					PublicWay.photoService.onActivityResult(0, -2,
//							intent);
//				}

//                intent.setClass(mContext, MainActivity.class);
//                startActivity(intent);
                // Intent intent = new Intent();
                // Bundle bundle = new Bundle();
                // bundle.putStringArrayList("selectedDataList",
                // selectedDataList);
                // intent.putExtras(bundle);
                // intent.setClass(ShowAllPhoto.this, UploadPhoto.class);
                // startActivity(intent);
//                if(Bimp.tempSelectBitmap.size()>0){
//                    for (int i=0;i<Bimp.tempSelectBitmap.size();i++){
//                        Untils.copy(Bimp.tempSelectBitmap.get(i).imagePath,Untils.SDpath+Untils.fujianpath+"/管线/images/"+ DataTools.getLocaleDayOfMonth()+"/", DataTools.getLocaleTime());
//                    }
//                }
                finish();

            }
        });

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

    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            this.finish();
            intent.setClass(ShowAllPhoto.this, ImageFile.class);
            startActivity(intent);
        }

        return false;

    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        unregisterReceiver(broadcastReceiver);
    }

    @Override
    protected void onRestart() {
        // TODO Auto-generated method stub
        isShowOkBt();
        super.onRestart();
    }
}
