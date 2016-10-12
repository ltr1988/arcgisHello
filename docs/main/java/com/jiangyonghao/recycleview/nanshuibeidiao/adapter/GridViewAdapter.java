package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Environment;
import android.view.Gravity;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.Baseactivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.ShowPhotoActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.PhotoTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;
import com.jiangyonghao.recycleview.nanshuibeidiao.imagedealtool.FinalBitmap;

import java.util.ArrayList;

/**
 * Created by young on 2016/8/19 0019.
 */
public class GridViewAdapter extends BaseAdapter {
    private Context context;
    private ImageView imageView;
    private ArrayList<ImageItem> imgList;
    private FinalBitmap finalb;
    private GridViewAdapter adapter;

    public GridViewAdapter(Context context) {
        this.context = context;
        imageView = new ImageView(context);
        imageView.setImageResource(R.drawable.addimg);
        imgList = new ArrayList<>();
        finalb = new FinalBitmap(context);
    }
    public void setImage(ArrayList<ImageItem> imgList){
        this.imgList = imgList;
        notifyDataSetChanged();
    }
    public void setImage(ArrayList<ImageItem> imgList,GridViewAdapter adapter) {
        this.imgList = imgList;
        Baseactivity.shipinlist.clear();
        Baseactivity.zhaopianlist.clear();
        for (int i=0;i<imgList.size();i++){
                if (imgList.get(i).getType().equals(Untils.shipin)){
                    Baseactivity.shipinlist.add(imgList.get(i));
                }else if (imgList.get(i).getType().equals(Untils.zhaopian)){
                    Baseactivity.zhaopianlist.add(imgList.get(i));
                }
        }
        imgList.clear();
        imgList.addAll(Baseactivity.zhaopianlist);
        imgList.addAll(Baseactivity.shipinlist);
        this.adapter =adapter;
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        return imgList.size() + 1;
    }

    @Override
    public Object getItem(int position) {
        return imgList.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        if (convertView == null) {
            convertView = LayoutInflater.from(context).inflate(R.layout.item_for_gridview,
                    parent, false);
            holder = new ViewHolder();
            holder.image = (ImageView) convertView
                    .findViewById(R.id.img_GV);
            holder.deleteImg = (ImageView) convertView.findViewById(R.id.delete_icon);
            holder.startImag = (ImageView) convertView.findViewById(R.id.start_icon);
            holder.titleTV= (TextView) convertView.findViewById(R.id.gvtitle_TV);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        if (position < imgList.size()) {
            if (imgList.get(position).getType().equals(Untils.shipin)) {
                holder.startImag.setVisibility(View.VISIBLE);
                finalb.display(holder.image, Environment.getExternalStorageDirectory().getAbsolutePath()+imgList.get(position).getPath().split(".mp4")[0]+".png",100,100);
            } else {
                holder.startImag.setVisibility(View.GONE);
                finalb.display(holder.image, Environment.getExternalStorageDirectory().getAbsolutePath()+imgList.get(position).getPath());
            }
            holder.deleteImg.setVisibility(View.VISIBLE);

        } else {
            holder.image.setImageResource(R.drawable.icon_camera);
            holder.image.setScaleType(ImageView.ScaleType.FIT_CENTER);
//            holder.image.setBackgroundResource(R.drawable.addimg);
            holder.startImag.setVisibility(View.GONE);
            holder.deleteImg.setVisibility(View.GONE);
        }
        holder.image.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (position == imgList.size()) {
                    Untils.setHidden(context);
                    PhotoTools.pop.showAtLocation(PhotoTools.rootView, Gravity.BOTTOM, 0, 0);
                }else{
                    Intent intent = new Intent(context, ShowPhotoActivity.class);
                    intent.putExtra("position",position);
                    ((Activity)context).startActivity(intent);
//                    if(imgList.get(position).getType().equals(Untils.shipin)){
//                        Uri uri=Uri.parse("file://"+imgList.get(position).getImagePath());
//                        Intent it = new Intent(Intent.ACTION_VIEW,uri);
//                        it.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//                        it.setType("video/*");
//                        context.startActivity(it);
//                    }

                }

            }
        });
        holder.deleteImg.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                delete(imgList.get(position).getPath(), position,imgList.get(position).getType());
            }
        });
        holder.startImag.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(imgList.get(position).getType().equals(Untils.shipin)){
//                    Uri uri=Uri.parse("file://"+imgList.get(position).getImagePath());
//                    Intent it = new Intent(Intent.ACTION_VIEW,uri);
//                    it.setFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
//                    it.setType("video/*");
//                    context.startActivity(it);
                    Intent intent = new Intent(context, ShowPhotoActivity.class);
                    intent.putExtra("position",position);
                    ((Activity)context).startActivity(intent);
                }
            }
        });
        return convertView;
    }
    //删除图片
    private void delete(String path, int postion,String type) {
        Untils.delete(context, path, postion,adapter,type);
    }


    public class ViewHolder {
        public ImageView image;
        public ImageView deleteImg;
        public ImageView startImag;
        public TextView titleTV;
    }
}
