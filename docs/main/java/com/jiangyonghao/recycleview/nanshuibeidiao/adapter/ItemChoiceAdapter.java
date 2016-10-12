package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.CompoundButton;
import android.widget.Switch;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.DaNingDoublePaiActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ItemChoice;

import java.util.ArrayList;

/**
 * Created by user on 2016/8/29.
 */
public class ItemChoiceAdapter extends BaseAdapter {
    private ArrayList<ItemChoice> list = new ArrayList<>();
    private LayoutInflater inflater = null;
    private Context c;
    private String id;

    public ItemChoiceAdapter(Context context, String id) {
        c = context;
        this.id = id;
        inflater = LayoutInflater.from(c);
    }
    public ItemChoiceAdapter(Context context) {
        c = context;
        inflater = LayoutInflater.from(c);
    }

    public void addDatas(ArrayList<ItemChoice> leftRights) {
        list=leftRights;
        notifyDataSetChanged();
    }

    public void addDatas(ItemChoice leftRights) {
        list.add(leftRights);
    }

    public void clearDatas() {
        list.clear();
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
    public View getView(int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        if (convertView == null) {
            holder = new ViewHolder();
            convertView = inflater.inflate(R.layout.item_for_double, null);
            holder.titile = (TextView) convertView.findViewById(R.id.textview_item_double_title);
            holder.neirongzuo = (TextView) convertView.findViewById(R.id.textview_item_double_neirongzuo);
            holder.neirongyou = (TextView) convertView.findViewById(R.id.textview_item_double_neirongyou);
            holder.choicezuo = (Switch) convertView.findViewById(R.id.swtich_item_double_choicezuo);
            holder.choiceyou = (Switch) convertView.findViewById(R.id.swtich_item_double_choiceyou);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        if(id!=null) {
            Untils.setSwitchClick(c, holder.choicezuo, id, returnSQLDatas(list.get(position).getTitle(), list.get(position).getNeirongzuo()), Untils.daning);
            Untils.setSwitchClick(c, holder.choiceyou, id, returnSQLDatas(list.get(position).getTitle(), list.get(position).getNeirongyou()), Untils.daning);
        }
        if(Untils.isWode){
            holder.choicezuo.setEnabled(false);
            holder.choiceyou.setEnabled(false);
        }
        holder.titile.setText(list.get(position).getTitle());
        holder.neirongzuo.setText(list.get(position).getNeirongzuo());
        holder.neirongyou.setText(list.get(position).getNeirongyou());
        holder.choicezuo.setChecked(list.get(position).isChoicezuo());
        holder.choiceyou.setChecked(list.get(position).isChoiceyou());
        holder.choicezuo.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Untils.setHidden(c);
            }
        });
        holder.choiceyou.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Untils.setHidden(c);
            }
        });

        return convertView;
    }

    public class ViewHolder {
        TextView titile, neirongzuo, neirongyou;
        Switch choicezuo, choiceyou;
    }

    private String returnSQLDatas(String title, String con) {
        String r = "";
        switch (title) {
            case "手阀情况":
                if (con.equals("左手阀")) {
                    r = Untils.daningjing[7];
                } else {
                    r = Untils.daningjing[8];
                }
                break;
            case "空气阀情况":
                //    0"taskid", 1"id", 2"type", 3"createtime", 4"starttime", 5"exedate", 6"wellnum", 7"handgateleft"
                // , 8"handgateright", 9"airgateleft", 10"airgateright",11 "pondleft", 12"pondright", 13"warmleft",
                // 14"warmright", 15"negativeleft", 16"negativelright", 17"environment", 18"weather", 19"gatetemperatureleft"
                // , 20"gatetemperatureright", 21"welltemperatureleft", 22"welltemperatureright", 23"remark", 24"isupload"};
                if (con.equals("左手阀")) {
                    r = Untils.daningjing[9];
                } else {
                    r = Untils.daningjing[10];
                }
                break;
            case "积水情况":
                if (con.equals("左手阀")) {
                    r = Untils.daningjing[11];
                } else {
                    r = Untils.daningjing[12];
                }
                break;
            case "保温设施":
                if (con.equals("左手阀")) {
                    r = Untils.daningjing[13];
                } else {
                    r = Untils.daningjing[14];
                }
                break;
            case "阴极保护":
                if (con.equals("左手阀")) {
                    r = Untils.daningjing[15];
                } else {
                    r = Untils.daningjing[16];
                }
                break;
        }
        return r;
    }
}
