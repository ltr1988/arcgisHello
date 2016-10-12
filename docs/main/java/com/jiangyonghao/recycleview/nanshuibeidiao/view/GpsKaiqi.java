package com.jiangyonghao.recycleview.nanshuibeidiao.view;

import android.app.Activity;
import android.app.Dialog;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.view.Window;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;

import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

public class GpsKaiqi extends Dialog {
	private Context context;
	private String message;
	@ViewInject(R.id.tishi_message)
	private TextView messageview;
	DisplayMetrics dm;

	public GpsKaiqi(Context context, String message) {
		super(context);
		// TODO Auto-generated constructor stub
		this.context = context;
		this.message = message;
	}

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		// TODO Auto-generated method stub
		super.onCreate(savedInstanceState);
		requestWindowFeature(Window.FEATURE_NO_TITLE);
		View view = LayoutInflater.from(context).inflate(R.layout.tishi2, null);
		x.view().inject(this, view);
		dm = new DisplayMetrics();
		// 取得屏幕属性
		((Activity) context).getWindowManager().getDefaultDisplay().getMetrics(dm);
		// 屏幕的宽度
		int screenWidth = dm.widthPixels;
		setContentView(view, new LayoutParams(screenWidth - 200, LayoutParams.WRAP_CONTENT));
		// view.setLayoutParams(new LinearLayout.LayoutParams(screenWidth-10,
		// screenWidth-10));
		messageview.setText(message);
	}

	@Event(R.id.tishi_fou)
	private void setFou(View view) {
		dismiss();
	}

	@Event(R.id.tishi_shi)
	private void setShi(View view) {
		dismiss();
		Intent gpsOptionsIntent = new Intent(
				android.provider.Settings.ACTION_LOCATION_SOURCE_SETTINGS);
		context.startActivity(gpsOptionsIntent);
	}
}
