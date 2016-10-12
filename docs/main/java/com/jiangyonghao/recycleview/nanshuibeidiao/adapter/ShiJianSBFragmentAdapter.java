package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.content.DialogInterface;
import android.graphics.Color;
import android.support.v7.app.AlertDialog;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.DetailInfo;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ShiJianWSB;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by user on 2016/8/17.
 */
public class ShiJianSBFragmentAdapter extends BaseAdapter {
    List<HashMap<String,String>> dlist = null;
    Context context = null;
    LayoutInflater inflater = null;
    ArrayList<ShiJianWSB> list = null;
    HelperDb helper;
    int pos;

    public ShiJianSBFragmentAdapter(Context context) {
        this.context = context;
        dlist = new ArrayList<>();
        helper=new HelperDb(context);
        inflater = LayoutInflater.from(context);
    }

    public ShiJianSBFragmentAdapter(Context context,ArrayList<ShiJianWSB> list) {
        this.context = context;
        list = new ArrayList<>();
        helper=new HelperDb(context);
        inflater = LayoutInflater.from(context);
    }

    public void setData(List<HashMap<String,String>> dlist) {
        this.dlist=dlist;
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        return dlist.size();
    }

    @Override
    public Object getItem(int position) {
        return dlist.get(position);
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
            convertView = inflater.inflate(R.layout.item_sjwsb, null);
            holder.upload_bt= (Button) convertView.findViewById(R.id.upload_bt);
            holder.delete_bt= (Button) convertView.findViewById(R.id.delete_bt);
            holder.title = (TextView) convertView.findViewById(R.id.item_name_tv);
            holder.time = (TextView) convertView.findViewById(R.id.item_time_tv);
            holder.address = (TextView) convertView.findViewById(R.id.item_locate_tv);
            holder.whoFind = (TextView) convertView.findViewById(R.id.item_position_tv);
            holder.shenhejieguo = (TextView) convertView.findViewById(R.id.textview_sjwsb_yishangbao);
            holder.shjg = (RelativeLayout) convertView.findViewById(R.id.relative_sjwsb_yishangbao);
            holder.relative_weishangbao_button = (RelativeLayout) convertView.findViewById(R.id.relative_weishangbao_button);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.title.setText(dlist.get(position).get(Untils.emergencyform[3])==null? "大宁PCCP 1号排气阀井积水":dlist.get(position).get(Untils.emergencyform[3]));
        holder.time.setText(dlist.get(position).get(Untils.emergencyform[1])==null? context.getResources().getString(R.string.weitianxie):dlist.get(position).get(Untils.emergencyform[1]));
        holder.address.setText(dlist.get(position).get(Untils.emergencyform[9])==null? "大宁管理处西堤巴里巴里":dlist.get(position).get(Untils.emergencyform[9]));
        holder.whoFind.setText(dlist.get(position).get(Untils.emergencyform[12])==null? "大宁管理处-工程科发现":dlist.get(position).get(Untils.emergencyform[12]));

        if ("0".equals(dlist.get(position).get(Untils.emergencyform[16]))) {//0未上报
            holder.shjg.setVisibility(View.GONE);
        }
//        else {
//            holder.relative_weishangbao_button.setVisibility(View.GONE);
//            holder.shenhejieguo.setText(dlist.get(position).get(""));
//            if (dlist.get(position).get("").equals("审核通过")){
//                holder.shenhejieguo.setTextColor(Color.parseColor("#ff6666"));
//            }else if (dlist.get(position).get("").equals("未审核")){
//                holder.shenhejieguo.setTextColor(Color.parseColor("#ff6633"));
//            }else if (dlist.get(position).get("").equals("审核未通过")){
//                holder.shenhejieguo.setTextColor(Color.parseColor("#FF4081"));
//            }
//
//        }
//        holder.relative_weishangbao_button.setVisibility(View.GONE);
//        holder.shenhejieguo.setText(list.get(position).getShenhejieguo());
//        if (list.get(position).getShenhejieguo().equals("审核通过")){
//            holder.shenhejieguo.setTextColor(Color.parseColor("#ff6666"));
//        }else if (list.get(position).getShenhejieguo().equals("未审核")){
//            holder.shenhejieguo.setTextColor(Color.parseColor("#ff6633"));
//        }else if (list.get(position).getShenhejieguo().equals("审核未通过")){
//            holder.shenhejieguo.setTextColor(Color.parseColor("#FF4081"));
//        }
        holder.upload_bt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                upload();
            }
        });
        holder.delete_bt.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                pos=position;
           showDialog();
            }
        });
        return convertView;
    }

    //弹出对话框
    private void showDialog() {
        AlertDialog.Builder builder = new AlertDialog.Builder(context);
        builder.setTitle("提示");
        View rootView = LayoutInflater.from(context).inflate(R.layout.tishi, null);
        TextView msgTV = (TextView) rootView.findViewById(R.id.tuichu_TV);
        msgTV.setText("确定删除该记录？");
        builder.setView(rootView);
        builder.setPositiveButton("是", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();

                delete();
            }
        });
        builder.setNegativeButton("否", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        AlertDialog dialog = builder.create();
        dialog.show();

    }
    private void delete() {
        helper.delete(dlist.get(pos).get(Untils.emergencyform[0]),Untils.tufashijian);
        dlist.remove(pos);
        notifyDataSetChanged();

    }

    private void upload(){
    ToastShow.setShow(context,"接口还在协调中");
}
    public class ViewHolder {
        TextView title, time, address, whoFind, shenhejieguo;
        RelativeLayout shjg,relative_weishangbao_button;
        Button upload_bt,delete_bt;
    }
}
