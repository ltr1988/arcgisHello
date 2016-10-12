package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.view.ViewPager;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageButton;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.BasicInfoLieBiaoFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.BasicInfoXinXiFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.EvolveBackFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.HistoryEvolveFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.ShijianWeisbFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.ShijianYisbFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.BasicInfoViewFragmentPagerAdapter;

import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;

import static android.graphics.Color.parseColor;

@ContentView(R.layout.activity_basic_info)
public class BasicInfoActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.imagebutton_return_com)
    private ImageButton back;
    @ViewInject(R.id.textView_basic_info_title1)
    private TextView title1;
    @ViewInject(R.id.textView_basic_info_title2)
    private TextView title2;
    @ViewInject(R.id.viewpager_basic_info)
    private ViewPager pager;
    private BasicInfoXinXiFragment fragment_xinxi;
    private BasicInfoLieBiaoFragment fragment_liebiao;
    private EvolveBackFragment fragment_evolveBack;//进展反馈
    private HistoryEvolveFragment fragment_historyEvolve;//历史进展
    private ShijianWeisbFragment fragment_wei;//我的事件上报未上报
    private ShijianYisbFragment fragment_yi;//我的事件上报已上报
    private BasicInfoViewFragmentPagerAdapter pagerAdapter = null;
    private ArrayList<Fragment> fragmentArrayList = null;
    //判断是有那个Activity跳转而来
    private Intent intentWho;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        Baseactivity.addactvity(this);
        initialUI();
        initCtrl();


    }

    private void initCtrl() {
        back.setOnClickListener(this);
        title1.setOnClickListener(this);
        title2.setOnClickListener(this);
    }


    private void initialUI() {
        fragmentArrayList = new ArrayList<>();
        intentWho = getIntent();
        switch (intentWho.getStringExtra("who")) {
            case "XXX":
                fragment_xinxi = new BasicInfoXinXiFragment();
                fragment_liebiao = new BasicInfoLieBiaoFragment();
                fragmentArrayList.add(fragment_xinxi);
                fragmentArrayList.add(fragment_liebiao);
                break;
            case "shijianshangbao":
                title1.setText("未上报");
                title2.setText("已上报");
                fragment_wei = new ShijianWeisbFragment();
                fragment_yi = new ShijianYisbFragment();
                fragmentArrayList.add(fragment_wei);
                fragmentArrayList.add(fragment_yi);
                break;
            case "Evolve":
                title1.setText("进展反馈");
                title2.setText("历史进展");
                String id =getIntent().getStringExtra("id");
                String disposeBy=getIntent().getStringExtra("disposeBy");
                Bundle bundle = new Bundle();
                bundle.putString("id",id);
                bundle.putString("disposeBy",disposeBy);
                fragment_evolveBack = new EvolveBackFragment();
                fragment_historyEvolve = new HistoryEvolveFragment();
                fragment_evolveBack.setArguments(bundle);
                fragment_historyEvolve.setArguments(bundle);
                fragmentArrayList.add(fragment_evolveBack);
                fragmentArrayList.add(fragment_historyEvolve);
                break;
        }
        pagerAdapter = new BasicInfoViewFragmentPagerAdapter(getSupportFragmentManager(), fragmentArrayList);
        pager.setAdapter(pagerAdapter);
        pager.setCurrentItem(0);
        pager.addOnPageChangeListener(pagerListener);
    }

    ViewPager.OnPageChangeListener pagerListener = new ViewPager.OnPageChangeListener() {

        /**
         * position :当前页面，及你点击滑动的页面 offset:当前页面偏移的百分比
         * offsetPixels:当前页面偏移的像素位置
         */
        @Override
        public void onPageScrolled(int position, float positionOffset, int positionOffsetPixels) {

            /**
             * 利用currentIndex(当前所在页面)和position(下一个页面)以及offset来
             * 设置mTabLineIv的左边距 滑动场景：
             * 记2个页面,
             * 从左到右分别为0,1
             * 0->1; 1->0
             */

        }

        @Override
        public void onPageSelected(int position) {
            switch (position) {
                case 0:
                    title2.setBackgroundResource(R.drawable.youceyuanjiao1);
                    title2.setTextColor(parseColor("#3285ff"));
                    title1.setBackgroundResource(R.drawable.zuoceyuanjiao1);
                    title1.setTextColor(parseColor("#FFFFFF"));
                    pager.setBackgroundColor(parseColor("#FFFFFF"));
                    break;
                case 1:
                    title1.setBackgroundResource(R.drawable.zuoceyuanjiao2);
                    title1.setTextColor(parseColor("#3285ff"));
                    title2.setBackgroundResource(R.drawable.youceyuanjiao2);
                    title2.setTextColor(parseColor("#FFFFFF"));
                    pager.setBackgroundColor(parseColor("#FFFFFF"));
                    break;
            }
        }

        /**
         * state滑动中的状态 有三种状态（0，1，2） 1：正在滑动 2：滑动完毕 0：什么都没做。
         */
        @Override
        public void onPageScrollStateChanged(int state) {
        }
    };

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.imagebutton_return_com:
                finish();
                break;
            case R.id.textView_basic_info_title1:
                //设置抬头背景色彩变化
                title2.setBackgroundResource(R.drawable.youceyuanjiao1);
                title2.setTextColor(parseColor("#3285ff"));
                title1.setBackgroundResource(R.drawable.zuoceyuanjiao1);
                title1.setTextColor(parseColor("#FFFFFF"));
                //设置跳转viewpager的页面
                pager.setCurrentItem(0);
                break;
            case R.id.textView_basic_info_title2:
                //设置抬头背景色彩变化
                title1.setBackgroundResource(R.drawable.zuoceyuanjiao2);
                title1.setTextColor(parseColor("#3285ff"));
                title2.setBackgroundResource(R.drawable.youceyuanjiao2);
                title2.setTextColor(parseColor("#FFFFFF"));
                //设置跳转viewpager的页面
                pager.setCurrentItem(1);
                break;
        }
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        pager.removeOnPageChangeListener(pagerListener);
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK) {
            return true;
        }
        return super.onKeyDown(keyCode, event);
    }

}
