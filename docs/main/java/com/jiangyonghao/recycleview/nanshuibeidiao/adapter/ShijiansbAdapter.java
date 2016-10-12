package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.ShijiansbDetailActivity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/8/24 0024.
 */
public class ShijiansbAdapter extends BaseAdapter{
    private Context context;
    private List<HashMap<String,String>> dataList;
    private String type;
    public ShijiansbAdapter(Context context) {
        this.context = context;
        dataList=new ArrayList<>();
    }
    public void setData(List<HashMap<String,String>> dataList,String type){
        this.dataList=dataList;
        this.type=type;
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        return dataList.size();
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
        ViewHolder holder =null;
        if (convertView==null){
            holder=new ViewHolder();
            convertView= LayoutInflater.from(context).inflate(R.layout.item_sjsb_detail,null);
            holder.nameTV= (TextView) convertView.findViewById(R.id.detail_tv);
            holder.markTV= (TextView) convertView.findViewById(R.id.mark);
            convertView.setTag(holder);
        }else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.nameTV.setText(dataList.get(position).get("name"));
        if (dataList.get(position).get("name").equals(type)){
            holder.markTV.setVisibility(View.VISIBLE);
        }else {
            holder.markTV.setVisibility(View.GONE);
        }
        return convertView;
    }
    public class ViewHolder {
        public TextView nameTV;
        public TextView markTV;
    }
}
