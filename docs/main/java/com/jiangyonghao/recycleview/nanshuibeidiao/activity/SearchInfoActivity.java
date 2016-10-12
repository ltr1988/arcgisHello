package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.app.Activity;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AlertDialog;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.AdapterView;
import android.widget.EditText;
import android.widget.GridView;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.LuxianjiluAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.SearchGridViewAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@ContentView(R.layout.activity_search_info)
public class SearchInfoActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.search_return_com)
    private ImageButton title_com;
    @ViewInject(R.id.gridview_search_info)
    private GridView gridview_search_info;
    @ViewInject(R.id.Wzjilu_LV)
    private ListView jiluLV;
    @ViewInject(R.id.clear_jiluTV)
    private TextView footerTV;
    @ViewInject(R.id.search_zhongdianET)
    private EditText zhongDianET;
    @ViewInject(R.id.linearlayout_selectpoint)
    private LinearLayout linearlayout_selectpoint;
    @ViewInject(R.id.dituxuandianTV)
    private TextView dituxuandianTV;

    private SearchGridViewAdapter gridViewAdapter;
    private LuxianjiluAdapter adapter;
    //    footer
    private View footer;
    private List<HashMap<String, String>> lists;
    //    回传的数据
    String strName = "";
    private Intent intent;
    private HelperDb helper;
    //    要删除的数据的id
    private String nameID;
    private String islocate;
    private String lat = "43.23";
    private String lon = "120.23";//緯度,经度
    private HashMap<String, String> jiluMap;
    private final int DITUCODE = 3;
    private String mapAddr = "";
    String[] direction = {"北京站北京站", "北京站北京站", "北京站", "北京站", "北京站", "北京站", "北京站", "北京站", "北京站"};
    private boolean isqingqiu = false;
    int pos;

    //    private
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        Baseactivity.addactvity(this);
        initialUI();
        helper = new HelperDb(this);
//        Untils.setHidden(this);
        initAdapter();
        lists = initData();
        adapter.setList(lists);
        initCtrl();
    }

    private void initCtrl() {
        zhongDianET.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                if (!s.toString().equals("")) {
                    setqingqiu(s.toString());

                    jiluLV.setLongClickable(false);//网络请求屏蔽长监听
                } else {
                    lists = initData();
                    jiluLV.setLongClickable(true);
                }

                adapter.setList(lists);
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });

        jiluLV.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
//                if (isqingqiu) {
//                    strName = lists.get(position).get(Untils.searchform[3]);
//                    lon = lists.get(position).get(Untils.searchform[4]);
//                    lat = lists.get(position).get(Untils.searchform[4]);
//                } else {
                pos = position;
                strName = lists.get(position).get(Untils.searchform[3]);
                lon = lists.get(position).get(Untils.searchform[4]);
                lat = lists.get(position).get(Untils.searchform[5]);
