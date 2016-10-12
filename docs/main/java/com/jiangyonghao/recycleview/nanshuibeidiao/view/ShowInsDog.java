package com.jiangyonghao.recycleview.nanshuibeidiao.view;

import android.content.Context;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.view.View;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;

import java.util.HashMap;

/**
 * Created by jiangyonghao on 2016/9/13.
 */
public class ShowInsDog extends android.app.Dialog {
    private HelperDb helper;
    private HashMap map;
    private RelativeLayout re;
    private LinearLayout xinyiqi, likai;
    private EditText xuncharenname;
    private EditText xunchaguanliname;
    private TextView tianqi;
    private TextView shijian;
    private Context context;
    private Handler handler = new Handler() {
        @Override
        public void handleMessage(Message msg) {
            super.handleMessage(msg);
            String weather = (String) msg.obj;
            tianqi.setText(weather);
            map.put(Untils.inspectionmessage[6], weather);
        }
    };
    public ShowInsDog(Context context) {
        super(context);
        this.context=context;
        helper = new HelperDb(context);
    }

    public ShowInsDog(Context context, int themeResId) {
        super(context, themeResId);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_xunchatb);
        map = helper.getInspectionmessage(Untils.starttime);
        re = (RelativeLayout) findViewById(R.id.rela);
        re.setVisibility(View.GONE);
        xinyiqi = (LinearLayout) findViewById(R.id.xinyiqi);
        xinyiqi.setVisibility(View.GONE);
        likai = (LinearLayout) findViewById(R.id.likai);
        likai.setVisibility(View.GONE);
        xuncharenname = (EditText) findViewById(R.id.xuncharenxingming);
        xuncharenname.setEnabled(false);
        xuncharenname.setText(map.get(Untils.inspectionmessage[4]).toString());

        xunchaguanliname = (EditText) findViewById(R.id.xunchaguanlixingming);
        xunchaguanliname.setEnabled(false);
        xunchaguanliname.setText(map.get(Untils.inspectionmessage[5]).toString());
        tianqi = (TextView) findViewById(R.id.tianqi);
        tianqi.setText(map.get(Untils.inspectionmessage[6])==null?"":map.get(Untils.inspectionmessage[6]).toString());
        Untils.getTianqi(handler, context);
        shijian = (TextView) findViewById(R.id.shijianTV);
        shijian.setText(map.get(Untils.inspectionmessage[8]).toString());

    }
}
