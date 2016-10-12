package com.jiangyonghao.recycleview.nanshuibeidiao.view;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.Window;
import android.widget.ImageView;
import android.widget.LinearLayout;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.StartXunchatbActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.XunChaActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.LongLatitudeUtils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Upload;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;

import org.json.JSONException;
import org.json.JSONObject;
import org.xutils.common.Callback;
import org.xutils.x;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by jiangyonghao on 2016/8/13.
 */
public class Dialog extends android.app.Dialog {
    private LinearLayout shangyici;
    private LinearLayout xinde;
    private Context context;
    private ImageView back;
    Intent intent;
    private HelperDb helper;
    private String ID;

    public Dialog(Context context, String ID) {
        super(context);
        this.context = context;
        this.ID = ID;
        helper = new HelperDb(context);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.dialog);
        shangyici = (LinearLayout) findViewById(R.id.lin);
        shangyici.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                setshangchuan();
//                Untils.isUncompleted = true;
                dismiss();
            }
        });
        xinde = (LinearLayout) findViewById(R.id.jieshu);
        xinde.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (LongLatitudeUtils.initGPS(context)) {
                    intent = new Intent(context, StartXunchatbActivity.class);
                    context.startActivity(intent);
//                    Untils.isUncompleted = false;
                    dismiss();
                }
            }
        });
        back = (ImageView) findViewById(R.id.back);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                dismiss();
            }
        });
    }

    private void setshangchuan() {
        Map map = new HashMap();
        map.put("id", ID);
        map.put("status", "1");
        map.put("source", UploadUrl.Android);
        x.http().post(Upload.getInstance().setUpload(map, UploadUrl.xunchaaction,SharedprefrenceHelper.getInstance(context).gettoken(), context), new Callback.CommonCallback<String>() {
            @Override
            public void onSuccess(String s) {
                Log.e("巡查任务接口", s);
                JSONObject json = null;
                try {
                    json = new JSONObject(s);
                    String status = json.getString(UploadUrl.backkey[0]);
                    if (status.equals("100")) {
                        intent = new Intent(context, XunChaActivity.class);
                        context.startActivity(intent);
                    }
                    ToastShow.setShow(context, Untils.shibie(status));
                } catch (JSONException e) {
                    e.printStackTrace();
                }
            }

            @Override
            public void onError(Throwable throwable, boolean b) {
                intent = new Intent(context, XunChaActivity.class);
                context.startActivity(intent);
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
