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
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ItemSingleChoice;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/8/30 0030.
 */
public class DongItemChoiceAdapter extends BaseAdapter {
    private List<ItemSingleChoice> list = new ArrayList<>();
    private Context context;
    private String ID;
    private String table;
    HelperDb helperDb;

    public DongItemChoiceAdapter(Context context, String ID, String table) {
        this.context = context;
        helperDb = new HelperDb(context);
        this.ID = ID;
        this.table = table;

    }

    public void addDatas(List<ItemSingleChoice> list) {
        this.list = list;
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
            convertView = LayoutInflater.from(context).inflate(R.layout.item_for_single, null);
            holder.neirong = (TextView) convertView.findViewById(R.id.tv_item_single);
            holder.choice = (Switch) convertView.findViewById(R.id.switch_item_single);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.neirong.setText(list.get(position).getNeirong());

        if (Untils.isWode) {
            holder.choice.setEnabled(false);
        }
        Untils.setSwitchClick(context, holder.choice, ID, list.get(position).getKey(), table);

        holder.choice.setChecked(list.get(position).isChoice());
        holder.choice.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Untils.setHidden(context);
            }
        });
        return convertView;

    }

    public class ViewHolder {
        TextView neirong;
        Switch choice;
    }
}
