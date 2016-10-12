package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.GuanXianActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.SouthGQGuanXianActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by user on 2016/8/17.
 */
public class ListGuanXianAdapter extends BaseAdapter {
    ArrayList<HashMap<String, String>> list = null;
    Context context = null;
    LayoutInflater inflater = null;
    HelperDb helperDb = null;
    boolean isGuanxian = false;//默认为管线 true为南干渠管线

    public ListGuanXianAdapter(Context context) {
        this.context = context;
        list = new ArrayList<>();
        inflater = LayoutInflater.from(context);
        helperDb = new HelperDb(context);
    }

    public void clearDatas() {
        list.clear();
    }

    public void addDatas(ArrayList<HashMap<String, String>> mapList) {
        list.clear();
        if (!Untils.isWode) {
            for (int i = 0; i < mapList.size(); i++) {
                if (!mapList.get(i).get("type").equals(Untils.nanganquguanxianType)) {
                    isGuanxian = false;
                    if (mapList.get(i).get(Untils.linepipe[2]) != null && !mapList.get(i).get(Untils.linepipe[2]).equals("")) {
                        list.add(mapList.get(i));
                    } else {
                        helperDb.delete(mapList.get(i).get(Untils.linepipe[0]), Untils.guanxian);
                    }
                } else {
                    isGuanxian = true;
                    list.add(mapList.get(i));
                }
            }
        } else {
            for (int i = 0; i < mapList.size(); i++) {
                if (!mapList.get(i).get("type").equals(Untils.nanganquguanxianType)) {
                    isGuanxian = false;
                    list.add(mapList.get(i));
                } else {
                    isGuanxian = true;
                    list.add(mapList.get(i));
                }

            }
        }
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
            convertView = inflater.inflate(R.layout.item_for_list_guanxian, null);
            holder.textView_kaishi = (TextView) convertView.findViewById(R.id.textView_list_guanxian_kaishizhuanghao);
            holder.textView_shijian = (TextView) convertView.findViewById(R.id.textview_list_guanxian_time);
            holder.textView_kaishizhuanghao = (TextView) convertView.findViewById(R.id.textView_kaishizhuanghao);
            holder.listguanxian_reUpBtn = (Button) convertView.findViewById(R.id.listguanxian_reUpBtn);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        if (Untils.isWode) {
            holder.listguanxian_reUpBtn.setVisibility(View.INVISIBLE);
        }
        if (!isGuanxian) {//管线
            if (list.get(position).get(Untils.linepipe[2]).equals("未填写")) {
//            holder.textView_kaishi.setText("未填写");
                holder.textView_kaishi.setTextColor(Color.parseColor("#999999"));

            }
            holder.textView_kaishizhuanghao.setText("开始桩号");
            holder.textView_kaishi.setText(list.get(position).get(Untils.linepipe[2]));
            holder.textView_shijian.setText(list.get(position).get(Untils.linepipe[14]));
            convertView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(context, GuanXianActivity.class);
                    intent.putExtra("此行数据", (Serializable) list.get(position));
                    intent.putExtra("time", Untils.time);
                    if(Untils.isWode){
                        intent.putExtra("stakeend", list.get(position).get("stakeend"));
                        intent.putExtra("stakestart", list.get(position).get("stakestart"));
                    }
                    context.startActivity(intent);
//                Untils.isUncompleted=true;
                }
            });
        } else {
            holder.textView_kaishi.setText(list.get(position).get(Untils.nanganquguanxian[24]));
            holder.textView_kaishizhuanghao.setText("位置");
            holder.textView_shijian.setText(list.get(position).get(Untils.nanganquguanxian[3]));
            convertView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(context, SouthGQGuanXianActivity.class);
                    intent.putExtra("此行数据", (Serializable) list.get(position));
                    intent.putExtra("time", Untils.time);
                    if(Untils.isWode){
                        intent.putExtra("id", list.get(position).get("id"));
                    }
                    context.startActivity(intent);
//                Untils.isUncompleted=true;
                }
            });


        }
        holder.listguanxian_reUpBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                ToastShow.setShow(context, "接口还在协调中");
            }
        });

        return convertView;
    }

    public class ViewHolder {
        TextView textView_kaishi, textView_shijian, textView_kaishizhuanghao;
        Button listguanxian_reUpBtn;
    }
}
