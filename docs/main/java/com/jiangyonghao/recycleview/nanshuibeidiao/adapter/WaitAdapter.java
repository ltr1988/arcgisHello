package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.content.Intent;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.BasicInfoActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.WaitToDoInfoActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.WaitInfo;

import java.util.ArrayList;

/**
 * Created by user on 2016/9/5.
 */
public class WaitAdapter extends BaseAdapter {
    ArrayList<WaitInfo> infos = null;
    LayoutInflater inflater = null;
    Context c;

    public WaitAdapter(Context context) {
        c = context;
        inflater = LayoutInflater.from(context);
        infos = new ArrayList<>();
    }

    public void setDatas(ArrayList<WaitInfo> in) {
        infos=in;
        notifyDataSetChanged();
    }
    public void AddDatas(ArrayList<WaitInfo> in) {
        infos.addAll(in);
        notifyDataSetChanged();
    }


    @Override
    public int getCount() {
        return infos.size();
    }

    @Override
    public Object getItem(int position) {
        return infos.get(position);
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
            convertView = inflater.inflate(R.layout.item_for_waittodo_lvl, null);
            holder.textView_title = (TextView) convertView.findViewById(R.id.textview_wait_title);
            holder.textView_time = (TextView) convertView.findViewById(R.id.textview_wait_time);
            holder.textView_add = (TextView) convertView.findViewById(R.id.textview_wait_add);
            holder.textView_find = (TextView) convertView.findViewById(R.id.textview_wait_find);
            holder.textView_xingzhi = (TextView) convertView.findViewById(R.id.textview_wait_xingzhi);
            holder.textView_jibie = (TextView) convertView.findViewById(R.id.textview_wait_jibie);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.textView_title.setText(infos.get(position).getTitle());
        holder.textView_time.setText(infos.get(position).getOccurTime());
        holder.textView_add.setText(infos.get(position).getOccurLocation());
        holder.textView_find.setText(infos.get(position).getDepartName()+"-"+infos.get(position).getCreatorName());

//        SZWR 水质污染  GCAQ 工程安全
//        YJDD应急调度  FXQX 防汛抢险
//        1 一级响应  2 二级响应
//        3 三级响应  4 四级响应
//        5 五级响应
        switch (infos.get(position).getCreatorName()){
            case "SZWR":
                holder.textView_xingzhi.setText("水质污染");
                break;
            case "GCAQ":
                holder.textView_xingzhi.setText("工程安全");
                break;
            case "YJDD":
                holder.textView_xingzhi.setText("应急调度");
                break;
            case "FXQX":
                holder.textView_xingzhi.setText("防汛抢险");
                break;
        }
        switch (infos.get(position).getResponseLevel()){
            case "1":
                holder.textView_jibie.setText("一级响应");
                break;
            case "2":
                holder.textView_jibie.setText("二级响应");
                break;
            case "3":
                holder.textView_jibie.setText("三级响应");
                break;
            case "4":
                holder.textView_jibie.setText("四级响应");
                break;
            case "5":
                holder.textView_jibie.setText("五级响应");
                break;
        }

        convertView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(c, BasicInfoActivity.class);
                intent.putExtra("who","Evolve");
                intent.putExtra("id",infos.get(position).getId());
                intent.putExtra("disposeBy",infos.get(position).getDepartName());
                c.startActivity(intent);
            }
        });

        return convertView;
    }

    public class ViewHolder {
        TextView textView_title, textView_time, textView_add, textView_find, textView_xingzhi, textView_jibie;
    }
}
