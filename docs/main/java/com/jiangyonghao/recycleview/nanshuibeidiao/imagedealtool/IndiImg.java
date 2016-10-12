package com.jiangyonghao.recycleview.nanshuibeidiao.imagedealtool;


import android.content.Context;
import android.util.AttributeSet;
import android.view.LayoutInflater;
import android.view.View;
import android.widget.ImageView;
import android.widget.ImageView.ScaleType;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;

/**
 * 上传图片时，图片上方带百分比指示的图片
 * 
 * @author liyh
 * 
 */
public class IndiImg extends RelativeLayout {

	private ImageView img;
	private TextView txt;

	public IndiImg(Context context) {
		super(context);
		// TODO Auto-generated constructor stub
		init(context);
	}

	public IndiImg(Context context, AttributeSet attrs) {
		super(context, attrs);
		// TODO Auto-generated constructor stub
		init(context);
	}

	public IndiImg(Context context, AttributeSet attrs, int defStyle) {
		super(context, attrs, defStyle);
		// TODO Auto-generated constructor stub
		init(context);
	}

	private void init(Context context) {
		LayoutInflater.from(context).inflate(R.layout.indimgview, this);
		img = (ImageView) this.findViewById(R.id.img);
//		txt = (TextView) this.findViewById(R.id.txt);
		img.setScaleType(ScaleType.CENTER_CROP);
		img.setAdjustViewBounds(true);
		txt.setVisibility(View.GONE);

	}

	public void setText(Double text) {
		txt.setVisibility(View.VISIBLE);
		if (text > 0) {
			txt.setText((text * 100 + "").substring(0, 4) + "%");
		} else {
			txt.setText("0.00%");
		}
	}

	public void display(String url) {
		ImageManager2.from(getContext()).displayImage(img, url,
				R.mipmap.ic_launcher, 100, 100);
	}

	public void display(Integer resId) {
		img.setImageResource(resId);
	}
}
