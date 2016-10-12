package com.jiangyonghao.recycleview.nanshuibeidiao.common;

import android.content.Context;
import android.os.Environment;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import org.json.JSONObject;
import org.xutils.http.RequestParams;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by jiangyonghao on 2016/8/17.
 */
public class Upload implements Uploadim{
    private static class SingletonHolder {// 构造线程安全的单例
        public final static Upload instance = new Upload();
    }

    public final static Upload getInstance() {
        return SingletonHolder.instance;
    }

    @Override
    public RequestParams setTianqi(String url) {
        RequestParams params = new RequestParams(url);
//        params.setConnectTimeout(10000);
        params.setCharset("UTF-8");
        return params;
    }

    @Override
    public RequestParams setLogin(Map<String,String> map, Context context) {
        RequestParams params = new RequestParams(UploadUrl.url+UploadUrl.loginurl);
        params.setCharset("UTF-8");
        // params.setBodyContent("text/html;charset=UTF-8");
        params.setMultipart(true);
        params.setConnectTimeout(8000);
        params.addQueryStringParameter(UploadUrl.version,StringUntils.getVersion(context));
        params.addQueryStringParameter(UploadUrl.action,"login");
        params.addQueryStringParameter(UploadUrl.method,"doInDto");
        params.addQueryStringParameter(UploadUrl.appkey,"100");

        params.addQueryStringParameter(UploadUrl.signature,"");
        params.addQueryStringParameter(UploadUrl.Language,"");
//        params.setAsJsonContent(true);
        Gson gson = new Gson();
    String jsonString = gson.toJson(map);
    params.addQueryStringParameter(UploadUrl.req,jsonString);
    return params;
}

    @Override
    public RequestParams setUpload(Map<String, String> map,  String action,  String appkey, Context context) {
        RequestParams params = new RequestParams(UploadUrl.url+UploadUrl.loginurl);
        params.setCharset("UTF-8");
        // params.setBodyContent("text/html;charset=UTF-8");
        params.setMultipart(true);
//        params.setConnectTimeout(8000);
        params.addQueryStringParameter(UploadUrl.version,StringUntils.getVersion(context));
        params.addQueryStringParameter(UploadUrl.action,action);
        params.addQueryStringParameter(UploadUrl.method,"doInDto");
        params.addQueryStringParameter(UploadUrl.appkey,appkey);
        params.addQueryStringParameter(UploadUrl.signature,"");
        params.addQueryStringParameter(UploadUrl.Language,"");
//        params.setAsJsonContent(true);
        Gson gson = new Gson();
        String jsonString = gson.toJson(map);
        params.addQueryStringParameter(UploadUrl.req,jsonString);
        return params;
    }

    @Override
    public RequestParams setFujianUpload(Map<String, String> map,Context context) {
        RequestParams params = new RequestParams(UploadUrl.url+UploadUrl.loginurl);
        params.setCharset("UTF-8");
        // params.setBodyContent("text/html;charset=UTF-8");
        params.setMultipart(true);
//        params.setConnectTimeout(8000);
        params.addQueryStringParameter(UploadUrl.version,StringUntils.getVersion(context));
        params.addQueryStringParameter(UploadUrl.action,UploadUrl.file);
        params.addQueryStringParameter(UploadUrl.method,"doInDto");
        params.addQueryStringParameter(UploadUrl.appkey,SharedprefrenceHelper.getInstance(context).gettoken());
        params.addQueryStringParameter(UploadUrl.signature,"");
        params.addQueryStringParameter(UploadUrl.Language,"");
//        params.setAsJsonContent(true);
        Map fujian=new HashMap();
        fujian.put("id",map.get("id"));
        fujian.put("fkid",map.get("fkid"));
        String[] str =map.get("xiangdui").toString().split("/");
        if(map.get("cuntype").toString().equals("照片")){
            fujian.put("filetype","image");
        }else if(map.get("cuntype").toString().equals("视频")){
            fujian.put("filetype","video");
        }
        fujian.put("filename",str[str.length-1]);
//        fujian.put("file",);
        Gson gson = new Gson();
        String jsonString = gson.toJson(fujian);
        params.addBodyParameter("file",new File(Environment.getExternalStorageDirectory().getAbsolutePath()+map.get("xiangdui").toString()));
        params.addQueryStringParameter(UploadUrl.req,jsonString);
        return params;
    }

