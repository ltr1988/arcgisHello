package com.jiangyonghao.recycleview.nanshuibeidiao.Fragment;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.RealTimeItemAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ListViewForScrollView;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by user on 2016/9/18.
 */
public class RealWaterLevelFragment extends Fragment {
    private RealTimeItemAdapter adapter;
    private ArrayList<HashMap<String, String>> maps = null;
    private ListViewForScrollView listview_real;
    private LinearLayout linearlayout_realwaterlevelinfo;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_real_waterlevel, container, false);
        listview_real = (ListViewForScrollView) view.findViewById(R.id.listview_real);
        linearlayout_realwaterlevelinfo = (LinearLayout) view.findViewById(R.id.linearlayout_realwaterlevelinfo);
        maps = new ArrayList<>();
        adapter = new RealTimeItemAdapter(getActivity());
        for (int i = 0; i < 10; i++) {
            HashMap<String, String> hashMap = new HashMap<>();
            hashMap.put("name", "东干渠项目");
            hashMap.put("add", "朝阳");
            hashMap.put("total", "0.5");
            maps.add(hashMap);
        }
        adapter.addDatas(maps);
        listview_real.setAdapter(adapter);
        return view;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }
}
