package com.jiangyonghao.recycleview.nanshuibeidiao.view;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.GuanXianActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by jiangyonghao on 2016/8/13.
 */
public class GuanXianDialog extends android.app.Dialog {
    private LinearLayout neirong;
    private TextView guanxian_title;
    private Context context;
    private ImageView back;
    private EditText editText_neirong;
    private Button dialog_ok;
    private ArrayList<HashMap<String, String>> mapList = null;
    Intent intent;
    private String title;
    private HelperDb helperDb;
    private String id;
    private String neirong1;

    public GuanXianDialog(Context c, String title, String ID, PriorityListener listener) {
        super(c);
        this.context = c;
        this.title = title;
        helperDb = new HelperDb(context);
        id = ID;
        this.listener = listener;
    }

    public GuanXianDialog(Context c, String title, String neirong) {
        super(c);
        this.context = c;
        this.title = title;
        this.neirong1 = neirong;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        requestWindowFeature(Window.FEATURE_NO_TITLE);
        setContentView(R.layout.guanxiandialog);
        editText_neirong = (EditText) findViewById(R.id.editText_dialog_guanxian_neirong);
        dialog_ok = (Button) findViewById(R.id.button_guanxian_dialog_ok);
        back = (ImageView) findViewById(R.id.imageView_guanxian_dialog_back);
        neirong = (LinearLayout) findViewById(R.id.linearLayout_dialog_guanxian);
        guanxian_title = (TextView) findViewById(R.id.textView_dialog_guanxian_title);
        guanxian_title.setText(title);
        if (!Untils.isWode) {
            if (!GuanXianActivity.guanxianType) {
                mapList = helperDb.getLinepipelist(Untils.daningguanxianType, Untils.starttime, Untils.noupload, Untils.guanxian);
            } else {
                mapList = helperDb.getLinepipelist(Untils.dongganquguanxianType, Untils.starttime, Untils.noupload, Untils.guanxian);
            }

            for (int i = 0; i < mapList.size(); i++) {
                if (mapList.get(i).get(Untils.linepipe[0]).equals(id) && title.equals("问题描述")) {
                    editText_neirong.setText(mapList.get(i).get(Untils.linepipe[9]));
                } else {
                    editText_neirong.setText(mapList.get(i).get(Untils.linepipe[10]));
                }
            }
        } else {
            editText_neirong.setText(neirong1);
            editText_neirong.setEnabled(false);
        }
        WindowManager wm = (WindowManager) getContext()
                .getSystemService(Context.WINDOW_SERVICE);
        int width = wm.getDefaultDisplay().getWidth();
        android.view.ViewGroup.LayoutParams lp = neirong.getLayoutParams();
        lp.width = (int) (width * 0.8);
        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                dismiss();
                InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
                imm.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);//收开软键盘
            }
        });
        dialog_ok.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (!Untils.isWode) {
                    if (title.equals("问题描述")) {
                        helperDb.update(id, Untils.linepipe[9], editText_neirong.getText().toString(), Untils.guanxian);
                    } else {
                        helperDb.update(id, Untils.linepipe[10], editText_neirong.getText().toString(), Untils.guanxian);
                    }
                    listener.refreshPriorityUI(editText_neirong.getText().toString() == "" || editText_neirong.getText().toString() == null || editText_neirong.getText().toString().equals("") ? "未填写" : "已填写");
                    ToastShow.setShow(context, "保存成功");
                }
                dismiss();
                InputMethodManager imm = (InputMethodManager) context.getSystemService(Context.INPUT_METHOD_SERVICE);
                imm.toggleSoftInput(0, InputMethodManager.HIDE_NOT_ALWAYS);//收开软键盘
            }
        });


    }


    /**
     * 自定义Dialog监听器
     */
    public interface PriorityListener {
        /**
         * 回调函数，用于在Dialog的监听事件触发后刷新Activity的UI显示
         */
        public void refreshPriorityUI(String string);
    }

    private PriorityListener listener;
}
