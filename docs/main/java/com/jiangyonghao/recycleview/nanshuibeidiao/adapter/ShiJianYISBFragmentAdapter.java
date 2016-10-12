package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.DetailInfo;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ShiJianWSB;

import java.util.ArrayList;

/**
 * Created by user on 2016/8/17.
 */
public class ShiJianYISBFragmentAdapter extends BaseAdapter {
    ArrayList<ShiJianWSB> list = null;
    Context context = null;
    LayoutInflater inflater = null;

    public ShiJianYISBFragmentAdapter(Context context) {
        this.context = context;
        list = new ArrayList<>();
        inflater = LayoutInflater.from(context);
    }

    public void addDatas(ArrayList<ShiJianWSB> dList) {
        list=dList;
        notifyDataSetChanged();
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
            convertView = inflater.inflate(R.layout.item_sjwsb, null);
            holder.title = (TextView) convertView.findViewById(R.id.item_name_tv);
            holder.time = (TextView) convertView.findViewById(R.id.item_time_tv);
            holder.address = (TextView) convertView.findViewById(R.id.item_locate_tv);
            holder.whoFind = (TextView) convertView.findViewById(R.id.item_position_tv);
            holder.shenhejieguo = (TextView) convertView.findViewById(R.id.textview_sjwsb_yishangbao);
            holder.shjg = (RelativeLayout) convertView.findViewById(R.id.relative_sjwsb_yishangbao);
            holder.relative_weishangbao_button = (RelativeLayout) convertView.findViewById(R.id.relative_weishangbao_button);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.title.setText(list.get(position).getTitle());
        holder.time.setText(list.get(position).getOccurTime());
        holder.address.setText(list.get(position).getOccurLocation());
        holder.whoFind.setText(list.get(position).getCreatorName()+"-"+list.get(position).getDepartName());


            holder.relative_weishangbao_button.setVisibility(View.GONE);
        switch (list.get(position).getStatus()){
            case "0":
                holder.shenhejieguo.setText("草稿");
                holder.shenhejieguo.setTextColor(Color.parseColor("#FF4081"));
                break;
            case "1":
                holder.shenhejieguo.setText("处理中");
                holder.shenhejieguo.setTextColor(Color.parseColor("##ff6633"));
                break;
            case "99":
                holder.shenhejieguo.setText("已办理");
                holder.shenhejieguo.setTextColor(Color.parseColor("#ff6633"));
                break;
        }


        return convertView;
    }

    public class ViewHolder {
        TextView title, time, address, whoFind, shenhejieguo;
        RelativeLayout shjg,relative_weishangbao_button;
    }
}
