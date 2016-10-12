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

import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.RealRainFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.RealReservoirInfoActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.RealTimeActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by user on 2016/9/18.
 */
public class RealTimeItemAdapter extends BaseAdapter {
    private Context c;
    private ArrayList<HashMap<String, String>> mapsList = null;
    private LayoutInflater inflater = null;
    private RealTimeActivity activity;

    public RealTimeItemAdapter(Context context) {
        mapsList = new ArrayList<>();
        inflater = LayoutInflater.from(context);
        c = context;
        activity = (RealTimeActivity) context;
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
            convertView = inflater.inflate(R.layout.item_forfragment_realtime, null);
            holder.item_fra_realtime_name = (TextView) convertView.findViewById(R.id.item_fra_realtime_name);
            holder.item_fra_realtime_add = (TextView) convertView.findViewById(R.id.item_fra_realtime_add);
            holder.item_fra_realtime_total = (TextView) convertView.findViewById(R.id.item_fra_realtime_total);
            holder.item_fra_realtime_image = (ImageView) convertView.findViewById(R.id.item_fra_realtime_image);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.item_fra_realtime_name.setText(mapsList.get(position).get("name"));
        holder.item_fra_realtime_add.setText(mapsList.get(position).get("add"));
        holder.item_fra_realtime_total.setText(mapsList.get(position).get("total"));

        //取
        SharedPreferences titleTyleSharedPre1 = c.getSharedPreferences("titleTyle", Context.MODE_PRIVATE);
        String a = titleTyleSharedPre1.getString("titleTyle", "实时数据");
        if (a.equals(Untils.RealTimeInfo[0]) || a.equals(Untils.RealTimeInfo[1])) {//实时雨情或实时水位
            holder.item_fra_realtime_image.setVisibility(View.GONE);
//            activity.getSupportFragmentManager().findFragmentById(R.id.linearlayout_realfragment_show).getView().findViewById(R.id.linearlayout_realwaterlevelinfo).setVisibility(View.GONE);
        } else if (a.equals(Untils.RealTimeInfo[2])) {//水库水情
            holder.item_fra_realtime_add.setVisibility(View.INVISIBLE);

            convertView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(c, RealReservoirInfoActivity.class);
                    intent.putExtra("title",mapsList.get(position).get("name"));
                    c.startActivity(intent);
                }
            });
        }

        return convertView;
    }

    public class ViewHolder {
        TextView item_fra_realtime_name, item_fra_realtime_add, item_fra_realtime_total;
        ImageView item_fra_realtime_image;
    }
}
