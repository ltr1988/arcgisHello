package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.RealReservoirInfoActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.RealTimeActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by user on 2016/9/18.
 */
public class ReservoirAdapter extends BaseAdapter {
    private Context c;
    private ArrayList<HashMap<String, String>> mapsList = null;
    private LayoutInflater inflater = null;

    public ReservoirAdapter(Context context) {
        mapsList = new ArrayList<>();
        inflater = LayoutInflater.from(context);
        c = context;
    }

    public void addDatas(ArrayList<HashMap<String, String>> mt) {
        mapsList.addAll(mt);
    }

    @Override
    public int getCount() {
        return mapsList.size();
    }

    @Override
    public Object getItem(int position) {
        return mapsList.get(position);
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
            convertView = inflater.inflate(R.layout.item_for_reservoir_activity, null);
            holder.item_fra_realtime_name = (TextView) convertView.findViewById(R.id.item_act_realtime_name);
            holder.item_fra_realtime_total = (TextView) convertView.findViewById(R.id.item_act_realtime_total);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.item_fra_realtime_name.setText(mapsList.get(position).get("name"));
        holder.item_fra_realtime_total.setText(mapsList.get(position).get("total"));
        return convertView;
    }

    public class ViewHolder {
        TextView item_fra_realtime_name, item_fra_realtime_total;
    }
}
