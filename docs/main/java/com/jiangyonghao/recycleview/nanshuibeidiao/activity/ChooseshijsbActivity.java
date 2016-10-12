package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.ShijiansbNoUpAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ItemSingleChoice;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class ChooseshijsbActivity extends Baseactivity implements AdapterView.OnItemClickListener {

    //    头部
    private ImageButton return_comIBTN;
    private TextView title_comTV;
    private Button newCaseBtn;
    private ListView noUpload_LV;
    private ShijiansbNoUpAdapter adapter;
    private ArrayList<HashMap<String, String>> dataList;
    private Intent intent;//由哪个Activity跳转的意图
    private String isupload = "0";
    private HelperDb helper = new HelperDb(this);
    private Chronometer chor_com;
    private LinearLayout xianshi_chor;
    private String time;
    private String wellnum = null;
    private ArrayList<HashMap<String, String>> data = new ArrayList<>();

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chooseshijsb);
        Baseactivity.addactvity(this);
        intent = getIntent();
        initView();
        initAdapter();
        switch (intent.getStringExtra("Activity")) {
            case "emergencyform":
                chor_com.setVisibility(View.GONE);
                dataList = helper.getEmergencylist(Untils.tufaType, isupload);
                adapter.setData(dataList);

                break;
            case "dongganpaiqi":
                dataList = helper.getDatalist("0", Untils.dongganqupaiqiType, Untils.dongganpaiqi);
                adapter.setData(dataList);
                break;
            case "dongganpaikong":
                dataList = helper.getDatalist("0", Untils.dongganqupaikongType, Untils.dongganpaikong);
                adapter.setData(dataList);
                break;
            case "nanqupaikong":
                if (getIntent().getStringExtra("type").equals(Untils.nanganqupaikongjingshang)) {
                    dataList = helper.getDatalist("0", Untils.nanganqupaikongjingshang, Untils.nanqupaikongxia);
                } else {
                    dataList = helper.getDatalist("0", Untils.nanganqupaikongjingxia, Untils.nanqupaikongxia);
                }
                adapter.setData(dataList);
                break;
            case "dongganqufenshui":
                dataList = helper.getDatalist("0", Untils.dongganqufenshuiType, Untils.dongganqufen);
                adapter.setData(dataList);
                break;
            case "nanganpaiqi":
                if (getIntent().getStringExtra("type").equals(Untils.nanganqupaiqifashang)) {
                    dataList = helper.getDatalist("0", Untils.nanganqupaiqifashang, Untils.nanganpaiqishang);
                } else {
                    dataList = helper.getDatalist("0", Untils.nanganqupaiqifaxia, Untils.nanganpaiqishang);
                }
                adapter.setData(dataList);
                break;
            case "daning":
                if (getIntent().getStringExtra("type").equals(Untils.daningpaikongjing)) {
                    dataList = helper.getDatalist("0", Untils.daningpaikongjing, Untils.daning);
                } else {
                    dataList = helper.getDatalist("0", Untils.daningpaiqifajing, Untils.daning);
                }
                adapter.setData(dataList);
                break;
        }

        initCtrl();
    }

    @Override
    protected void onResume() {
        super.onResume();
        wellnum = getIntent().getStringExtra("wellnum");
        switch (intent.getStringExtra("Activity")) {
            case "emergencyform":
                chor_com.setVisibility(View.GONE);
                dataList = helper.getEmergencylist(Untils.tufaType, isupload);
                adapter.setData(dataList);
                break;
            case "dongganpaiqi":
                dataList = helper.getDatalistjing("0", Untils.dongganqupaiqiType, Untils.dongganpaiqi,wellnum);
                adapter.setData(dataList);
                break;
            case "dongganpaikong":
                dataList = helper.getDatalistjing("0", Untils.dongganqupaikongType, Untils.dongganpaikong,wellnum);
                adapter.setData(dataList);
                break;
            case "dongganqufenshui":
                dataList = helper.getDatalistjing("0", Untils.dongganqufenshuiType, Untils.dongganqufen,wellnum);
                adapter.setData(dataList);
                break;
            case "nanqupaikong":
                if (getIntent().getStringExtra("type").equals(Untils.nanganqupaikongjingshang)) {
                    dataList = helper.getDatalistjing("0", Untils.nanganqupaikongjingshang, Untils.nanqupaikongxia,wellnum);
                } else {
                    dataList = helper.getDatalistjing("0", Untils.nanganqupaikongjingxia, Untils.nanqupaikongxia,wellnum);
                }
                adapter.setData(dataList);
                break;
            case "nanganpaiqi":
                if (getIntent().getStringExtra("type").equals(Untils.nanganqupaiqifashang)) {
                    dataList = helper.getDatalistjing("0", Untils.nanganqupaiqifashang, Untils.nanganpaiqishang,wellnum);
                } else {
                    dataList = helper.getDatalistjing("0", Untils.nanganqupaiqifaxia, Untils.nanganpaiqishang,wellnum);
                }
                adapter.setData(dataList);
                break;
            case "daning":
                if (getIntent().getStringExtra("type").equals(Untils.daningpaikongjing)) {
                    dataList = helper.getDatalistjing("0", Untils.daningpaikongjing, Untils.daning,wellnum);
                } else {
                    dataList = helper.getDatalistjing("0", Untils.daningpaiqifajing, Untils.daning,wellnum);
                }
                adapter.setData(dataList);
                break;
        }
        if (dataList.size() == 0) {
            finish();
        }
    }

    private void initCtrl() {
        Untils.Finish(return_comIBTN, this);
        noUpload_LV.setOnItemClickListener(this);
        newCaseBtn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(ChooseshijsbActivity.this, ShijiansbActivity.class);
                intent.putExtra("isEcho", false);
                startActivity(intent);
            }
        });
        xianshi_chor.setVisibility(View.VISIBLE);
        intent = getIntent();
        time = intent.getStringExtra("time");
        if (time != null) {
            chor_com.setText(time);
            chor_com.setBase(Untils.setTime1(chor_com));
        }
        chor_com.start();
        chor_com.setOnChronometerTickListener(new Chronometer.OnChronometerTickListener() {
            @Override
            public void onChronometerTick(Chronometer chronometer) {
                Untils.time = chronometer.getText().toString();
                helper.updatestarttime(Untils.starttime, Untils.inspectionmessage[3], chronometer.getText().toString(), Untils.xunchaxinxi);
//                Log.e("onChronometerTick:1 " , chronometer.getText().toString());
            }
        });
    }

    private void initAdapter() {
        switch (intent.getStringExtra("Activity")) {
            case "emergencyform":
                adapter = new ShijiansbNoUpAdapter(this);
                noUpload_LV.setAdapter(adapter);
                break;
            case "dongganpaiqi":
            case "dongganpaikong":

                adapter = new ShijiansbNoUpAdapter(this, "dongganpaiqi");
                noUpload_LV.setAdapter(adapter);
                break;
            case "dongganqufenshui":
                adapter = new ShijiansbNoUpAdapter(this, "dongganqufenshui");
                noUpload_LV.setAdapter(adapter);
                break;
            case "nanqupaikong":
                adapter = new ShijiansbNoUpAdapter(this, "nanqupaikong");
                noUpload_LV.setAdapter(adapter);
                break;
            case "nanganpaiqi":
                adapter = new ShijiansbNoUpAdapter(this, "nanganpaiqi");
                noUpload_LV.setAdapter(adapter);
                break;
            case "nanganlinepipe":
                adapter = new ShijiansbNoUpAdapter(this, "nanganlinepipe");
                noUpload_LV.setAdapter(adapter);
                break;
            case "daning":
                adapter = new ShijiansbNoUpAdapter(this, "daning");
                noUpload_LV.setAdapter(adapter);
                break;
        }

    }

    private void initView() {
        chor_com = (Chronometer) findViewById(R.id.chor_com);
        xianshi_chor = (LinearLayout) findViewById(R.id.xianshi_chor);
        return_comIBTN = ((ImageButton) findViewById(R.id.return_com));
        title_comTV = (TextView) findViewById(R.id.title_com);
        newCaseBtn = (Button) findViewById(R.id.newCaseBtn);
        noUpload_LV = (ListView) findViewById(R.id.noUpload_LV);
        dataList = new ArrayList<>();
        switch (intent.getStringExtra("Activity")) {
            case "emergencyform":
                title_comTV.setText(getResources().getText(R.string.tufasjsb));
                break;
            case "dongganpaiqi":
                title_comTV.setText(getResources().getText(R.string.dongganqupaiqijing));
                newCaseBtn.setVisibility(View.GONE);
                break;
            case "dongganpaikong":
                title_comTV.setText(getResources().getText(R.string.dongganqupaikongjing));
                newCaseBtn.setVisibility(View.GONE);
                break;
            case "dongganqufenshui":
                title_comTV.setText(getResources().getText(R.string.dongganqufenshuikou));
                newCaseBtn.setVisibility(View.GONE);
                break;
            case "nanqupaikong":
                title_comTV.setText(getIntent().getStringExtra("type"));
                newCaseBtn.setVisibility(View.GONE);
                break;
            case "nanganpaiqi":
                title_comTV.setText(getIntent().getStringExtra("type"));
                newCaseBtn.setVisibility(View.GONE);
                break;
            case "nanganlinepipe":
                title_comTV.setText(getIntent().getStringExtra("type"));
                newCaseBtn.setVisibility(View.GONE);
                break;
            case "daning":
                title_comTV.setText(getIntent().getStringExtra("type"));
                newCaseBtn.setVisibility(View.GONE);
                break;
        }


    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        Intent intent1;
        String UID;
        switch (intent.getStringExtra("Activity")) {
            case "emergencyform":
                intent1 = new Intent(this, ShijiansbActivity.class);
                intent1.putExtra("isEcho", true);
                UID = dataList.get(position).get(Untils.emergencyform[0]);
                intent1.putExtra("uid", UID);
                intent1.putExtra("time", Untils.time);
                startActivity(intent1);
                break;
            case "dongganpaiqi":
                intent1 = new Intent(this, DongGanQupaiqiActivity.class);
                intent1.putExtra("isEcho", true);
                UID = dataList.get(position).get(Untils.dongganqupaiqi[1]);
                intent1.putExtra("uid", UID);
                intent1.putExtra("time", Untils.time);
                startActivity(intent1);
                break;
            case "dongganpaikong":
                intent1 = new Intent(this, DongGanQupaikongActivity.class);
                intent1.putExtra("isEcho", true);
                UID = dataList.get(position).get(Untils.dongganqupaikong[1]);
                intent1.putExtra("uid", UID);
                intent1.putExtra("time", Untils.time);
                startActivity(intent1);
                break;
            case "dongganqufenshui":
                intent1 = new Intent(this, DongGanQufenshuiActivity.class);
                intent1.putExtra("isEcho", true);
                UID = dataList.get(position).get(Untils.dongganqufenshui[1]);
                intent1.putExtra("uid", UID);
                intent1.putExtra("time", Untils.time);
                startActivity(intent1);
                break;
            case "nanqupaikong"://南干渠排空井上下
                intent1 = new Intent(this, SouthGQPaiKJActivity.class);
                intent1.putExtra("isEcho", true);
                UID = dataList.get(position).get(Untils.nanganqupaikong[1]);
                intent1.putExtra("uid", UID);
                intent1.putExtra("time", Untils.time);
                intent1.putExtra("type", title_comTV.getText().toString());
                startActivity(intent1);
                break;
            case "nanganpaiqi"://南干渠气阀上下
                intent1 = new Intent(this, SouthGQPaiQFActivity.class);
                intent1.putExtra("isEcho", true);
                UID = dataList.get(position).get(Untils.nanganqupaiqi[1]);
                intent1.putExtra("uid", UID);
                intent1.putExtra("time", Untils.time);
                intent1.putExtra("type", title_comTV.getText().toString());
                startActivity(intent1);
                break;
            case "nanganlinepipe"://南干渠管线
                intent1 = new Intent(this, SouthGQGuanXianActivity.class);
                intent1.putExtra("isEcho", true);
                UID = dataList.get(position).get(Untils.nanganquguanxian[1]);
                intent1.putExtra("uid", UID);
                intent1.putExtra("time", Untils.time);
                intent1.putExtra("type", title_comTV.getText().toString());
                startActivity(intent1);
                break;
            case "daning"://大宁排气阀井和大宁排空井
                intent1 = new Intent(this, DaNingDoublePaiActivity.class);
                intent1.putExtra("isEcho", true);
                UID = dataList.get(position).get(Untils.daningjing[1]);
                intent1.putExtra("uid", UID);
                intent1.putExtra("time", Untils.time);
                intent1.putExtra("type", title_comTV.getText().toString());
                startActivity(intent1);
                break;
        }

    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    @Override
    protected void onRestart() {
        switch (intent.getStringExtra("Activity")) {
            case "emergencyform":
                dataList = helper.getEmergencylist(Untils.tufaType, isupload);
                adapter.setData(dataList);
                break;
            case "dongganpaiqi":
                dataList = helper.getDatalist(isupload, Untils.dongganqupaiqiType, Untils.dongganpaiqi);
                adapter.setData(dataList);
                break;
            case "dongganpaikong":
                dataList = helper.getDatalist(isupload, Untils.dongganqupaikongType, Untils.dongganpaikong);
                adapter.setData(dataList);
                break;
            case "dongganqufenshui":
                dataList = helper.getDatalist(isupload, Untils.dongganqufenshuiType, Untils.dongganqufen);
                adapter.setData(dataList);
                break;
            case "nanqupaikong":
                if (getIntent().getStringExtra("type").equals(Untils.nanganqupaikongjingshang)) {
                    dataList = helper.getDatalist(isupload, Untils.nanganqupaikongjingshang, Untils.nanqupaikongxia);
                } else {
                    dataList = helper.getDatalist(isupload, Untils.nanganqupaikongjingxia, Untils.nanqupaikongxia);
                }
                adapter.setData(dataList);
                break;
            case "nanganpaiqi":
                if (getIntent().getStringExtra("type").equals(Untils.nanganqupaiqifashang)) {
                    dataList = helper.getDatalist(isupload, Untils.nanganqupaiqifashang, Untils.nanganpaiqishang);
                } else {
                    dataList = helper.getDatalist(isupload, Untils.nanganqupaiqifaxia, Untils.nanganpaiqishang);
                }
                adapter.setData(dataList);
                break;
            case "nanganlinepipe":
                dataList = helper.getDatalist(isupload, Untils.nanganquguanxianType, Untils.nanganlinepipe);
                adapter.setData(dataList);
                break;
            case "daning":
                if (getIntent().getStringExtra("type").equals(Untils.daningpaikongjing)) {
                    dataList = helper.getDatalist(isupload, Untils.daningpaikongjing, Untils.daning);
                } else {
                    dataList = helper.getDatalist(isupload, Untils.daningpaiqifajing, Untils.daning);
                }
                adapter.setData(dataList);
                break;
        }
        super.onRestart();
    }


}
