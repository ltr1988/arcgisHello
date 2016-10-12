package com.jiangyonghao.recycleview.nanshuibeidiao.common;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.DatePickerDialog;
import android.app.DatePickerDialog.OnDateSetListener;
import android.app.TimePickerDialog;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Bitmap.CompressFormat;
import android.graphics.BitmapFactory;
import android.util.Base64;
import android.util.Log;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TimePicker;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

@SuppressLint("ShowToast")
public class DataTools {
	/**
	 * dip转为 px
	 */
	public static int dip2px(Context context, float dipValue) {
		final float scale = context.getResources().getDisplayMetrics().density;
		return (int) (dipValue * scale + 0.5f);
	}

	/**
	 * px 转为 dip
	 */
	public static int px2dip(Context context, float pxValue) {
		final float scale = context.getResources().getDisplayMetrics().density;
		return (int) (pxValue / scale + 0.5f);
	}

	/**
	 * bitmap转成string
	 * 
	 * @param
	 */
	public static String convertIconToString(Bitmap bitmap) {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();// outputstream
		bitmap.compress(CompressFormat.PNG, 100, baos);
		byte[] appicon = baos.toByteArray();// 转为byte数组
		return Base64.encodeToString(appicon, Base64.DEFAULT);

	}

	/**
	 * string转成bitmap
	 * 
	 * @param st
	 */
	public static Bitmap convertStringToIcon(String st) {
		// OutputStream out;
		Bitmap bitmap = null;
		try {
			// out = new FileOutputStream("/sdcard/aa.jpg");
			byte[] bitmapArray;
			bitmapArray = Base64.decode(st, Base64.DEFAULT);
			bitmap = BitmapFactory.decodeByteArray(bitmapArray, 0,
					bitmapArray.length);
			// bitmap.compress(Bitmap.CompressFormat.PNG, 100, out);
			return bitmap;
		} catch (Exception e) {
			return null;
		}
	}
	public static void setStatusHeight(Context context,View view){
		view.setPadding(0,getStatusHeight(context),0,0);
	}
	/** 获得屏幕顶部高度 */
	public static int getStatusHeight(Context context) {
		int statusHeight = -1;
		try {
			Class<?> clazz = Class.forName("com.android.internal.R$dimen");
			Object object = clazz.newInstance();
			int height = Integer.parseInt(clazz.getField("status_bar_height")
					.get(object).toString());
			statusHeight = context.getResources().getDimensionPixelSize(height);
		} catch (Exception e) {
			e.printStackTrace();
		}
		Log.e("标题栏高度", "getStatusHeight: "+statusHeight );
		return statusHeight;
	}

	/** 获得组件高度 */
	public static int getViewHeight(View view) {
		int heightM = View.MeasureSpec.makeMeasureSpec(0,
				View.MeasureSpec.UNSPECIFIED);
		int widthM = View.MeasureSpec.makeMeasureSpec(0,
				View.MeasureSpec.UNSPECIFIED);
		view.measure(widthM, heightM);
		int height = view.getMeasuredHeight();
		return height;

	}
	/** 获得组件宽度 */
	public static int getViewWidth(View view) {
		int heightM = View.MeasureSpec.makeMeasureSpec(0,
				View.MeasureSpec.UNSPECIFIED);
		int widthM = View.MeasureSpec.makeMeasureSpec(0,
				View.MeasureSpec.UNSPECIFIED);
		view.measure(widthM, heightM);
		int width = view.getMeasuredWidth();
		return width;

	}
	public static String getLocaleMonth() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		String format = sdf.format(new Date());
		return format;
	}
	/** 功能说明：得到当前时间 年/月/日 */
	@SuppressLint("SimpleDateFormat")
	public static String getLocaleDayOfMonth() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String format = sdf.format(new Date());
		return format;
	}
	@SuppressLint("SimpleDateFormat")
	public static String getLocaleDayOfMonth1() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日");
		String format = sdf.format(new Date());
		return format;
	}
	@SuppressLint("SimpleDateFormat")
	public static String getLocaleDayOfMonth2() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
		String format = sdf.format(new Date());
		return format;
	}
	/**
	 * 功能说明：得到当前时间 年/月/日/时/分/秒
	 */
	@SuppressLint("SimpleDateFormat")
	public static String getLocaleTime() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String format = sdf.format(new Date());
		return format;
	}
	public static String shi() {
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm");
		String format = sdf.format(new Date());
		return format;
	}
	public static String shi1() {
		SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
		String format = sdf.format(new Date());
		return format;
	}
	public static String tian() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String format = sdf.format(new Date());
		return format;
	}
	public static String getLocaleTime1() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String format = sdf.format(new Date());
		return format;
	}
