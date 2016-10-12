package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.BaseAdapter;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.BasicDetailAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.ItemBaseDetileFooterAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.DetailInfo;

import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;

import static com.jiangyonghao.recycleview.nanshuibeidiao.R.layout.basedetilefooter;

@ContentView(R.layout.activity_basic_detail)
public class BasicDetailActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.title_back)
    private TextView title_back;
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.listview_detail)
    private ListView listview_detail;
    private BasicDetailAdapter basicDetailAdapter;
    private ItemBaseDetileFooterAdapter footerAdapter;
    //    footer
    private View footer;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        Baseactivity.addactvity(this);
        initialUI();

    }

    private void initialUI() {
        return_com.setOnClickListener(this);
        title_back.setText("详情界面");
        title_back.setVisibility(View.VISIBLE);
        title_com.setVisibility(View.GONE);
        ArrayList<DetailInfo> infos = new ArrayList<>();
        for (int i = 0; i < 30; i++) {
            infos.add(new DetailInfo("设备名称", "电动蝶阀"));
        }
        basicDetailAdapter = new BasicDetailAdapter(this);
        basicDetailAdapter.addDatas(infos);
        footer = LayoutInflater.from(this).inflate(R.layout.basedetilefooter, null);
        GridView gridView = (GridView)footer. findViewById(R.id.gridview_basedetile_footer);
        int[] pic = {R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher, R.mipmap.ic_launcher};
        footerAdapter = new ItemBaseDetileFooterAdapter(this, pic);
        gridView.setAdapter(footerAdapter);
        footerAdapter.notifyDataSetChanged();
        listview_detail.addFooterView(footer);
        listview_detail.setAdapter(basicDetailAdapter);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.return_com:
                finish();
                break;
        }
    }
}
