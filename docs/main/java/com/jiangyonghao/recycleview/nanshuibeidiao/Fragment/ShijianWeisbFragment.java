package com.jiangyonghao.recycleview.nanshuibeidiao.Fragment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.ShiJianSBFragmentAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ShiJianWSB;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by Administrator on 2016/9/2 0002.
 */
public class ShijianWeisbFragment extends Fragment {
    private View rootView;
    private ListView listView;
    private TextView count_TV;
    private ShiJianSBFragmentAdapter adapter;
    private List<HashMap<String,String>> arrayList;
    private HelperDb helper;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        initView();
        initAdapter();
        initData();
        adapter.setData(arrayList);
        count_TV.setText("共" + arrayList.size()+ "件");
        return rootView;
    }

    private void initData() {
        arrayList=new ArrayList<>();
//        arrayList=helper.getDatalist3("0", Untils.tufaType,Untils.tufashijian);
        arrayList = helper.getEmergencylist(Untils.tufaType, "0");
    }

    private void initAdapter() {
        adapter = new ShiJianSBFragmentAdapter(getActivity());
        listView.setAdapter(adapter);
    }

    private void initView() {
        rootView = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_shijian_shangbao, null);
        listView = (ListView) rootView.findViewById(R.id.listview_fragment_shijian_shangbao);
        count_TV = (TextView) rootView.findViewById(R.id.count_TV);
        helper=new HelperDb(getActivity());

//        for (int i = 0; i < 20; i++) {
////            arrayList.add(new ShiJianWSB("大宁PCCP 1号排气阀井积水", "2016-7-20 8:39:23", "大宁管理处西堤（西北角）靠近距京石高速500米", "大宁管理处-工程科发现", "", false));
//        }



    }
}