//	附件三级目录文件名（天为单位）
	public static String getfilepath() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String format = sdf.format(new Date());
		return format;
	}

	/** 将本地图片转化为Bitmap */
	public static Bitmap getLocationBitmap(String url) {
		try {
			FileInputStream fis = new FileInputStream(url);
			return BitmapFactory.decodeStream(fis);
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 获得GridView 的总高度
	 * 
	 * @return
	 */
	public static int getAllItemHeight(Activity activity, int otherheight) {
		@SuppressWarnings("deprecation")
		// 获得屏幕总高度
		int height = activity.getWindowManager().getDefaultDisplay()
				.getHeight();
		// 获得屏幕顶栏高度
		int titleheight = DataTools.getStatusHeight(activity);
		// 总高度-顶栏高度-其他控件高度得到控件高度
		int allitemheight = height - DataTools.dip2px(activity, otherheight)
				- titleheight;

		return allitemheight;
	}

	/**
	 * 获得GridView 每个item的宽度
	 * 
	 * @return
	 */
	public static int getGridItemWidth(Activity activity, int size) {
		@SuppressWarnings("deprecation")
		int width = activity.getWindowManager().getDefaultDisplay().getWidth();
		int allitemwidth = width - DataTools.dip2px(activity, 20);
		return allitemwidth / size;
	}

	// 获取当前的年、月、日、小时/分钟
	static Calendar c = Calendar.getInstance();
	static int _year = c.get(Calendar.YEAR);
	static int _month = c.get(Calendar.MONTH);
	static int _day = c.get(Calendar.DAY_OF_MONTH);
	static int _hour = c.get(Calendar.HOUR_OF_DAY);
	static int _minute = c.get(Calendar.MINUTE);

	public static String getMonth(int month) {
		int month1 = month + 1;
		String str_month;
		if (month1 < 10) {
			str_month = "0" + month1;
		} else {
			str_month = "" + month1;
		}
		return str_month;
	}


	/** 创建可选择日期的Editext */
	public static void createDateTimeEditText(final Context context,
			final EditText editText) {
		editText.setFocusable(false);
		editText.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				new DatePickerDialog(context, new OnDateSetListener() {
					@Override
					public void onDateSet(DatePicker view, int year,
										  int monthOfYear, int dayOfMonth) {
						_year = year;
						_month = monthOfYear;
						_day = dayOfMonth;

						// String str_month = getMonth(_month);
						new TimePickerDialog(context,
								new TimePickerDialog.OnTimeSetListener() {

									@Override
									public void onTimeSet(TimePicker view,
											int hourOfDay, int minute) {
										// TODO Auto-generated method stub
										_hour = hourOfDay;
										_minute = minute;
										String str_month = getMonth(_month);
										editText.setText(new StringBuilder()
												.append(_year)
												.append("-")
												.append(str_month)
												.append("-")
												.append((_day < 10) ? "0"
														+ _day : _day)
												.append(" ")
												.append((_hour < 10) ? "0"
														+ _hour : _hour)
												.append(":")
												.append((_minute < 10) ? "0"
														+ _minute : _minute));

									}
								}, _hour, _minute, true).show();
						// editText.setText(_year + "-" + str_month + "-" +
						// _day);
						// AtDataLink atDataLink = (AtDataLink)
						// editText.getTag();
						// atDataLink.setValue(editText.getText().toString());
					}
				}, c.get(Calendar.YEAR), c.get(Calendar.MONTH), c
						.get(Calendar.DAY_OF_MONTH)).show();
			}
		});
	}

}
