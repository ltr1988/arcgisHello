package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.content.Intent;
import android.graphics.Color;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.BasicDetailActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.GuanXianActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.SheBeiInfo;

import java.io.Serializable;
import java.util.ArrayList;

/**
 * Created by user on 2016/8/23.
 */
public class BasicInfoFragmentItemAdapter extends BaseAdapter{
    private Context context;
    private LayoutInflater inflater=null;
    private ArrayList<SheBeiInfo> list=new ArrayList<>();
    public BasicInfoFragmentItemAdapter(Context context) {
        this.context=context;
        inflater= LayoutInflater.from(this.context);
    }
    public void addData(SheBeiInfo ls){
        list.add(ls);
    }
    public void addDatas(ArrayList ls){
        list.addAll(ls);
        this.notifyDataSetChanged();
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
        ViewHolder holder=null;
        if (convertView == null){
            holder = new ViewHolder();
            convertView = inflater.inflate(R.layout.item_for_fragment_basic, null);
            holder.liebiao = (TextView) convertView.findViewById(R.id.textView_item_basic_liebiao);
            holder.neirong = (TextView) convertView.findViewById(R.id.textView_item_basic_neirong);
            holder.into = (ImageView) convertView.findViewById(R.id.imageView_news_into);
            convertView.setTag(holder);
        }else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.liebiao.setText(list.get(position).getTitle());
        holder.neirong.setText(list.get(position).getNeirong());
        if (list.get(position).getInto()==null){
            holder.into.setVisibility(View.GONE);

        }else {
            holder.liebiao.setTextColor(Color.parseColor("#0099cc"));
            convertView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    Intent intent = new Intent(context, BasicDetailActivity.class);
                    intent.putExtra("标题",list.get(position).getTitle());
                    intent.putExtra("内容",list.get(position).getNeirong());
                    context.startActivity(intent);
                }
            });
        }
        return convertView;
    }
    public class ViewHolder {
        TextView liebiao,neirong;
        ImageView into;
    }
}
