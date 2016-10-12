package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.graphics.Color;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Administrator on 2016/8/17 0017.
 */
public class ShijiansbNoUpAdapter extends BaseAdapter {
    private Context context;
    private ArrayList<HashMap<String, String>> dataList;
    private String dongganqu = "";

    public ShijiansbNoUpAdapter(Context context) {
        this.context = context;
        dataList = new ArrayList<>();
    }

    public ShijiansbNoUpAdapter(Context context, String dongganqu) {
        this.context = context;
        this.dongganqu = dongganqu;
        dataList = new ArrayList<>();
    }

    public void setData(ArrayList<HashMap<String, String>> dataList) {
        this.dataList = dataList;
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        return dataList.size() == 0 ? 0 : dataList.size();
    }

    @Override
    public Object getItem(int position) {
        return dataList.get(position);
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
        if ("".equals(dongganqu)) {
            holder.noUpname_tv.setText(dataList.get(position).get(Untils.emergencyform[3]) == null ? context.getResources().getString(R.string.weitianxie) : dataList.get(position).get(Untils.emergencyform[3]));
            if (dataList.get(position).get(Untils.emergencyform[3]) != null) {
                holder.noUpname_tv.setTextColor(Color.BLACK);
            } else {
                holder.noUpname_tv.setTextColor(Color.GRAY);
            }
            holder.Nouptime_TV.setText(dataList.get(position).get(Untils.emergencyform[1]));
        }else if ("dongganqufenshui".equals(dongganqu)){
            holder.titletype.setText(convertView.getResources().getString(R.string.fenshuikouhao));
            //因为表单井号和starttime在数组中位置相同，所有可以共用
            holder.noUpname_tv.setText(dataList.get(position).get(Untils.dongganqufenshui[6]) == null || "".equals(dataList.get(position).get(Untils.dongganqufenshui[6])) ? "分水口未填写" : dataList.get(position).get(Untils.dongganqufenshui[6]));
            if (dataList.get(position).get(Untils.dongganqufenshui[6]) == null || "".equals(dataList.get(position).get(Untils.dongganqufenshui[6]))) {
                holder.noUpname_tv.setTextColor(Color.GRAY);
            } else {
                holder.noUpname_tv.setTextColor(Color.BLACK);
            }
            holder.Nouptime_TV.setText(dataList.get(position).get(Untils.dongganqupaiqi[4]));
        } else {
            holder.titletype.setText(convertView.getResources().getString(R.string.jinghao));
            //因为表单井号和starttime在数组中位置相同，所有可以共用
            holder.noUpname_tv.setText(dataList.get(position).get(Untils.dongganqupaiqi[6]) == null || "".equals(dataList.get(position).get(Untils.dongganqupaiqi[6])) ? "井号未填写" : dataList.get(position).get(Untils.dongganqupaiqi[6]));
            if (dataList.get(position).get(Untils.dongganqupaiqi[6]) == null || "".equals(dataList.get(position).get(Untils.dongganqupaiqi[6]))) {
                holder.noUpname_tv.setTextColor(Color.GRAY);
            } else {
                holder.noUpname_tv.setTextColor(Color.BLACK);
            }
            holder.Nouptime_TV.setText(dataList.get(position).get(Untils.dongganqupaiqi[4]));
        }

        holder.reUp_btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                reUpload();
            }
        });

        return convertView;
    }

    //    重新上报
    private void reUpload() {
        ToastShow.setShow(context, "接口还在协调中");
    }

    class ViewHolder {
        TextView titletype;
        TextView noUpname_tv;
        TextView Nouptime_TV;
        Button reUp_btn;
    }

}