    @Override
    public RequestParams setUpload(String id, Context context) {
        RequestParams params = new RequestParams(UploadUrl.url+UploadUrl.loginurl);
        params.setCharset("UTF-8");
        // params.setBodyContent("text/html;charset=UTF-8");
        params.setMultipart(true);
//        params.setConnectTimeout(8000);
        params.addQueryStringParameter(UploadUrl.version,StringUntils.getVersion(context));
        params.addQueryStringParameter(UploadUrl.action,UploadUrl.file);
        params.addQueryStringParameter(UploadUrl.method,"fileList");
        params.addQueryStringParameter(UploadUrl.appkey,SharedprefrenceHelper.getInstance(context).gettoken());
        params.addQueryStringParameter(UploadUrl.signature,"");
        params.addQueryStringParameter(UploadUrl.Language,"");
        Map map = new HashMap();
        map.put("fkid",id);
        Gson gson = new Gson();
        String jsonString = gson.toJson(map);
        params.addQueryStringParameter(UploadUrl.req,jsonString);
        return params;
    }

    @Override
    public RequestParams setUpload(String id, String url, Context context) {
        RequestParams params = new RequestParams(UploadUrl.url+UploadUrl.loginurl);
        params.setCharset("UTF-8");
        // params.setBodyContent("text/html;charset=UTF-8");
        params.setMultipart(true);
//        params.setConnectTimeout(8000);
        params.setAutoRename(true);
        if(!new File(Untils.SDpath+"down/").exists()){
            new File(Untils.SDpath+"down/").mkdirs();
        }
        params.setSaveFilePath(Untils.SDpath+"down/"+url);
        params.addQueryStringParameter(UploadUrl.version,StringUntils.getVersion(context));
        params.addQueryStringParameter(UploadUrl.action,UploadUrl.file);
        params.addQueryStringParameter(UploadUrl.method,"downLoad");
        params.addQueryStringParameter(UploadUrl.appkey,SharedprefrenceHelper.getInstance(context).gettoken());
        params.addQueryStringParameter(UploadUrl.signature,"");
        params.addQueryStringParameter(UploadUrl.Language,"");
        Map map = new HashMap();
        map.put("id",id);
        Gson gson = new Gson();
        String jsonString = gson.toJson(map);
        params.addQueryStringParameter(UploadUrl.req,jsonString);
        return params;
    }

    @Override
    public RequestParams setUpload2(Map<String, String> map,  String action,  String appkey, Context context) {
        RequestParams params = new RequestParams(UploadUrl.url+UploadUrl.loginurl);
        params.setCharset("UTF-8");
        // params.setBodyContent("text/html;charset=UTF-8");
        params.setMultipart(true);
//        params.setConnectTimeout(8000);
        params.addQueryStringParameter(UploadUrl.version,StringUntils.getVersion(context));
        params.addQueryStringParameter(UploadUrl.action,action);
        params.addQueryStringParameter(UploadUrl.method,"add");
        params.addQueryStringParameter(UploadUrl.appkey,appkey);
        params.addQueryStringParameter(UploadUrl.signature,"");
        params.addQueryStringParameter(UploadUrl.Language,"");
//        params.setAsJsonContent(true);
        Gson gson = new Gson();
        String jsonString = gson.toJson(map);
        params.addQueryStringParameter(UploadUrl.req,jsonString);
        return params;
    }

    @Override
    public RequestParams setwodetufa(Map<String, String> map, String action, String appkey, Context context) {
        RequestParams params = new RequestParams(UploadUrl.url+UploadUrl.loginurl);
        params.setCharset("UTF-8");
        // params.setBodyContent("text/html;charset=UTF-8");
        params.setMultipart(true);
//        params.setConnectTimeout(8000);
        params.addQueryStringParameter(UploadUrl.version,StringUntils.getVersion(context));
        params.addQueryStringParameter(UploadUrl.action,action);
        params.addQueryStringParameter(UploadUrl.method,"queryList");
        params.addQueryStringParameter(UploadUrl.appkey,appkey);
        params.addQueryStringParameter(UploadUrl.signature,"");
        params.addQueryStringParameter(UploadUrl.Language,"");
//        params.setAsJsonContent(true);
        Gson gson = new Gson();
        String jsonString = gson.toJson(map);
        params.addQueryStringParameter(UploadUrl.req,jsonString);
        return params;




    }

    @Override
    public RequestParams ReqUpload(Map<String, String> map, String action, String method, String appkey, Context context) {
        RequestParams params = new RequestParams(UploadUrl.url+UploadUrl.loginurl);
        params.setCharset("UTF-8");
        // params.setBodyContent("text/html;charset=UTF-8");
        params.setMultipart(true);
//        params.setConnectTimeout(8000);
        params.addQueryStringParameter(UploadUrl.version,StringUntils.getVersion(context));
        params.addQueryStringParameter(UploadUrl.action,action);
        params.addQueryStringParameter(UploadUrl.method,method);
        params.addQueryStringParameter(UploadUrl.appkey,appkey);
        params.addQueryStringParameter(UploadUrl.signature,"");
        params.addQueryStringParameter(UploadUrl.Language,"");
//        params.setAsJsonContent(true);
        Gson gson = new Gson();
        String jsonString = gson.toJson(map);
        params.addQueryStringParameter(UploadUrl.req,jsonString);
        return params;
    }

}
