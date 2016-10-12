package com.jiangyonghao.recycleview.nanshuibeidiao.Fragment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.BasicInfoFragmentItemAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.SheBeiInfo;

import java.util.ArrayList;

/**
 * Created by user on 2016/8/22.
 */
public class BasicInfoXinXiFragment extends Fragment{

    private ListView listview_fragment_basic_xinxi;
    private BasicInfoFragmentItemAdapter basicInfoFragmentItemAdapter = null;
    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View v=inflater.inflate(R.layout.fragment_basic_xinxi,container,false);


        listview_fragment_basic_xinxi = (ListView) v.findViewById(R.id.listview_fragment_basic_xinxi);
        ArrayList<SheBeiInfo> list = new ArrayList<>();
        for (int i = 0; i < 30; i++) {
            list.add(new SheBeiInfo("电动蝶阀", "DN1200", null));
        }
        basicInfoFragmentItemAdapter = new BasicInfoFragmentItemAdapter(getActivity());
        basicInfoFragmentItemAdapter.addDatas(list);
        listview_fragment_basic_xinxi.setAdapter(basicInfoFragmentItemAdapter);


        return v;
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }
}
