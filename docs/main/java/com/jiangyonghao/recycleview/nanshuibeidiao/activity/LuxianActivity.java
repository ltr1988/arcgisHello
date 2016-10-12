package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.graphics.Color;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.LuxianjiluAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Mstore;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LuxianActivity extends Baseactivity implements AdapterView.OnItemClickListener, View.OnClickListener {

    //    头部 搜索
    private ImageButton return_comIBTN;
    private TextView title_comTV;
    private LinearLayout title_line;
    private TextView searchTV;
    //交换
    private ImageView exchangeIV;
    //    我的位置 终点
    public static EditText wodeWeiZhiET;
    public static EditText zhongdianET;
    private TextView wodewzTV;
    private ListView jiluLV;
    private LuxianjiluAdapter adapter;
    //    footer
    private View footer;
    private TextView footerTV;
    //    header
    private View header;
    private TextView headerTV;
    private HashMap<String, String> jiluMap;
    private String ID;
    private String starttime;
    private HelperDb helper;
    private final int QIDIAN = 1;
    private final int ZHONGDIAN = 2;
    private String islocate = "0";
    private List<HashMap<String, String>> lists;
    //    要删除的数据的id
    private String nameID;
    private Intent intent;
    private String dad, sad;
    private double dlon, dlat, slon, slat;
    String yuanqidian;
    String yuanzhongdian;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_luxian);
        starttime = DataTools.getLocaleTime();
        helper = new HelperDb(this);
        Baseactivity.addactvity(this);
        initView();
        initCtrl();
        initAdapter();
        lists = initData();
        if (lists != null) {
            adapter.setList(lists);
        }


    }

    private List<HashMap<String, String>> initData() {
        List<HashMap<String, String>> list = helper.getAllSearchlist();
        return list;
    }

    private void initAdapter() {
        adapter = new LuxianjiluAdapter(this);
        jiluLV.setAdapter(adapter);
    }

    private void initCtrl() {
        intent = getIntent();
        sad = intent.getStringExtra("me");
        slon = intent.getDoubleExtra("melon", 116.0);
        slat = intent.getDoubleExtra("melat", 40.0);
        Untils.Finish(return_comIBTN, LuxianActivity.this);
//        我的位置和目的地交换
        exchangeIV.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Log.e("1111", "before---" + slon + "----" + slat);
                if (!"".equals(zhongdianET.getText().toString())) {
                    double exlon = dlon;
                    double exlat = dlat;
                    dlon = slon;
                    dlat = slat;
                    slon = exlon;
                    slat = exlat;
                    String wdwzstr = wodeWeiZhiET.getText().toString();
                    String zhongdianstr = zhongdianET.getText().toString();
                    Log.e("1111", "after---" + slon + "----" + slat);
                    wodeWeiZhiET.setText(zhongdianstr);
                    zhongdianET.setText(wdwzstr);
                } else {
                    ToastShow.setShow(LuxianActivity.this, "目的地不能为空！");
                }

            }
        });
        zhongdianET.setOnClickListener(this);
        zhongdianET.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (hasFocus) {
                    Intent intent = new Intent(LuxianActivity.this, SearchInfoActivity.class);
                    Untils.SEARCHMODE = false;
                    yuanzhongdian = zhongdianET.getText().toString();
                    intent.putExtra("qizhong", "0");
                    if (!"".equals(yuanzhongdian)) {
                        intent.putExtra("yuan", yuanzhongdian);
                    }
                    startActivityForResult(intent, ZHONGDIAN);
                }
            }
        });
        wodeWeiZhiET.setOnClickListener(this);
        wodeWeiZhiET.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View v, boolean hasFocus) {
                if (hasFocus) {
                    Intent intent = new Intent(LuxianActivity.this, SearchInfoActivity.class);
                    Untils.SEARCHMODE = false;
                    yuanqidian = wodeWeiZhiET.getText().toString();
                    intent.putExtra("qizhong", "1");
//                    wodeWeiZhiET.setText("");
                    if (!yuanqidian.equals(getResources().getString(R.string.wodeweizhi))) {
                        intent.putExtra("yuan", yuanqidian);
                    }
                    startActivityForResult(intent, QIDIAN);
                }
            }
        });

        searchTV.setOnClickListener(this);
        jiluLV.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, int position, long id) {
                Log.e("1111", "nameID----" + lists.get(position - 1).get(Untils.searchform[0]));
                nameID = lists.get(position - 1).get(Untils.searchform[0]);
                showDelete();
                return false;
            }
        });
        jiluLV.setOnItemClickListener(this);
        footerTV.setOnClickListener(this);
    }

    private void initView() {
        return_comIBTN = ((ImageButton) findViewById(R.id.return_com));
        title_comTV = (TextView) findViewById(R.id.title_com);
        title_line = (LinearLayout) findViewById(R.id.title_line);
        title_comTV.setText(getResources().getString(R.string.luxian));
        searchTV = (TextView) findViewById(R.id.search_roadTV);
        exchangeIV = (ImageView) findViewById(R.id.exchange_iv);
        zhongdianET = (EditText) findViewById(R.id.zhongdianET);
        wodeWeiZhiET = (EditText) findViewById(R.id.wodewzET);
        wodewzTV = (TextView) findViewById(R.id.wodewzTV);
        jiluLV = (ListView) findViewById(R.id.Wzjilu_LV);
        title_comTV.setTextColor(Color.WHITE);
        title_line.setVisibility(View.GONE);
        searchTV.setVisibility(View.VISIBLE);
        return_comIBTN.setImageResource(R.mipmap.icon_more2);
        return_comIBTN.setBackground(null);
        footer = LayoutInflater.from(this).inflate(R.layout.footer, null);
        header = LayoutInflater.from(this).inflate(R.layout.header, null);
        headerTV = (TextView) header.findViewById(R.id.wodewzTV);
        footerTV = (TextView) footer.findViewById(R.id.clear_jiluTV);
        jiluLV.addFooterView(footer);
        jiluLV.addHeaderView(header);


    }

    //删除单条记录对话框
    private void showDelete() {

        AlertDialog.Builder builder = new AlertDialog.Builder(this);
        builder.setTitle("提示");
        View rootView = getLayoutInflater().inflate(R.layout.tishi, null);
        TextView msgTV = (TextView) rootView.findViewById(R.id.tuichu_TV);
        msgTV.setText("确定删除该条记录？");
        builder.setView(rootView);
        builder.setPositiveButton("是", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                helper.delete(nameID, Untils.search);
                lists = initData();
                adapter.setList(lists);
                dialog.dismiss();
                ToastShow.setShow(LuxianActivity.this, "删除成功");

            }
        });
        builder.setNegativeButton("否", new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        });
        AlertDialog dialog = builder.create();
        dialog.show();


    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        if (position==0){
//            定位
        }else {
            if (wodeWeiZhiET.hasFocus()) {
                wodeWeiZhiET.setText(lists.get(position-1).get(Untils.searchform[3]));
                slat=Double.parseDouble(lists.get(position-1).get(Untils.searchform[4]));
                slon=Double.parseDouble(lists.get(position-1).get(Untils.searchform[5]));
            }
            if (zhongdianET.hasFocus()) {
                zhongdianET.setText(lists.get(position-1).get(Untils.searchform[3]));
                dlat=Double.parseDouble(lists.get(position-1).get(Untils.searchform[4]));
                dlon=Double.parseDouble(lists.get(position-1).get(Untils.searchform[5]));

            }
        }

    }

    //  新添数据
    private void newMsg(String islocate, String name) {
        jiluMap = new HashMap<>();
        jiluMap.put(Untils.searchform[0], Untils.setuuid());
        jiluMap.put(Untils.searchform[1], islocate);
        jiluMap.put(Untils.searchform[2], starttime);
        jiluMap.put(Untils.searchform[3], name);
        jiluMap.put(Untils.searchform[4], "");
        jiluMap.put(Untils.searchform[5], "");
        jiluMap.put(Untils.searchform[6], "");
        jiluMap.put(Untils.searchform[7], "");
        jiluMap.put(Untils.searchform[8], "");
        jiluMap.put(Untils.searchform[9], "");
        jiluMap.put(Untils.searchform[10], "");
        jiluMap.put(Untils.searchform[11], "");
        jiluMap.put(Untils.searchform[12], "");
        jiluMap.put(Untils.searchform[13], "");
        jiluMap.put(Untils.searchform[14], "");
//        创建新的数据
        helper.insertSingleData(jiluMap, Untils.search);
    }


    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.wodewzET:
                Intent intent = new Intent(LuxianActivity.this, SearchInfoActivity.class);
                Untils.SEARCHMODE = false;
                yuanqidian = wodeWeiZhiET.getText().toString();
