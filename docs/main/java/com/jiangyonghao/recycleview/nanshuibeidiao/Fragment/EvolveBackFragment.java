package com.jiangyonghao.recycleview.nanshuibeidiao.Fragment;

import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.JinzhanDialog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.LoginDilog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ShijianDialog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.ToastShow;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.x;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by user on 2016/9/6.
 */
public class EvolveBackFragment extends Fragment implements View.OnClickListener {
    private View rootView;
    private Button update;
    private Button cancel;
    private LoginDilog bar;
    private boolean isinsert;
    private TextView textview_evolveback_jinzhanmiaoshu;
    String id;
    String disposeBy;
    String disposeDescription;
    private JinzhanDialog dialog;


    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        Bundle bundle = getArguments();
        id = bundle.getString("id");
        disposeBy=bundle.getString("disposeBy");
        initView();
        initCtrl();
        return rootView;
    }

    private void initCtrl() {
        textview_evolveback_jinzhanmiaoshu.setOnClickListener(this);
        update.setOnClickListener(this);
        cancel.setOnClickListener(this);
    }

    private void initView() {
        bar = new LoginDilog(getActivity(), "正在请求");
        rootView = LayoutInflater.from(getActivity()).inflate(R.layout.fragment_basic_evolveback, null);
        update = (Button) rootView.findViewById(R.id.upload_btn_com);
        cancel = (Button) rootView.findViewById(R.id.save_btn_com);
        textview_evolveback_jinzhanmiaoshu= (TextView) rootView.findViewById(R.id.textview_evolveback_jinzhanmiaoshu);
        update.setText("提交");
        cancel.setText("取消");
    }

    private void setshangchuan() {
        bar.show();
        Map map = new HashMap();
        if (!isinsert) {
            map.put("operate", "insert");
        }
        map.put("userName", SharedprefrenceHelper.getInstance(getActivity()).getUsername());
        map.put("state", "1");
        map.put("source", UploadUrl.Android);
        map.put("incidentSource", "YDSB");

        map.put("incidentId", id);
        map.put("disposeBy", disposeBy);
        map.put("disposeDescription", disposeDescription);


        x.http().post(Upload.getInstance().ReqUpload(map, UploadUrl.tufashangbao, "addProgress", SharedprefrenceHelper.getInstance(getActivity()).gettoken(), getActivity()), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("1212", "SBJZ---" + s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
//                    if (status.equals("100")) {
//                        helper.update(ID, Untils.emergencyform[16], "1", Untils.tufashijian);
//                        for (int i = 0; i < helper.getAttachmentformlist(ID).size(); i++) {
//                            fujianshangchuan(helper.getAttachmentformlist(ID).get(i));
//                        }
//                        finish();
//                    }
                    ToastShow.setShow(getActivity(), Untils.shibie(status));
                    JinzhanDialog.text="";
                    textview_evolveback_jinzhanmiaoshu.setText("未填写");
                    textview_evolveback_jinzhanmiaoshu.setTextColor(Color.GRAY);
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
                isinsert = true;
            }
        });
    }

    @Override
    public void onDestroyView() {
        super.onDestroyView();
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.upload_btn_com:
                setshangchuan();
                break;
            case R.id.save_btn_com:
             getActivity().finish();
                break;
            case R.id.textview_evolveback_jinzhanmiaoshu:
                dialog = new JinzhanDialog(getActivity(), "进展描述", new JinzhanDialog.PriorityListener() {
                    @Override
                    public void refreshPriorityUI(String string, String neirong) {
                        disposeDescription=neirong;
                        if (!"".equals(disposeDescription)){
                            textview_evolveback_jinzhanmiaoshu.setText("已填写");
                            textview_evolveback_jinzhanmiaoshu.setTextColor(Color.BLACK);
                        }else {
                            textview_evolveback_jinzhanmiaoshu.setText("未填写");
                            textview_evolveback_jinzhanmiaoshu.setTextColor(Color.GRAY);
                        }
                    }
                });
                dialog.setCanceledOnTouchOutside(false);
                dialog.show();

                break;
        }
    }

    @Override
    public void onResume() {
        super.onResume();

    }
}
