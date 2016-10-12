package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.Chronometer;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.NetDataAdapter;
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
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class XunChaNetlistActivity extends Baseactivity implements AdapterView.OnItemClickListener {

    //    头部
    private ImageButton return_comIBTN;
    private TextView title_comTV;
    private ListView netLV;
    private NetDataAdapter adapter;
    private List<NetDatalistEntity> datas;
    private Button newCaseBtn;
    private HelperDb helperDb;
    private String nameType;
    private String code;
    private Chronometer chor_com;
    private LinearLayout xianshi_chor;
    private String time;
    private LoginDilog bar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_chooseshijsb);
        nameType = getIntent().getStringExtra("nameType");
        code = getIntent().getStringExtra("code");
        datas = new ArrayList<>();
//        datas.add(new NetDatalistEntity("1"));
        bar = new LoginDilog(this, "正在请求...");
        initView();
        initAdapter();
        setshangchuan(code);
        adapter.setData(datas);
        intCtrl();
    }

    @Override
    protected void onResume() {
        super.onResume();
        setshangchuan(code);
    }

    private void initAdapter() {
        switch (nameType) {
            case "dongganpaiqi":
            case "dongganpaikong":
            case "nanqupaikong":
            case "nanganpaiqi":
            case "daning":
                adapter = new NetDataAdapter(this, "干渠");
                break;
            case "dongganqufenshui":
                adapter = new NetDataAdapter(this, "分水口");
                break;

        }
//        adapter = new NetDataAdapter(this);
        netLV.setAdapter(adapter);
        xianshi_chor.setVisibility(View.VISIBLE);
        if (Untils.isWode) {
            xianshi_chor.setVisibility(View.GONE);
        }
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

    private void intCtrl() {
        Untils.Finish(return_comIBTN, this);
        netLV.setOnItemClickListener(this);
    }

    private void initView() {
        return_comIBTN = ((ImageButton) findViewById(R.id.return_com));
        title_comTV = (TextView) findViewById(R.id.title_com);
        newCaseBtn = (Button) findViewById(R.id.newCaseBtn);
        newCaseBtn.setVisibility(View.GONE);
        netLV = (ListView) findViewById(R.id.noUpload_LV);
        helperDb = new HelperDb(this);
        chor_com = (Chronometer) findViewById(R.id.chor_com);
        xianshi_chor = (LinearLayout) findViewById(R.id.xianshi_chor);
        switch (nameType) {
            case "dongganpaiqi":
            case "dongganpaikong":
            case "nanqupaikong":
                title_comTV.setText(R.string.jinghao);
                break;
            case "nanganpaiqi":
                title_comTV.setText(R.string.jinghao);
                break;
            case "dongganqufenshui":
                title_comTV.setText(R.string.fenshuikouhao);
                break;
            case "daning":
                title_comTV.setText(R.string.jinghao);
                break;
        }
    }

    @Override
    public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
        String wellnum = datas.get(position).getNumber();
        Intent intent = null;
        HashMap<String, String> singledata = null;
        switch (nameType) {
            case "dongganpaiqi":
                intent = new Intent(this, DongGanQupaiqiActivity.class);
                if (!Untils.isWode) {
                    singledata = helperDb.getSingledata2(wellnum, Untils.dongganqupaiqiType, Untils.dongganpaiqi);
                    if (singledata.size() > 0) {
                        intent.putExtra("uid", singledata.get("id"));
                        intent.putExtra("isEcho", true);
                    }
                }
//  以下内容保留
//                if (Untils.isWode) {
//                    intent = new Intent(this, DongGanQupaiqiActivity.class);
//                } else {
//                    singledata = helperDb.getSingledata2(wellnum, Untils.dongganqupaiqiType, Untils.dongganpaiqi);
//                    if (singledata.size() > 0) {
//                        intent = new Intent(this, ChooseshijsbActivity.class);
//                    } else {
//                        intent = new Intent(this, DongGanQupaiqiActivity.class);
//                    }
//                }

                break;
            case "dongganpaikong":
                intent = new Intent(this, DongGanQupaikongActivity.class);
                if (!Untils.isWode) {
                    singledata = helperDb.getSingledata2(wellnum, Untils.dongganqupaikongType, Untils.dongganpaikong);
                    if (singledata.size() > 0) {
                        intent.putExtra("uid", singledata.get("id"));
                        intent.putExtra("isEcho", true);
                    }
                }
//  以下内容保留
//                if (Untils.isWode) {
//                    intent = new Intent(this, DongGanQupaikongActivity.class);
//                } else {
//                    singledata = helperDb.getSingledata2(wellnum, Untils.dongganqupaikongType, Untils.dongganpaikong);
//                    if (singledata.size() > 0) {
//                        intent = new Intent(this, ChooseshijsbActivity.class);
//                    } else {
//                        intent = new Intent(this, DongGanQupaikongActivity.class);
//                    }
//                }
                break;
            case "dongganqufenshui":
                intent = new Intent(this, DongGanQufenshuiActivity.class);
//                if (Untils.isWode) {
//                } else {
                if (!Untils.isWode) {
                    singledata = helperDb.getSingledata2(wellnum, Untils.dongganqufenshuiType, Untils.dongganqufen);
                    if (singledata.size() > 0) {
                        intent.putExtra("uid", singledata.get("id"));
                        intent.putExtra("isEcho", true);
//                        intent = new Intent(this, ChooseshijsbActivity.class);
//                    }
//                    else {
//                        intent = new Intent(this, DongGanQufenshuiActivity.class);
//                    }
                    }
                }
                break;

            case "nanqupaikong":
                String type = getIntent().getStringExtra("type");
                switch (type) {
                    case "南干渠排空井上段":
//  以下内容保留
                        intent = new Intent(this, SouthGQPaiKJActivity.class);
                        if (!Untils.isWode) {
                            singledata = helperDb.getSingledata2(wellnum, Untils.nanganqupaikongjingshang, Untils.nanqupaikongxia);
                            if (singledata.size() > 0) {
                                intent.putExtra("uid", singledata.get("id"));
                                intent.putExtra("isEcho", true);
                            }
                        }
//                        if (Untils.isWode) {
//                            intent = new Intent(this, SouthGQPaiKJActivity.class);
//                        } else {
//                            singledata = helperDb.getSingledata2(wellnum, Untils.nanganqupaikongjingshang, Untils.nanqupaikongxia);
//                            if (singledata.size() > 0) {
//                                intent = new Intent(this, ChooseshijsbActivity.class);
//                            } else {
//                                intent = new Intent(this, SouthGQPaiKJActivity.class);
//                            }
//                        }
                        intent.putExtra("type", Untils.nanganqupaikongjingshang);
                        break;
                    case "南干渠排空井下段":
                        intent = new Intent(this, SouthGQPaiKJActivity.class);
                        if (!Untils.isWode) {
                            singledata = helperDb.getSingledata2(wellnum, Untils.nanganqupaikongjingxia, Untils.nanqupaikongxia);
                            if (singledata.size() > 0) {
                                intent.putExtra("uid", singledata.get("id"));
                                intent.putExtra("isEcho", true);
                            }
                        }
// 以下内容保留
//                        if (Untils.isWode) {
//                            intent = new Intent(this, SouthGQPaiKJActivity.class);
//                        } else {
//                            singledata = helperDb.getSingledata2(wellnum, Untils.nanganqupaikongjingxia, Untils.nanqupaikongxia);
//                            if (singledata.size() > 0) {
//                                intent = new Intent(this, ChooseshijsbActivity.class);
//                            } else {
//                                intent = new Intent(this, SouthGQPaiKJActivity.class);
//                            }
//                        }
                        intent.putExtra("type", Untils.nanganqupaikongjingxia);
                        break;
                }

                break;
            case "nanganpaiqi":
                String type1 = getIntent().getStringExtra("type");
                switch (type1) {
                    case "南干渠排气阀上段":
                        intent = new Intent(this, SouthGQPaiQFActivity.class);
                        if (!Untils.isWode) {
                            singledata = helperDb.getSingledata2(wellnum, Untils.nanganqupaiqifashang, Untils.nanganpaiqishang);
                            if (singledata.size() > 0) {
                                intent.putExtra("uid", singledata.get("id"));
                                intent.putExtra("isEcho", true);
                            }
                        }
//                        if (Untils.isWode) {
//                            intent = new Intent(this, SouthGQPaiQFActivity.class);
//                        } else {
//                            singledata = helperDb.getSingledata2(wellnum, Untils.nanganqupaiqifashang, Untils.nanganpaiqishang);
//                            if (singledata.size() > 0) {
//                                intent = new Intent(this, ChooseshijsbActivity.class);
//                            } else {
//                                intent = new Intent(this, SouthGQPaiQFActivity.class);
//                            }
//                        }
                        intent.putExtra("type", Untils.nanganqupaiqifashang);
                        break;
                    case "南干渠排气阀下段":
                        intent = new Intent(this, SouthGQPaiQFActivity.class);
                        if (!Untils.isWode) {
                            singledata = helperDb.getSingledata2(wellnum, Untils.nanganqupaiqifaxia, Untils.nanganpaiqishang);
                            if (singledata.size() > 0) {
                                intent.putExtra("uid", singledata.get("id"));
                                intent.putExtra("isEcho", true);
                            }
                        }
//                        if (Untils.isWode) {
//                            intent = new Intent(this, SouthGQPaiQFActivity.class);
//                        } else {
//                            singledata = helperDb.getSingledata2(wellnum, Untils.nanganqupaiqifaxia, Untils.nanganpaiqishang);
//                            if (singledata.size() > 0) {
//                                intent = new Intent(this, ChooseshijsbActivity.class);
//                            } else {
//                                intent = new Intent(this, SouthGQPaiQFActivity.class);
//                            }
//                        }
                        intent.putExtra("type", Untils.nanganqupaiqifaxia);
                        break;
                }

                break;
            case "daning":
                String type2 = getIntent().getStringExtra("type");

                switch (type2) {
                    case "大宁排气阀井":
                        intent = new Intent(this, DaNingDoublePaiActivity.class);
                        if (!Untils.isWode) {
                            singledata = helperDb.getSingledata2(wellnum, Untils.daningpaiqifajing, Untils.daning);
                            if (singledata.size() > 0) {
                                intent.putExtra("uid", singledata.get("id"));
                                intent.putExtra("isEcho", true);
                            }
                        }

//                        if (Untils.isWode) {
//                            intent = new Intent(this, DaNingDoublePaiActivity.class);
//                        } else {
//                            singledata = helperDb.getSingledata2(wellnum, Untils.daningpaiqifajing, Untils.daning);
//                            if (singledata.size() > 0) {
//                                intent = new Intent(this, ChooseshijsbActivity.class);
//                            } else {
//                                intent = new Intent(this, DaNingDoublePaiActivity.class);
//                            }
//                        }
                        intent.putExtra("type", Untils.daningpaiqifajing);

                        break;
                    case "大宁排空井":
                        intent = new Intent(this, DaNingDoublePaiActivity.class);
                        if (!Untils.isWode) {
                            singledata = helperDb.getSingledata2(wellnum, Untils.daningpaikongjing, Untils.daning);
                            if (singledata.size() > 0) {
                                intent.putExtra("uid", singledata.get("id"));
                                intent.putExtra("isEcho", true);
                            }
                        }
//                        if (Untils.isWode) {
//                            intent = new Intent(this, DaNingDoublePaiActivity.class);
//                        } else {
//                            singledata = helperDb.getSingledata2(wellnum, Untils.daningpaikongjing, Untils.daning);
//                            if (singledata.size() > 0) {
//                                intent = new Intent(this, ChooseshijsbActivity.class);
//                            } else {
//                                intent = new Intent(this, DaNingDoublePaiActivity.class);
//                            }
//                        }
                        intent.putExtra("type", Untils.daningpaikongjing);
                        break;
                }

                break;

        }
        intent.putExtra("time", Untils.time);
        intent.putExtra("Activity", nameType);
        intent.putExtra("wellnum", wellnum);
        startActivity(intent);
    }

    private void setshangchuan(String code) {
        bar.show();
        Map map = new HashMap();
        map.put("code", code);
        map.put("taskid", Untils.taskid);
        if (Untils.isWode) {
            map.put("ishistory", "Y");
        }
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.jinghaoliebiaoaction, SharedprefrenceHelper.getInstance(XunChaNetlistActivity.this).gettoken(), XunChaNetlistActivity.this), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("井号列表接口", s);
                JSONObject json = null;
                datas.clear();
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
//                        String status = json.getString(UploadUrl.backkey[0]);
                        JSONArray jrr = json.optJSONArray(UploadUrl.backkey[2]);
                        for (int i = 0; i < jrr.length(); i++) {
                            JSONObject jsonObject2 = null;
                            jsonObject2 = jrr.getJSONObject(i);
                            String value = jsonObject2.optString(UploadUrl.backkey[5]);
                            NetDatalistEntity entity = new NetDatalistEntity(value);
                            datas.add(entity);
                        }
                        adapter.setData(datas);
                    }
                    ToastShow.setShow(XunChaNetlistActivity.this, Untils.shibie(status));
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
                bar.dismiss();
            }
        });
    }
}
