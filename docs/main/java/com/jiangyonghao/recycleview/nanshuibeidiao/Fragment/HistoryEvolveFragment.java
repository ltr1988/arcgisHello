package com.jiangyonghao.recycleview.nanshuibeidiao.Fragment;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListView;

import com.google.gson.Gson;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.BasicHistoryEvolveFragmentItemAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.BasicInfoFragmentItemAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.HistoryEvolveInfo;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.SheBeiInfo;
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
import java.util.List;
import java.util.Map;

/**
 * Created by user on 2016/9/6.
 */
public class HistoryEvolveFragment extends Fragment {
    private View rootView;
    private ListView listview_fragment_basic_xinxi;
    private BasicHistoryEvolveFragmentItemAdapter adapter = null;
    private LoginDilog bar;
    String id;

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        List<HistoryEvolveInfo.DataBean> list = new ArrayList<>();
        Bundle bundle = getArguments();
        id = bundle.getString("id");
        Log.e("1212", "id---" + id);
        initView();
        initAdapter();
        setshangchuan();
        adapter.setDatas(list);


        return rootView;
    }


    private void initAdapter() {
        adapter = new BasicHistoryEvolveFragmentItemAdapter(getActivity());
        listview_fragment_basic_xinxi.setAdapter(adapter);
    }

    private void initView() {
        bar = new LoginDilog(getActivity(), "正在请求");
        rootView = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_basic_xinxi, null);
        listview_fragment_basic_xinxi = (ListView) rootView.findViewById(R.id.listview_fragment_basic_xinxi);

    }

    private void setshangchuan() {
        bar.show();
        Map map = new HashMap();
        if (Untils.isWode) {
            map.put("ishistory", "Y");
        }
        map.put("id", id);
        x.http().post(Upload.getInstance().ReqUpload(map, UploadUrl.tufashangbao, "getProgressList", SharedprefrenceHelper.getInstance(getActivity()).gettoken(), getActivity()), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("1212", "HIS---" + s);
                JSONObject json = null;
                Gson gson = new Gson();
                HistoryEvolveInfo historyEvolveInfo = gson.fromJson(s, HistoryEvolveInfo.class);
                String status = historyEvolveInfo.getStatus();
                if ("100".equals(status)){
                    List<HistoryEvolveInfo.DataBean> data = historyEvolveInfo.getData();
                    adapter.setDatas(data);
                }

//                adapter.setDatas();

//                try {
//                    json = new JSONObject(s);
//                    String status = json.getString(UploadUrl.backkey[0]);
//                    if (status.equals("100")) {
//                        JSONArray data = json.optJSONArray(UploadUrl.backkey[2]);
//                        for (int i = 0; i < data.length(); i++) {
//                            JSONObject object = data.getJSONObject(i);
//                            String id = object.getString(UploadUrl.backkey[20]);
//                            String disposeBy = object.getString(UploadUrl.backkey[24]);
//                            String disposeDescription=object.getString(UploadUrl.backkey[28]);
//                            JSONArray fileList = object.getJSONArray(UploadUrl.backkey[25]);
//                            for (int j=0;j<fileList.length();j++){
//                                JSONObject object1 =fileList.getJSONObject(j);
//                                String fid = object1.getString(UploadUrl.backkey[20]);
//                                String name = object1.getString(UploadUrl.backkey[11]);
//                                String label = object1.getString(UploadUrl.backkey[23]);
//                                String url = object1.getString(UploadUrl.backkey[26]);
//                                String file_type = object1.getString(UploadUrl.backkey[27]);
//                            }
//
//                        }
//                    }
//                    ToastShow.setShow(getActivity(), Untils.shibie(status));
//                } catch (JSONException e) {
//                    e.printStackTrace();
//                }
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

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }
}
