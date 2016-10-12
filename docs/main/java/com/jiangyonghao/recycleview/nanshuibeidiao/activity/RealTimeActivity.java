package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.KeyEvent;
import android.view.View;
import android.widget.ImageButton;
import android.widget.LinearLayout;
import android.widget.ListView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.RealRainFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.RealWaterLevelFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.Fragment.RealWaterReservoFragment;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.adapter.RealTimeAdapter;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;

import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.ArrayList;
import java.util.HashMap;

@ContentView(R.layout.activity_real_time)
public class RealTimeActivity extends Baseactivity implements View.OnClickListener {
    @ViewInject(R.id.title_com)
    private TextView title_com;
    @ViewInject(R.id.title_tow_button)
    private LinearLayout title_tow_button;
    @ViewInject(R.id.return_com)
    private ImageButton return_com;
    @ViewInject(R.id.listview_realtime)
    private ListView listview_realtime;
    private RealTimeAdapter realTimeAdapter;
    private ArrayList<HashMap<String, String>> allList = null;//最外部list   list当中的list第一个hashmap是title第二个是时间

    private RealRainFragment realRainFragment;
    private RealWaterLevelFragment realWaterLevelFragment;
    private RealWaterReservoFragment realWaterReservoFragment;//水库水情
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        initial();
        setFragment();
    }

    private void setFragment() {
        realRainFragment = new RealRainFragment();
        realWaterLevelFragment = new RealWaterLevelFragment();
        realWaterReservoFragment = new RealWaterReservoFragment();
        FragmentManager fragmentManager = getSupportFragmentManager();//建立管理者
        FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();//事物管理者
        fragmentTransaction.add(R.id.linearlayout_realfragment_show, realRainFragment);
        fragmentTransaction.commit();
        showOrHideFra(false, 1);

        getSupportFragmentManager().beginTransaction().add(R.id.linearlayout_realfragment_show, realWaterLevelFragment).commit();
        showOrHideFra(false, 2);
        getSupportFragmentManager().beginTransaction().add(R.id.linearlayout_realfragment_show, realWaterReservoFragment).commit();
        showOrHideFra(false,3);
    }

    public void showOrHideFra(boolean show, int whitchFra) {
        if (show) {
            switch (whitchFra){
                case 1://实时雨情
                    getSupportFragmentManager().beginTransaction().show(realRainFragment).commit();
                    break;
                case 2://实时水位
                    getSupportFragmentManager().beginTransaction().show(realWaterLevelFragment).commit();
                    break;
                case 3://水库水情
                    getSupportFragmentManager().beginTransaction().show(realWaterReservoFragment).commit();
                    break;
            }

        } else {
            switch (whitchFra){
                case 1:
                    getSupportFragmentManager().beginTransaction().hide(realRainFragment).commit();
                    break;
                case 2:
                    getSupportFragmentManager().beginTransaction().hide(realWaterLevelFragment).commit();
                    break;
                case 3:
                    getSupportFragmentManager().beginTransaction().hide(realWaterReservoFragment).commit();
                    break;
            }
        }
    }

    private void initial() {
        title_com.setText(Untils.RealTimeACTitle);
        realTimeAdapter = new RealTimeAdapter(this);
        title_tow_button.setVisibility(View.GONE);
        allList = new ArrayList<>();
        //模拟数据
        //第一个
        HashMap<String, String> hmList1 = null;
        hmList1 = new HashMap<String, String>();
        hmList1.put(Untils.RealTimeTitle, Untils.RealTimeInfo[0]);//实时雨情
        hmList1.put(Untils.RealTimeTime, "2016-08-06 10:05:36");//实时雨情
        //第二个
        HashMap<String, String> hmList2 = null;
        hmList2 = new HashMap<String, String>();
        hmList2.put(Untils.RealTimeTitle, Untils.RealTimeInfo[1]);//实时雨情
        hmList2.put(Untils.RealTimeTime, "2016-08-06 11:15:16");//实时雨情
        //第三个
        HashMap<String, String> hmList3 = null;
        hmList3 = new HashMap<String, String>();
        hmList3.put(Untils.RealTimeTitle, Untils.RealTimeInfo[2]);//实时雨情
        hmList3.put(Untils.RealTimeTime, "2016-08-06 15:25:32");//实时雨情
        //第四个
        HashMap<String, String> hmList4 = null;
        hmList4 = new HashMap<String, String>();
        hmList4.put(Untils.RealTimeTitle, Untils.RealTimeInfo[3]);//实时雨情
        hmList4.put(Untils.RealTimeTime, "2016-08-06 07:05:16");//实时雨情
        //第五个
        HashMap<String, String> hmList5 = null;
        hmList5 = new HashMap<String, String>();
        hmList5.put(Untils.RealTimeTitle, Untils.RealTimeInfo[4]);//实时雨情
        hmList5.put(Untils.RealTimeTime, "2016-08-06 02:05:09");//实时雨情
        //第六个
        HashMap<String, String> hmList6 = null;
        hmList6 = new HashMap<String, String>();
        hmList6.put(Untils.RealTimeTitle, Untils.RealTimeInfo[5]);//实时雨情
        hmList6.put(Untils.RealTimeTime, "2016-08-06 09:09:36");//实时雨情
        allList.add(hmList1);
        allList.add(hmList2);
        allList.add(hmList3);
        allList.add(hmList4);
        allList.add(hmList5);
        allList.add(hmList6);
        realTimeAdapter.addDatas(allList);
        listview_realtime.setAdapter(realTimeAdapter);


        return_com.setOnClickListener(this);
    }

    /**
     * 关闭或开启listview_realtime表单
     */
    public void showRealtimeList(boolean show) {//如果是真则显示
        if (show) {
            listview_realtime.setVisibility(View.VISIBLE);
        } else {
            listview_realtime.setVisibility(View.GONE);
        }
    }

    public void showTileTwoButton(boolean show) {//如果是真则显示
        if (show) {
            title_tow_button.setVisibility(View.VISIBLE);
        } else {
            title_tow_button.setVisibility(View.GONE);
        }

    }

    public void showTile(String title) {
        title_com.setText(title);
    }

    @Override
    public void onClick(View v) {
        switch (v.getId()) {
            case R.id.return_com:
                switch (title_com.getText().toString()) {//点击返回的时候通过抬头判断是在fragment还是在activity
                    case "实时数据":
                        finish();
                        break;
                    case "实时雨情":
                        title_com.setText(Untils.RealTimeInfo[6]);//返回activity 设置抬头为实时数据
                        showOrHideFra(false,1);
                        showTileTwoButton(false);
                        showRealtimeList(true);
                        break;
                    case "实时水位":
                        title_com.setText(Untils.RealTimeInfo[6]);//返回activity 设置抬头为实时数据
                        showOrHideFra(false,2);
                        showTileTwoButton(false);
                        showRealtimeList(true);
                        break;
                    case "水库水情":
                        title_com.setText(Untils.RealTimeInfo[6]);//返回activity 设置抬头为实时数据
                        showOrHideFra(false,3);
                        showTileTwoButton(false);
                        showRealtimeList(true);
                        break;
                }
                SharedPreferences titleTyleSharedPre = getSharedPreferences("titleTyle", Context.MODE_PRIVATE);
                //事物编辑器
                SharedPreferences.Editor edit = titleTyleSharedPre.edit();
                edit.putString("titleTyle", Untils.RealTimeInfo[6]);//实时数据
                edit.commit();
                break;
        }
    }

    @Override
    public boolean onKeyDown(int keyCode, KeyEvent event) {
        if (keyCode == KeyEvent.KEYCODE_BACK)
            return true;
        return super.onKeyDown(keyCode, event);
    }
}
