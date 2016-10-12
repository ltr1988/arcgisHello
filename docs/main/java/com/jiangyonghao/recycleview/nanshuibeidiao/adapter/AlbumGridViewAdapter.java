package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.app.Activity;
import android.content.Context;
import android.util.DisplayMetrics;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.ToggleButton;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;

import com.jiangyonghao.recycleview.nanshuibeidiao.imagedealtool.FinalBitmap;

import java.util.ArrayList;


/**
 * 这个是显示一个文件夹里面的所有图片时用的适配器
 *
 * @author king
 * @version 2014年10月18日  下午11:49:35
 * @QQ:595163260
 */
public class AlbumGridViewAdapter extends BaseAdapter {
    final String TAG = getClass().getSimpleName();
    private Context mContext;
    private ArrayList<ImageItem> dataList;
    private ArrayList<ImageItem> selectedDataList;
    private DisplayMetrics dm;
    private FinalBitmap cache;

    public AlbumGridViewAdapter(Context context, ArrayList<ImageItem> dataList,
                                ArrayList<ImageItem> selectedDataList) {
        mContext = context;
        cache = new FinalBitmap(context);
        this.dataList = dataList;
        this.selectedDataList = selectedDataList;
        dm = new DisplayMetrics();
        ((Activity) mContext).getWindowManager().getDefaultDisplay()
                .getMetrics(dm);
    }

    public int getCount() {
        return dataList.size();
    }

    public Object getItem(int position) {
        return dataList.get(position);
    }

    public long getItemId(int position) {
        return 0;
    }

    /**
     * 存放列表项控件句柄
     */
    private class ViewHolder {
        public ImageView imageView;
        public ToggleButton toggleButton;
        public Button choosetoggle;
        public TextView textView;
    }

    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder viewHolder;
        if (convertView == null) {
            viewHolder = new ViewHolder();
            convertView = LayoutInflater.from(mContext).inflate(R.layout.plugin_camera_select_imageview, parent, false);
            viewHolder.imageView = (ImageView) convertView
                    .findViewById(R.id.image_view);
            viewHolder.toggleButton = (ToggleButton) convertView
                    .findViewById(R.id.toggle_button);
            viewHolder.choosetoggle = (Button) convertView
                    .findViewById(R.id.choosedbt);
//			RelativeLayout.LayoutParams lp = new RelativeLayout.LayoutParams(RelativeLayout.LayoutParams.MATCH_PARENT,dipToPx(65)); 
//			lp.setMargins(50, 0, 50,0); 
//			viewHolder.imageView.setLayoutParams(lp);
            convertView.setTag(viewHolder);
        } else {
            viewHolder = (ViewHolder) convertView.getTag();
        }
        String path;
        if (dataList != null && dataList.size() > position)
            path = dataList.get(position).imagePath;
        else
            path = "camera_default";
        if (path.contains("camera_default")) {
            viewHolder.imageView.setImageResource(R.drawable.plugin_camera_no_pictures);
        } else {
//			ImageManager2.from(mContext).displayImage(viewHolder.imageView,
//					path, Res.getDrawableID("plugin_camera_camera_default"), 100, 100);
            final ImageItem item = dataList.get(position);
            viewHolder.imageView.setTag(item.imagePath);
//            Log.e("sss", "getView: "+item.imagePath);
            cache.display(viewHolder.imageView, item.imagePath);
        }
        viewHolder.toggleButton.setTag(position);
        viewHolder.choosetoggle.setTag(position);
        viewHolder.toggleButton.setOnClickListener(new ToggleClickListener(viewHolder.choosetoggle));
        for (int i=0;i<selectedDataList.size();i++){
            Log.e("dd",  selectedDataList.get(i).getImagePath().equals(dataList.get(position).getImagePath())+"");
            if (selectedDataList.get(i).getImagePath().equals(dataList.get(position).getImagePath())) {
                viewHolder.toggleButton.setChecked(true);
                viewHolder.choosetoggle.setVisibility(View.VISIBLE);
                break;
            } else {
                viewHolder.toggleButton.setChecked(false);
                viewHolder.choosetoggle.setVisibility(View.GONE);
            }
        }

        dataList.get(position).setType(Untils.zhaopian);
        return convertView;
    }

    public int dipToPx(int dip) {
        return (int) (dip * dm.density + 0.5f);
    }

    private class ToggleClickListener implements OnClickListener {
        Button chooseBt;

        public ToggleClickListener(Button choosebt) {
            this.chooseBt = choosebt;
        }

        @Override
        public void onClick(View view) {
            if (view instanceof ToggleButton) {
                ToggleButton toggleButton = (ToggleButton) view;
                int position = (Integer) toggleButton.getTag();
                if (dataList != null && mOnItemClickListener != null
                        && position < dataList.size()) {
                    mOnItemClickListener.onItemClick(toggleButton, position, toggleButton.isChecked(), chooseBt);
                }
            }
        }
    }


    private OnItemClickListener mOnItemClickListener;

    public void setOnItemClickListener(OnItemClickListener l) {
        mOnItemClickListener = l;
    }

    public interface OnItemClickListener {
        public void onItemClick(ToggleButton view, int position,
                                boolean isChecked, Button chooseBt);
    }

}
