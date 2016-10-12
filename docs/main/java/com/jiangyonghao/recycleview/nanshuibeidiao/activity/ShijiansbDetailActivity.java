package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.app.Activity;
import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.ImageButton;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.ShijiansbAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ShijiansbDetailActivity extends Baseactivity implements AdapterView.OnItemClickListener {
    //    头部
    private ImageButton return_comIBTN;
    private TextView title_comTV;
    //    灰色小标
    private TextView sjDetail_TV;
    //    数据展示ListView
    private ListView sjDetail_LV;
    //    Intent
    private Intent intent;
    private List<HashMap<String, String>> datalist;
    private ShijiansbAdapter adapter;
    private String type;
    private String who;//判别由谁传过来的 再由谁传回去

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_shijiansb_detail);
        Baseactivity.addactvity(this);
        initView();
        datalist = initData();
        initAdapter();
        adapter.setData(datalist, type);
        initCtrl();
    }

    private void initCtrl() {
        sjDetail_LV.setOnItemClickListener(this);
        return_comIBTN.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                intent.putExtra("name", type);
                intent.putExtra("who",who);//判别是谁传回去的
                // resultCode：结果码，表示数据是否回传成功
                setResult(Activity.RESULT_OK, intent);
                finish();
            }
        });
    }

    private void initAdapter() {
        adapter = new ShijiansbAdapter(this);
        sjDetail_LV.setAdapter(adapter);
    }

    private List<HashMap<String, String>> initData() {
        intent = getIntent();
        List<HashMap<String, String>> data = new ArrayList<>();
        type = intent.getStringExtra("type");
        who=intent.getStringExtra("name");
        switch (who) {
            case "事件类型":
                data= Untils.addTufashijianInfo(Untils.shijianlxInfo);
                title_comTV.setText(getResources().getString(R.string.shijianlx));
                sjDetail_TV.setText(getResources().getString(R.string.xuanzeleixing));
                break;
            case "事件性质":
                data= Untils.addTufashijianInfo(Untils.shijianxzInfo);
                title_comTV.setText(getResources().getString(R.string.shijianxz));
                sjDetail_TV.setText(getResources().getString(R.string.xuanzexingzhi));
                break;
            case "等级初判":
                data= Untils.addTufashijianInfo(Untils.dengjicpInfo);
                title_comTV.setText(getResources().getString(R.string.dengjicp));
                sjDetail_TV.setText(getResources().getString(R.string.dengjichupan));
                break;
            case "初步原因":
                data= Untils.addTufashijianInfo(Untils.chubuyyInfo);
                title_comTV.setText(getResources().getString(R.string.chubuyy));
                sjDetail_TV.setText(getResources().getString(R.string.chubuyuanyin));
                break;
        }
        return data;
    }

    private void initView() {
        return_comIBTN = ((ImageButton) findViewById(R.id.return_com));
        title_comTV = (TextView) findViewById(R.id.title_com);
        sjDetail_TV = (TextView) findViewById(R.id.sjDetail_TV);
        sjDetail_LV = (ListView) findViewById(R.id.sjDetail_LV);

    }


    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        type = datalist.get(position).get("name");
        adapter.setData(datalist, type);
    }
}
