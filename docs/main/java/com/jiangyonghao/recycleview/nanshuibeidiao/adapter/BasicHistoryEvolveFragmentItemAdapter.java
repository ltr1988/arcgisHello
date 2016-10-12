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
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.BasicDetailActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.HistoryEvolveInfo;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.SheBeiInfo;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by user on 2016/8/23.
 */
public class BasicHistoryEvolveFragmentItemAdapter extends BaseAdapter{
    private Context context;
    private LayoutInflater inflater=null;
    List<HistoryEvolveInfo.DataBean> list=new ArrayList<>();
    public BasicHistoryEvolveFragmentItemAdapter(Context context) {
        this.context=context;
        inflater= LayoutInflater.from(this.context);
    }
    public void setDatas(List<HistoryEvolveInfo.DataBean> list){
        this.list=list;
        this.notifyDataSetChanged();
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
        ViewHolder holder=null;
        if (convertView == null){
            holder = new ViewHolder();
            convertView = inflater.inflate(R.layout.item_for_fragment_basic_history_evolve, null);
            holder.title = (TextView) convertView.findViewById(R.id.textview_item_basic_history_evolve_title);
            holder.who = (TextView) convertView.findViewById(R.id.textView_item_basic_history_evolve_who);
            holder.where = (TextView) convertView.findViewById(R.id.textView_item_basic_history_evolve_where);
            holder.time = (TextView) convertView.findViewById(R.id.textView_item_basic_history_evolve_time);
            convertView.setTag(holder);
        }else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.title.setText(list.get(position).getDisposeDescription());
        holder.who.setText(list.get(position).getCreatorName());
        holder.where.setText(list.get(position).getDisposeBy());
        holder.time.setText(list.get(position).getAddTime());
        return convertView;
    }
    public class ViewHolder {
        TextView title,who,where,time;
    }
}
