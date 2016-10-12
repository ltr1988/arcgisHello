package com.jiangyonghao.recycleview.nanshuibeidiao.common;

import android.content.Context;

import org.xutils.http.RequestParams;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by jiangyonghao on 2016/8/17.
 */
public interface Uploadim {
    public RequestParams setTianqi(String url);
    public RequestParams setLogin(Map<String, String> map, Context context);
    public RequestParams setUpload(Map<String, String> map, String action, String appkey, Context context);
    public RequestParams setFujianUpload(Map<String, String> map, Context context);
    public RequestParams setUpload(String id, Context context);
    public RequestParams setUpload(String id, String url ,Context context);
    public RequestParams setUpload2(Map<String,String> map,String action,String appkey, Context context);
    public RequestParams setwodetufa(Map<String,String> map,String action,String appkey, Context context);
     RequestParams ReqUpload(Map<String,String> map,String action,String method,String appkey, Context context);
}