//                wodeWeiZhiET.setText("");
                intent.putExtra("qizhong", "1");
                if (!yuanqidian.equals(getResources().getString(R.string.wodeweizhi))) {
                    intent.putExtra("yuan", yuanqidian);
                }
                startActivityForResult(intent, QIDIAN);

                break;
            case R.id.zhongdianET:
                Intent intent1 = new Intent(LuxianActivity.this, SearchInfoActivity.class);
                Untils.SEARCHMODE = false;
                yuanzhongdian = zhongdianET.getText().toString();
                intent1.putExtra("qizhong", "0");
                if (!"".equals(yuanzhongdian)) {
                    intent1.putExtra("yuan", yuanzhongdian);
                }
                startActivityForResult(intent1, ZHONGDIAN);
                break;
            case R.id.search_roadTV:
                if ("".equals(zhongdianET.getText().toString()) || "".equals(wodeWeiZhiET.getText().toString())) {
                    ToastShow.setShow(LuxianActivity.this, "起点或者终点不能为空");
//                    searchTV.setClickable(false);
                } else {
//                    searchTV.setClickable(true);
//                    if (!"".equals(zhongdianET.getText().toString())) {
//
//                        if ("我的位置".equals(wodeWeiZhiET.getText().toString())) {
//                            islocate = "1";
//                            if (helper.getjilu(zhongdianET.getText().toString(), islocate).get(Untils.searchform[3]) == null) {
//                                newMsg(islocate, zhongdianET.getText().toString());
//                            }
//
//                        } else {
//                            islocate = "0";
//                            if (helper.getjilu(wodeWeiZhiET.getText().toString(), islocate).get(Untils.searchform[3]) == null) {
//
//                                newMsg(islocate, wodeWeiZhiET.getText().toString());
//                            }
//                            if (helper.getjilu(zhongdianET.getText().toString(), islocate).get(Untils.searchform[3]) == null) {
//                                newMsg(islocate, zhongdianET.getText().toString());
//
//                            }
//                        }
//                        helper.updatetime(zhongdianET.getText().toString(), Untils.searchform[2], DataTools.getLocaleTime(), Untils.search);
                        lists = initData();
                        adapter.setList(lists);
//                    }
                    Mstore mstore = new Mstore();
                    mstore.setSad(wodeWeiZhiET.getText().toString());
                    mstore.setSlon(slon + "");
                    mstore.setSlat(slat + "");
                    mstore.setDad(zhongdianET.getText().toString());
                    mstore.setDlat(dlat + "");
                    mstore.setDlon(dlon + "");
                    Untils.ditu(LuxianActivity.this, mstore);
                }
                break;
            case R.id.clear_jiluTV:
                for (int i = 0; i < lists.size(); i++) {
                    helper.delete(lists.get(i).get(Untils.searchform[0]), Untils.search);
                }
                lists = helper.getAllSearchlist();
                adapter.setList(lists);
