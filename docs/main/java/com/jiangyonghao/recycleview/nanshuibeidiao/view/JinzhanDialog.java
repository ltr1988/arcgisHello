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
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;

import java.util.ArrayList;
import java.util.HashMap;

/**
 * Created by Administrator on 2016/9/24 0024.
 */
public class JinzhanDialog extends android.app.Dialog {
    private LinearLayout neirong;
    private TextView shijian_title;
    private Context context;
    private ImageView back;
    private EditText editText_neirong;
    private Button dialog_ok;
    private String title;
    public static String text;

    public JinzhanDialog(Context c, String title, PriorityListener listener) {
        super(c);
        this.context = c;
        this.title = title;
        this.listener = listener;
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
        shijian_title = (TextView) findViewById(R.id.textView_dialog_guanxian_title);
        shijian_title.setText(title);
        editText_neirong.setText(text);
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

                ToastShow.setShow(context, "保存成功");
                text=editText_neirong.getText().toString();
                if (!"".equals(editText_neirong.getText().toString())) {
                    listener.refreshPriorityUI("已填写", editText_neirong.getText().toString());
                } else {
                    listener.refreshPriorityUI("未填写", editText_neirong.getText().toString());
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
       void refreshPriorityUI(String string, String neirong);
    }

    private PriorityListener listener;
}
