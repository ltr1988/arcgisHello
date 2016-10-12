package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentPagerAdapter;

import java.util.ArrayList;

/**
 * Created by user on 2016/8/23.
 */
public class BasicInfoViewFragmentPagerAdapter extends FragmentPagerAdapter {
    private ArrayList<Fragment> list = new ArrayList();

    public BasicInfoViewFragmentPagerAdapter(FragmentManager fm, ArrayList<Fragment> fragmentList) {
        super(fm);
        list=fragmentList;
    }

    @Override
    public Fragment getItem(int position) {
        return list.get(position);
    }


//List<Fragment> fragmentList = new ArrayList<Fragment>();
//    public void addDatas(View f1) {
//        list.add(f1);
//    }
//

    /**
     * 获取viewpager要加载的页面总数
     *
     * @return
     */
    @Override
    public int getCount() {
        return list.size();
    }
//
//    /**
//     * 预留方法
//     *
//     * @param view
//     * @param object
//     * @return
//     */
//    @Override
//    public boolean isViewFromObject(View view, Object object) {
//        return view == object;
//    }
//
//    /**
//     * 初始划入的页面
//     *
//     * @param container
//     * @param position
//     * @return
//     */
//    @Override
//    public Object instantiateItem(ViewGroup container, int position) {
//        View view=list.get(position);
//        container.addView(view);
//        return view;
//    }
//
//    /**
//     * 删除划出的页面
//     *
//     * @param container
//     * @param position
//     * @param object
//     */
//    @Override
//    public void destroyItem(ViewGroup container, int position, Object object) {
//        View view=list.get(position);
//        container.removeView(view);
//    }
}
