package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.GuanXianActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.DetailInfo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by user on 2016/8/17.
 */
public class BasicDetailAdapter extends BaseAdapter {
    ArrayList<DetailInfo> list = null;
    Context context = null;
    LayoutInflater inflater = null;

    public BasicDetailAdapter(Context context) {
        this.context = context;
        list = new ArrayList<>();
        inflater = LayoutInflater.from(context);
    }

    public void clearDatas() {
        list.clear();
    }

    public void addDatas(ArrayList<DetailInfo> dList) {
        list.addAll(dList);
    }

    @Override
    public int getCount() {
        return list.size();
    }

    @Override
    public Object getItem(int position) {
        return list.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        if (convertView == null) {
            holder = new ViewHolder();
            convertView = inflater.inflate(R.layout.item_for_basic_detail, null);
            holder.biaoti = (TextView) convertView.findViewById(R.id.textView_item_detail_biaoti);
            holder.neirong = (TextView) convertView.findViewById(R.id.textView_item_detail_neirong);
            holder.into = (ImageView) convertView.findViewById(R.id.imageView_news_into);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.biaoti.setText(list.get(position).getTitle());
        holder.neirong.setText(list.get(position).getNeirong());
        return convertView;
    }

    public class ViewHolder {
        TextView biaoti, neirong;
        ImageView into;
    }
}
