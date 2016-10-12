package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.ReservoirAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ListViewForScrollView;

import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;

@ContentView(R.layout.activity_real_reservoir_info)
public class RealReservoirInfoActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.listview_reservoir_real)
    private ListViewForScrollView listview_reservoir_real;
    private ReservoirAdapter reservoirAdapter;
    private ArrayList<HashMap<String, String>> maps = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        initial();

    }

    private void initial() {
        title_com.setText(getIntent().getStringExtra("title"));
        reservoirAdapter = new ReservoirAdapter(this);
        maps = new ArrayList<>();
        //模拟假数据
        for (int i = 0; i < 10; i++) {
            HashMap<String, String> hashMap = new HashMap<>();
            hashMap.put("name", "sdasda目");
            hashMap.put("total", "32.5");
            maps.add(hashMap);
        }
        reservoirAdapter.addDatas(maps);
        listview_reservoir_real.setAdapter(reservoirAdapter);
        return_com.setOnClickListener(this);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()){
            case R.id.return_com:
                finish();
                break;
        }
    }
}