//                }

                if (helper.getAllSearchlist().size() == 0) {
                    if ("1".equals(getIntent().getStringExtra("qizhong"))) {
                        if ("我的位置".equals(LuxianActivity.wodeWeiZhiET.getText().toString())) {
                            LuxianActivity.wodeWeiZhiET.setText("");
                        }
                    }
                    if ("0".equals(getIntent().getStringExtra("qizhong"))) {
                        if ("我的位置".equals(LuxianActivity.zhongdianET.getText().toString())) {
                            LuxianActivity.wodeWeiZhiET.setText("");
                        }
                    }

                    if (LuxianActivity.wodeWeiZhiET != null) {
                        if ("我的位置".equals(LuxianActivity.wodeWeiZhiET.getText().toString()) || "我的位置".equals(LuxianActivity.zhongdianET.getText().toString())) {
                            islocate = "1";
                            newMsg(islocate, lists.get(position));
                        } else {
                            islocate = "0";
                            newMsg(islocate, lists.get(position));
                        }
                    } else {
                        islocate = "0";
                        newMsg(islocate, lists.get(position));

                    }

                } else if (helper.getAllSearchlist().size() != 0) {
                    if ("1".equals(getIntent().getStringExtra("qizhong"))) {
                        if ("我的位置".equals(LuxianActivity.wodeWeiZhiET.getText().toString())) {
                            LuxianActivity.wodeWeiZhiET.setText("");
                        }
                    }
                    if ("0".equals(getIntent().getStringExtra("qizhong"))) {
                        if ("我的位置".equals(LuxianActivity.zhongdianET.getText().toString())) {
                            LuxianActivity.wodeWeiZhiET.setText("");
                        }
                    }
                    boolean index = false;
                    for (int i = 0; i < helper.getAllSearchlist().size(); i++) {
                        if (helper.getAllSearchlist().get(i).get(Untils.searchform[3]).equals(strName)) {
                            helper.updatecreattime(Untils.searchform[2], DataTools.getLocaleTime());
                            index = true;
                            break;
                        }
                    }
                    if (!index) {
                        if ("我的位置".equals(LuxianActivity.wodeWeiZhiET.getText().toString()) || "我的位置".equals(LuxianActivity.zhongdianET.getText().toString())) {
                            islocate = "1";
                            newMsg(islocate, lists.get(position));
                        } else {
                            islocate = "0";
                            newMsg(islocate, lists.get(position));
                        }
                    }
                }
                if (LuxianActivity.wodeWeiZhiET != null) {//从LuxianActivity跳转
                    if (Untils.isLuxian){
                        sendDataBack();
                    }else{
                        Intent intent = new Intent(SearchInfoActivity.this, ShowInfoMapActivity.class);
                        intent.putExtra("map", lists.get(position));
                        startActivity(intent);
                    }
                } else {//从主页直接跳转过来的
                    Intent intent = new Intent(SearchInfoActivity.this, ShowInfoMapActivity.class);
                    intent.putExtra("map", lists.get(position));
                    startActivity(intent);
                }
            }
        });
        jiluLV.setOnItemLongClickListener(new AdapterView.OnItemLongClickListener() {
            @Override
            public boolean onItemLongClick(AdapterView<?> parent, View view, int position, long id) {
                nameID = lists.get(position).get(Untils.searchform[0]);
                showDelete();
                return false;
            }
        });
        gridview_search_info.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent = new Intent(SearchInfoActivity.this, ShowInfoMapActivity.class);
                intent.putExtra("zhi", direction[position]);
                startActivity(intent);
            }
        });
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
                ToastShow.setShow(SearchInfoActivity.this, "删除成功");

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

    private void initAdapter() {
        adapter = new LuxianjiluAdapter(this);
        jiluLV.setAdapter(adapter);
//        jiluLV.addFooterView(footer);
    }

    private void initialUI() {
        if (Untils.SEARCHMODE) {
            gridview_search_info.setVisibility(View.VISIBLE);
            linearlayout_selectpoint.setVisibility(View.GONE);
        } else {
            gridview_search_info.setVisibility(View.GONE);
            linearlayout_selectpoint.setVisibility(View.VISIBLE);
        }

        gridViewAdapter = new SearchGridViewAdapter(this, direction);
        gridview_search_info.setAdapter(gridViewAdapter);
        footer = LayoutInflater.from(this).inflate(R.layout.footer, null);
        footerTV = (TextView) footer.findViewById(R.id.clear_jiluTV);
        jiluLV.addFooterView(footer);
        footerTV.setText("清空搜索历史");

        title_com.setOnClickListener(this);
        footer.setOnClickListener(this);
        footerTV.setOnClickListener(this);
        dituxuandianTV.setOnClickListener(this);
        if (!"".equals(getIntent().getStringExtra("yuan"))) {
            zhongDianET.setText(getIntent().getStringExtra("yuan"));
        }
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.search_return_com:
                if (!"".equals(mapAddr)) {
                    strName = mapAddr;
                }
//                strName = zhongDianET.getText().toString();
                sendDataBack();
                break;
            case R.id.footer:
            case R.id.clear_jiluTV:
                for (int i = 0; i < lists.size(); i++) {
                    helper.delete(lists.get(i).get(Untils.searchform[0]), Untils.search);
                }
                lists = helper.getAllSearchlist();
                adapter.setList(lists);
                break;
            case R.id.dituxuandianTV:
                Intent intent = new Intent(this, ShowInfoMapActivity.class);
                startActivityForResult(intent, DITUCODE);
                break;
        }
    }

    private void sendDataBack() {
        intent = new Intent();
        intent.putExtra("name", strName);
        intent.putExtra("map", lists.get(pos));
        // resultCode：结果码，表示数据是否回传成功
        setResult(Activity.RESULT_OK, intent);
        finish();
    }

    //  新添数据
    private void newMsg(String islocate, Map map) {
        jiluMap = new HashMap<>();
        jiluMap.put(Untils.searchform[0], Untils.setuuid());
        jiluMap.put(Untils.searchform[1], islocate);
        jiluMap.put(Untils.searchform[2], DataTools.getLocaleTime());
//        jiluMap.put(Untils.searchform[3], name);
//        jiluMap.put(Untils.searchform[4], lon);
//        jiluMap.put(Untils.searchform[5], lat);
        jiluMap.putAll(map);

//        创建新的数据
        helper.insertSingleData(jiluMap, Untils.search);
    }

    private List<HashMap<String, String>> initData() {
        isqingqiu = false;
        List<HashMap<String, String>> list = helper.getAllSearchlist();
        return list;
    }

    //    模拟网络数据
    private List<HashMap<String, String>> wangluo() {
        List<HashMap<String, String>> wanglist = new ArrayList<>();
//        HashMap<String, String> map = new HashMap<>();
//        map.put("name", "qq");
//        map.put("lon", "121.22");
//        map.put("lat", "23.11");
//        wanglist.add(map);
//        HashMap<String, String> map1 = new HashMap<>();
//        map1.put("name", "qq1");
//        map1.put("lon", "111.22");
//        map1.put("lat", "33.11");
//        wanglist.add(map1);
        return wanglist;
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == Activity.RESULT_OK) {

            mapAddr = data.getStringExtra("address");
            lat = String.valueOf(data.getDoubleExtra("lat", 0.0));
            Log.e("222", "lat----" + lat);
            lon = String.valueOf(data.getDoubleExtra("lon", 0.0));
            zhongDianET.setText(mapAddr);


        }
    }

    private void setqingqiu(String s) {
        isqingqiu = true;
        lists.clear();
        Map map = new HashMap();
        map.put("name", s);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.queryfacility, SharedprefrenceHelper.getInstance(SearchInfoActivity.this).gettoken(), SearchInfoActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("mohuchaxun", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        JSONObject jsonObject = json.getJSONObject(UploadUrl.backkey[2]);
                        JSONArray jrr = json.optJSONArray(UploadUrl.backkey[2]);
                        for (int i = 0; i < jrr.length(); i++) {
                            HashMap map = new HashMap();
                            JSONArray jsonObject2 = null;
                            jsonObject2 = (JSONArray) jrr.opt(i);
                            for (int j = 0; j < jsonObject2.length(); j++) {
                                map.put(((JSONObject) jsonObject2.opt(j)).optString("id").toLowerCase(), ((JSONObject) jsonObject2.opt(j)).optString("value"));
                            }
                            lists.add(map);
                        }
                    }
                    adapter.setList(lists);
//                    ToastShow.setShow(SearchInfoActivity.this, Untils.shibie(status));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onError(Throwable throwable, boolean b) {

            }

            @Override
            public void onCancelled(CancelledException e) {

            }

            @Override
            public void onFinished() {

            }
        });
    }

}