//                jiluLV.setVisibility(View.GONE);
//                footer.setVisibility(View.GONE);
                break;
        }
    }

    @Override
    protected void onRestart() {
        super.onRestart();
        lists = initData();
        adapter.setList(lists);

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        if (requestCode == ZHONGDIAN) {
            if (resultCode == Activity.RESULT_OK) {
//                String yuanzhongdian = zhongdianET.getText().toString();
                String zhongdian = data.getStringExtra("name");
                Map map= (Map) data.getSerializableExtra("map");
                if ("".equals(zhongdian)) {
                    if (!"".equals(yuanzhongdian)) {
                        zhongdianET.setText(yuanzhongdian);
                    }
                } else {
                    zhongdianET.setText(zhongdian);
                }
                dlat =Double.parseDouble((String)map.get(Untils.searchform[4]));
                dlon = Double.parseDouble((String)map.get(Untils.searchform[5]));

            }
        } else if (requestCode == QIDIAN) {
            if (resultCode == Activity.RESULT_OK) {

                String qidian = data.getStringExtra("name");
                Map map= (Map) data.getSerializableExtra("map");

                slat = Double.parseDouble((String)map.get(Untils.searchform[4]));
                slon = Double.parseDouble((String)map.get(Untils.searchform[5]));
                if (!"".equals(qidian)) {
                    wodeWeiZhiET.setText(qidian);
                } else {
                    if (!getResources().getString(R.string.wodeweizhi).equals(yuanqidian)) {
                        wodeWeiZhiET.setText(yuanqidian);
                    } else {
                        wodeWeiZhiET.setText(getResources().getString(R.string.wodeweizhi));
                    }

                }

            }
        }
    }
}
