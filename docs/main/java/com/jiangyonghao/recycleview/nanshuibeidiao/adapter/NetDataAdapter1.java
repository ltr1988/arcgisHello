package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.NetDatalistEntity;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by jiangyonghao on 2016/9/19.
 */
public class NetDataAdapter1 extends BaseAdapter {
    private Context context;
    private List<NetDatalistEntity> datalist;
    public NetDataAdapter1(Context context) {
        this.context = context;
        datalist=new ArrayList<>();
    }
    public void setData(List<NetDatalistEntity> datalist){
        this.datalist=datalist;
        notifyDataSetChanged();
    }
    @Override
    public int getCount() {
        return datalist.size();
    }

    @Override
    public Object getItem(int position) {
        return datalist.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder=null;
        if (convertView==null){
            holder = new ViewHolder();
            convertView= LayoutInflater.from(context).inflate(R.layout.item_noupload_listview1,null);
            holder.titletype = (TextView) convertView.findViewById(R.id.Nouptitle_TV);
            holder.noUpname_tv = (TextView) convertView.findViewById(R.id.starttime);
            holder.Nouptime_TV = (TextView) convertView.findViewById(R.id.endtime);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.noUpname_tv.setText(datalist.get(position).getStarttime());
        holder.noUpname_tv.setTextColor(Color.BLACK);
        holder.titletype.setText(datalist.get(position).getName());
        holder.Nouptime_TV.setText(datalist.get(position).getEndtime());
        return convertView;
    }
    class ViewHolder {
        TextView titletype;
        TextView noUpname_tv;
        TextView Nouptime_TV;
    }
}
