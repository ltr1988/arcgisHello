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
 * Created by Administrator on 2016/9/13 0013.
 */
public class NetDataAdapter extends BaseAdapter {
    private Context context;
    private List<NetDatalistEntity> datalist;
    private String jinghao = "";

    public NetDataAdapter(Context context) {
        this.context = context;
        datalist = new ArrayList<>();
    }

    public NetDataAdapter(Context context, String jinghao) {
        this.context = context;
        this.jinghao = jinghao;
        datalist = new ArrayList<>();
    }

    public void setData(List<NetDatalistEntity> datalist) {
        this.datalist = datalist;
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
        ViewHolder holder = null;
        if (convertView == null) {
            holder = new ViewHolder();
            convertView = LayoutInflater.from(context).inflate(R.layout.item_noupload_listview, null);
            holder.titletype = (TextView) convertView.findViewById(R.id.titletype);
            holder.noUpname_tv = (TextView) convertView.findViewById(R.id.Nouptitle_TV);
            holder.Nouptime_TV = (TextView) convertView.findViewById(R.id.Nouptime_TV);
            holder.reUp_btn = (Button) convertView.findViewById(R.id.reUpBtn);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.noUpname_tv.setText(datalist.get(position).getNumber());
        holder.noUpname_tv.setTextColor(Color.BLACK);
        holder.titletype.setText(convertView.getResources().getString(R.string.jinghao));
        holder.Nouptime_TV.setVisibility(View.GONE);
        holder.reUp_btn.setVisibility(View.GONE);
        switch (jinghao) {
            case "干渠":
                holder.titletype.setText(convertView.getResources().getString(R.string.jinghao));
                break;
            case "分水口":
                holder.titletype.setText(convertView.getResources().getString(R.string.fenshuikouhao));
                break;
        }
        return convertView;
    }

    class ViewHolder {
        TextView titletype;
        TextView noUpname_tv;
        TextView Nouptime_TV;
        Button reUp_btn;
    }
}
