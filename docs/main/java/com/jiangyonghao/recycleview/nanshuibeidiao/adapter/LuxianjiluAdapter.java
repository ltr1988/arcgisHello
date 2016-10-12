package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/8/23 0023.
 */
public class LuxianjiluAdapter extends BaseAdapter {
    private Context context;
    private List<HashMap<String, String>> jiluList;
    private static final int TYPE_SEARCH = 0;
    private static final int TYPE_LOCATE = 1;

    public LuxianjiluAdapter(Context context) {
        this.context = context;
        jiluList = new ArrayList<>();
    }

    public void setList(List<HashMap<String, String>> jiluList) {
        this.jiluList = jiluList;
        notifyDataSetChanged();
    }

    public void addList(List<HashMap<String, String>> jilu) {
        this.jiluList.addAll(jilu);
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        return jiluList.size();
    }

    @Override
    public Object getItem(int position) {
        return jiluList.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public int getItemViewType(int position) {
        if ("0".equals(jiluList.get(position).get(Untils.searchform[1]))) {
            return TYPE_SEARCH;

        } else {
            return TYPE_LOCATE;

        }

    }

    public int getViewTypeCount() {
        // TODO Auto-generated method stub
        return 2;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        int Type = getItemViewType(position);
        ViewHolder0 holder0 = null;
        ViewHolder1 holder1=null;
        if (convertView == null) {
            switch (Type) {
                case TYPE_SEARCH:
                    holder0 = new ViewHolder0();
                    convertView = LayoutInflater.from(context).inflate(R.layout.item_jilu_search, null);
                    holder0.didian0TV = (TextView) convertView.findViewById(R.id.search_TV);
                    convertView.setTag(holder0);
                    break;
                case TYPE_LOCATE:
                    holder1 = new ViewHolder1();
                    convertView = LayoutInflater.from(context).inflate(R.layout.item_jilu_locate, null);
                    holder1.didian1TV = (TextView) convertView.findViewById(R.id.locate_TV);
                    convertView.setTag(holder1);
                    break;

            }
        } else {
            switch (Type) {
                case TYPE_SEARCH:
                    holder0= (ViewHolder0) convertView.getTag();
                    break;
                case TYPE_LOCATE:
                    holder1= (ViewHolder1) convertView.getTag();
                    break;
            }
        }

        switch (Type){
            case TYPE_SEARCH:

                holder0.didian0TV.setText(jiluList.get(position).get("name"));
                break;
            case TYPE_LOCATE:
                holder1.didian1TV.setText(jiluList.get(position).get("name"));
                break;
        }
        return convertView;
    }

    public class ViewHolder0 {
        public TextView didian0TV;
    }

    public class ViewHolder1 {
        public TextView didian1TV;
    }
}
