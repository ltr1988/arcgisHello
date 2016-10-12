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
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.HistoryXunChaActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.WaitToDoInfoActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.XunChaActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by user on 2016/9/5.
 */
public class WoDeAdapter extends BaseAdapter {
    List<String> strings = null;
    LayoutInflater inflater = null;
    Context context = null;

    public WoDeAdapter(Context context) {
        this.context = context;
        strings = new ArrayList<>();
        inflater = LayoutInflater.from(context);
    }

    public void addDatas(List<String> str) {
        strings.addAll(str);
    }

    public void addDatas(String st) {
        strings.add(st);
    }

    @Override
    public int getCount() {
        return strings.size();
    }

    @Override
    public Object getItem(int position) {
        return strings.get(position);
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
            holder.textView_biaoti = (TextView) convertView.findViewById(R.id.textView_item_detail_biaoti);
            holder.textView_neirong = (TextView) convertView.findViewById(R.id.textView_item_detail_neirong);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.textView_neirong.setVisibility(View.GONE);
        holder.textView_biaoti.setText(strings.get(position));
        convertView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (strings.get(position).equals(Untils.myWork[0])) {//"待办应急事件"
                    Intent intent = new Intent(context, WaitToDoInfoActivity.class);
                    context.startActivity(intent);
                } else if (strings.get(position).equals(Untils.myWork[2])) {//"我的事件上报"
                    Intent intent = new Intent(context, BasicInfoActivity.class);
                    intent.putExtra("who", "shijianshangbao");
                    context.startActivity(intent);
                } else if (strings.get(position).equals(Untils.myWork[3])) {//"巡查记录"
                    Intent intent = new Intent(context,HistoryXunChaActivity.class);
                    context.startActivity(intent);
                }


            }
        });

        return convertView;
    }

    public class ViewHolder {
        TextView textView_biaoti, textView_neirong;
    }
}
