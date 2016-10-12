package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.content.SharedPreferences;
import android.graphics.Color;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.RealRainFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.RealTimeActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by user on 2016/9/18.
 */
public class RealTimeAdapter extends BaseAdapter {
    LayoutInflater inflater = null;
    Context context = null;
    RealTimeActivity activity = null;
    ArrayList<HashMap<String, String>> mapList = null;
//15962136865  13451992972
    public RealTimeAdapter(Context context) {
        this.context = context;
        inflater = LayoutInflater.from(context);
        mapList = new ArrayList<>();
        activity = (RealTimeActivity) context;
    }

    public void addDatas(ArrayList<HashMap<String, String>> mp) {
        mapList.addAll(mp);
    }

    @Override
    public int getCount() {
        return mapList.size();
    }

    @Override
    public Object getItem(int position) {
        return mapList.get(position);
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
            convertView = inflater.inflate(R.layout.item_for_xuncha, null);
            holder.textView_biaoti = (TextView) convertView.findViewById(R.id.textView_xuncha_neirong);
            holder.textView_time = (TextView) convertView.findViewById(R.id.textView_xuncha_hint);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.textView_biaoti.setTextAppearance(context, R.style.textstyleJiaChu);
        holder.textView_biaoti.setText(mapList.get(position).get(Untils.RealTimeTitle));//设置单行标题内容
        holder.textView_time.setText(mapList.get(position).get(Untils.RealTimeTime));//设置单行时间
        convertView.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (mapList.get(position).get(Untils.RealTimeTitle).equals(Untils.RealTimeInfo[0])) {//实时雨情
                    activity.showRealtimeList(false);//隐藏掉第一页的内容
                    activity.showTileTwoButton(true);//显示title的两个图标
                    activity.showOrHideFra(true, 1);//显示第一个fra
                    activity.showTile(Untils.RealTimeInfo[0]);

                    //存
                    //记事本
                    SharedPreferences titleTyleSharedPre = activity.getSharedPreferences("titleTyle", Context.MODE_PRIVATE);
                    //事物编辑器
                    SharedPreferences.Editor edit = titleTyleSharedPre.edit();
                    edit.putString("titleTyle",Untils.RealTimeInfo[0]);
                    edit.commit();


                }else if (mapList.get(position).get(Untils.RealTimeTitle).equals(Untils.RealTimeInfo[1])){//实时水位
                    activity.showRealtimeList(false);//隐藏掉第一页的内容
                    activity.showTileTwoButton(true);//显示title的两个图标
                    activity.showOrHideFra(true, 2);//显示第二个fra
                    activity.showTile(Untils.RealTimeInfo[1]);

                    //存
                    //记事本
                    SharedPreferences titleTyleSharedPre = activity.getSharedPreferences("titleTyle", Context.MODE_PRIVATE);
                    //事物编辑器
                    SharedPreferences.Editor edit = titleTyleSharedPre.edit();
                    edit.putString("titleTyle",Untils.RealTimeInfo[1]);
                    edit.commit();
                }else if (mapList.get(position).get(Untils.RealTimeTitle).equals(Untils.RealTimeInfo[2])){//水库水情
                    activity.showRealtimeList(false);//隐藏掉第一页的内容
                    activity.showTileTwoButton(true);//显示title的两个图标
                    activity.showOrHideFra(true, 3);//显示第二个fra
                    activity.showTile(Untils.RealTimeInfo[2]);

                    //存
                    //记事本
                    SharedPreferences titleTyleSharedPre = activity.getSharedPreferences("titleTyle", Context.MODE_PRIVATE);
                    //事物编辑器
                    SharedPreferences.Editor edit = titleTyleSharedPre.edit();
                    edit.putString("titleTyle",Untils.RealTimeInfo[2]);
                    edit.commit();
                }
            }
        });
        return convertView;
    }

    public class ViewHolder {
        TextView textView_biaoti, textView_time;
    }
}
