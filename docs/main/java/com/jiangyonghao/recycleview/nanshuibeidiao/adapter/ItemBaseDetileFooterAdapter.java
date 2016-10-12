package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;

/**
 * Created by user on 2016/8/26.
 */
public class ItemBaseDetileFooterAdapter extends BaseAdapter {
    LayoutInflater inflater=null;
    int[] pic=null;

    public ItemBaseDetileFooterAdapter(Context context,int[] pic) {
        inflater=LayoutInflater.from(context);
        this.pic=pic;
    }

    @Override
    public int getCount() {
        return pic.length;
    }

    @Override
    public Object getItem(int position) {
        return pic[position];
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        convertView=inflater.inflate(R.layout.item_basedetile_footer,null);
        ImageView piciv= (ImageView) convertView.findViewById(R.id.imageView_item_basedetile_iv);
        piciv.setImageResource(pic[position]);
        return convertView;
    }
}
