package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.duanqu.qupai.project.Text;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;

/**
 * Created by user on 2016/8/25.
 */
public class SearchGridViewAdapter extends BaseAdapter{
    LayoutInflater inflater=null;
    String[] direction=null;//位置

    public SearchGridViewAdapter(Context context,String[] direction) {
        inflater=LayoutInflater.from(context);
        this.direction=direction;
    }

    @Override
    public int getCount() {
        return direction.length;
    }

    @Override
    public Object getItem(int position) {
        return direction[position];
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(int position, View convertView, ViewGroup parent) {
        View view=inflater.inflate(R.layout.item_search_gridview,null);
        TextView textView_direction= (TextView) view.findViewById(R.id.textview_item_gridview);
        textView_direction.setText(direction[position]);
        return view;
    }
}
