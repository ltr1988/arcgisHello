package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Chronometer;
import android.widget.EditText;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.handmark.pulltorefresh.library.ILoadingLayout;
import com.handmark.pulltorefresh.library.PullToRefreshBase;
import com.handmark.pulltorefresh.library.PullToRefreshListView;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.NetDataAdapter1;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.NetDatalistEntity;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

@ContentView(R.layout.activity_history_xun_cha)
public class HistoryXunChaActivity extends Baseactivity {
    @ViewInject(R.id.checkyema)
    private EditText yema;
    @ViewInject(R.id.checkgeshu)
    private EditText geshu;
    @ViewInject(R.id.checkstartTV)
    private TextView start;
    @ViewInject(R.id.checkendTV)
    private TextView end;
    private HashMap map = new HashMap();
    private HashMap mapdata = new HashMap();
    //    头部
    @ViewInject(R.id.return_com)
    private ImageButton return_comIBTN;
    @ViewInject(R.id.title_com)
    private TextView title_comTV;
    //    展示列表
    @ViewInject(R.id.pull_LV)
    private PullToRefreshListView pull_LV;
    private ILoadingLayout mLoadingLayoutProxy;
    //helper
    private HelperDb helperDb;
    //    adapter
    private NetDataAdapter1 netAdapter;
    private String code;
    private List<NetDatalistEntity> datas;
    private LoginDilog bar;
    @ViewInject(R.id.chor_com)
    private Chronometer chor_com;
    @ViewInject(R.id.xianshi_chor)
    private LinearLayout xianshi_chor;
    private String time;
    private Boolean isRefreshing = false;
    private int yemashu = 1;
    @ViewInject(R.id.check)
    private TextView check;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
//        Untils.initContent();
        check.setVisibility(View.VISIBLE);
        yema.setText("1");
        geshu.setText("10");
        start.setText(DataTools.tian());
        end.setText(DataTools.tian());
        setedit(yema, "pageNo");
        setedit(geshu, "pageSize");
        setText(start, "startTime");
        setText(end, "endTime");
        datas = new ArrayList<>();
        bar = new LoginDilog(this, "正在请求...");
        initView();
        initAdapter();
        setshangchuan();
        setData();
        initCtrl();

    }

    private void setedit(EditText ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                map.put(key, s.toString());
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    private void setText(TextView ed, final String key) {
        ed.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {

            }

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                mapdata.put(key, s.toString().trim());
            }

            @Override
            public void afterTextChanged(Editable s) {

            }
        });
    }

    @Event(R.id.checkstartTV)
    private void setOnclickstart(View view) {
        Untils.setShiJian(this, 1, start);
    }

    @Event(R.id.checkendTV)
    private void setOnclickend(View view) {
        Untils.setShiJian(this, 1, end);
    }

    @Event(R.id.check)
    private void setOnclickCheck(View view) {
        if (yema.getText().toString().equals("")) {
            yema.setError("不准为空");
        } else if (geshu.getText().toString().equals("")) {
            geshu.setError("不准为空");
        } else {
            setshangchuan();
        }
    }

    private void initAdapter() {
        netAdapter = new NetDataAdapter1(this);
        pull_LV.setAdapter(netAdapter);
        xianshi_chor.setVisibility(View.GONE);
        time = getIntent().getStringExtra("time");
        if (time != null) {
            chor_com.setText(time);
            chor_com.setBase(Untils.setTime1(chor_com));
        }
        chor_com.start();
        chor_com.setOnChronometerTickListener(new Chronometer.OnChronometerTickListener() {
            @Override
            public void onChronometerTick(Chronometer chronometer) {
                Untils.time = chronometer.getText().toString();
                helperDb.updatestarttime(Untils.starttime, Untils.inspectionmessage[3], chronometer.getText().toString(), Untils.xunchaxinxi);
//                Log.e("onChronometerTick:1 " , chronometer.getText().toString());
            }
        });
    }


    private void initView() {
        helperDb = new HelperDb(this);
        title_comTV.setText((Untils.myWork[3]));
    }


    private void initCtrl() {
        Untils.Finish(return_comIBTN, this);
        //    listview详情页的监听
        pull_LV.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent = new Intent(HistoryXunChaActivity.this, XunChaActivity.class);
                Untils.taskid = datas.get(position-1).getId();
                startActivity(intent);
            }
        });
    }

    private void setData() {
//      下拉刷新设置
        pull_LV.setMode(PullToRefreshBase.Mode.BOTH);
        mLoadingLayoutProxy = pull_LV.getLoadingLayoutProxy();
        mLoadingLayoutProxy.setReleaseLabel("放开我");
        mLoadingLayoutProxy.setRefreshingLabel("正在为您拼命加载...");
        mLoadingLayoutProxy.setPullLabel("别扯了");
        pull_LV.setOnRefreshListener(new PullToRefreshBase.OnRefreshListener2<ListView>() {
            @Override
            public void onPullDownToRefresh(PullToRefreshBase<ListView> refreshView) {
//                if (!isRefreshing) {
//                    isRefreshing = true;
                loadNew(true);
//                } else {
//                    pull_LV.onRefreshComplete();
//                }

            }

            @Override
            public void onPullUpToRefresh(PullToRefreshBase<ListView> refreshView) {
                loadMore();
//                pull_LV.onRefreshComplete();
            }
        });

    }

    //上啦加载
    private void loadMore() {
        Log.e("111", "1234");
        yemashu = Integer.parseInt(yema.getText().toString());
        yema.setText((yemashu + 1) + "");
        setshangchuan();
//        pull_LV.onRefreshComplete();
    }

    //  下拉刷新
    private void loadNew(Boolean isRefresh) {
        Log.e("111", "111");
//        netAdapter.setData(datas);
        yemashu = Integer.parseInt(yema.getText().toString());
        yema.setText(yemashu + "");
        setshangchuan();
//        pull_LV.onRefreshComplete();
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

    private void setshangchuan() {
        bar.show();
        mapdata.put("userName", SharedprefrenceHelper.getInstance(HistoryXunChaActivity.this).getUsername());
        mapdata.put("startTime", start.getText().toString().trim());
        mapdata.put("endTime", end.getText().toString().trim());
        map.put("pageNo", yema.getText().toString());
        map.put("pageSize", geshu.getText().toString());
        map.put("data", mapdata);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.queryhistory, SharedprefrenceHelper.getInstance(HistoryXunChaActivity.this).gettoken(), HistoryXunChaActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("历史记录表接口", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        String status = json.getString(UploadUrl.backkey[0]);
                        JSONObject jsonObject = json.getJSONObject(UploadUrl.backkey[2]);
                        JSONArray jrr = jsonObject.optJSONArray(UploadUrl.backkey[6]);
                        if (jrr.length() == 0) {
                            ToastShow.setShow(HistoryXunChaActivity.this, "已经全部加载");
                            yemashu = Integer.parseInt(yema.getText().toString());
                            if (yemashu > 1) {
                                yema.setText((yemashu - 1) + "");
                            }
                            return;
                        }
                        datas.clear();
                        for (int i = 0; i < jrr.length(); i++) {
                            JSONArray jsonObject2 = null;
                            jsonObject2 = (JSONArray) jrr.opt(i);
                            String id = null, name = null, startime = null, endtime = null;

                            for (int j = 0; j < jsonObject2.length(); j++) {
                                if (((JSONObject) jsonObject2.opt(j)).optString("id").equals("id")) {
                                    id = ((JSONObject) jsonObject2.opt(j)).optString("value");
                                } else if (((JSONObject) jsonObject2.opt(j)).optString("id").equals("name")) {
                                    name = ((JSONObject) jsonObject2.opt(j)).optString("value");
                                } else if (((JSONObject) jsonObject2.opt(j)).optString("id").equals("startTime")) {
                                    startime = ((JSONObject) jsonObject2.opt(j)).optString("value");
                                } else if (((JSONObject) jsonObject2.opt(j)).optString("id").equals("endTime")) {
                                    endtime = ((JSONObject) jsonObject2.opt(j)).optString("value");
                                }

                            }
                            NetDatalistEntity entity = new NetDatalistEntity(id, name, startime, endtime);
                            datas.add(entity);
                        }
                        netAdapter.setData(datas);
                    }
                    ToastShow.setShow(HistoryXunChaActivity.this, Untils.shibie(status));
                    pull_LV.onRefreshComplete();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onError(Throwable throwable, boolean b) {
                pull_LV.onRefreshComplete();
            }

            @Override
            public void onCancelled(CancelledException e) {
                pull_LV.onRefreshComplete();
            }

            @Override
            public void onFinished() {
                bar.dismiss();
                pull_LV.onRefreshComplete();
            }
        });
    }
}
