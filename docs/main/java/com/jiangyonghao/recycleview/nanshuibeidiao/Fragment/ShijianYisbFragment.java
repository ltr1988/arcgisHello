package com.jiangyonghao.recycleview.nanshuibeidiao.Fragment;

import android.content.Intent;
import android.os.Bundle;
import android.os.Parcelable;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.LinearLayout;
import android.widget.ListView;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.ShijiansbActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.ShiJianYISBFragmentAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ShiJianWSB;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by Administrator on 2016/9/2 0002.
 */
public class ShijianYisbFragment extends Fragment {
    private View rootView;
    private ListView listView;
    private LinearLayout siwsb_total;
    private ShiJianYISBFragmentAdapter adapter;
    private ArrayList<ShiJianWSB> arrayList;
    private ArrayList<HashMap>maplist=new ArrayList<>();
    //    XXXXX
    private LoginDilog bar;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        bar = new LoginDilog(getActivity(), "正在请求");
        initView();
        initAdapter();
        setshangchuan();
        adapter.addDatas(arrayList);
//        siwsb_total.setVisibility(View.GONE);
        return rootView;
    }

    private void initAdapter() {
        adapter = new ShiJianYISBFragmentAdapter(getActivity());
        listView.setAdapter(adapter);
    }

    private void initView() {
        rootView = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_shijian_shangbao, null);
        listView = (ListView) rootView.findViewById(R.id.listview_fragment_shijian_shangbao);
        siwsb_total = (LinearLayout) rootView.findViewById(R.id.siwsb_total);
        arrayList=new ArrayList<>();
        listView.setOnItemClickListener(new AdapterView.OnItemClickListener() {
            @Override
            public void onItemClick(AdapterView<?> parent, View view, int position, long id) {
                Intent intent = new Intent(getContext(), ShijiansbActivity.class);
                intent.putExtra("zhi",maplist.get(position));
                intent.putExtra("upload","true");
                startActivity(intent);

            }
        });

    }

    private void setshangchuan() {
        bar.show();
        final Map map = new HashMap();
        HashMap map1 = new HashMap();
//        map.put("taskid", Untils.taskid);
//        map.put("state", "1");
//        map.put("source", UploadUrl.Android);
        map.put("incidentSource", "YDSB");

        map.put("pageNo", "1");
        map.put("pageSize", "10");
        map1.put("userName", SharedprefrenceHelper.getInstance(getActivity()).getUsername());
        Log.e("1212", "name---" + SharedprefrenceHelper.getInstance(getActivity()).getUsername());
// map.put("status", "");//所有状态
        map1.put("userScope", "0");//由用户创建的事件
        if (Untils.isWode) {
            map.put("ishistory", "Y");
        }
        map.put("data", map1);
        x.http().post(Upload.getInstance().setwodetufa(map, UploadUrl.tufashangbao, SharedprefrenceHelper.getInstance(getActivity()).gettoken(), getActivity()), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                map.clear();
                Log.e("1212", "YSB---" + s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
                        JSONObject object = json.getJSONObject(UploadUrl.backkey[2]);
                        String total = object.getString(UploadUrl.backkey[7]);
                        String pageNo = object.getString(UploadUrl.backkey[8]);
                        String pageSize = object.getString(UploadUrl.backkey[9]);
                        JSONArray rows = object.optJSONArray(UploadUrl.backkey[6]);

                        for (int i = 0; i < rows.length(); i++) {
                            JSONObject jsonObject2 = null;
                            jsonObject2 = rows.getJSONObject(i);
                            ShiJianWSB entity = null;
                            String id = jsonObject2.optString(UploadUrl.backkey[20]);
                            Log.e("1111","id---"+id);
                            String title = jsonObject2.optString(UploadUrl.backkey[10]);
                            Log.e("1111","title---"+title);
                            String occurTime = jsonObject2.optString(UploadUrl.backkey[13]);
                            String departName = jsonObject2.optString(UploadUrl.backkey[17]);
                            String creatorName = jsonObject2.optString(UploadUrl.backkey[18]);
                            String occurLocation = jsonObject2.optString(UploadUrl.backkey[19]);
                            entity = new ShiJianWSB(id, title, occurTime, occurLocation, creatorName, departName, status);
                            arrayList.add(entity);
                            Gson gson = new Gson();
                            maplist=gson.fromJson(rows.toString(),new TypeToken<ArrayList<HashMap<String,String>>>(){}.getType());
//                            Log.e("ddd",maplist.toString());
                        }

                        adapter.addDatas(arrayList);

                    }
                    ToastShow.setShow(getActivity(), Untils.shibie(status));
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
