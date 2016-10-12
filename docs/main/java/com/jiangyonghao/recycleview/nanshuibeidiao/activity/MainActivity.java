package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.content.Intent;
import android.location.Location;
import android.location.LocationListener;
import android.os.Bundle;
import android.os.Handler;
import android.util.TimingLogger;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.FrameLayout;
import android.widget.ImageButton;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.RelativeLayout;
import android.widget.TextView;

import com.esri.android.map.Callout;
import com.esri.android.map.GraphicsLayer;
import com.esri.android.map.LocationDisplayManager;
import com.esri.android.map.MapView;
import com.esri.android.map.ags.ArcGISDynamicMapServiceLayer;
import com.esri.android.map.ags.ArcGISImageServiceLayer;
import com.esri.android.map.ags.ArcGISTiledMapServiceLayer;
import com.esri.android.map.event.OnZoomListener;
import com.esri.android.runtime.ArcGISRuntime;
import com.esri.core.geometry.Envelope;
import com.esri.core.geometry.GeometryEngine;
import com.esri.core.geometry.LinearUnit;
import com.esri.core.geometry.Point;
import com.esri.core.geometry.SpatialReference;
import com.esri.core.geometry.Unit;
import com.esri.core.map.Graphic;
import com.esri.core.symbol.PictureMarkerSymbol;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.StringUntils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.Dialog;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.GpsKaiqi;

import java.util.ArrayList;
import java.util.HashMap;

public class MainActivity extends Baseactivity implements View.OnClickListener {

    //查询数据库
    HelperDb helper;
    //    底部按钮
    private LinearLayout Linear_btn_Main;
    //    按钮
    private LinearLayout switch_frag, xuncha_btn, shijiansb_btn, saoyis_btn, wode_btn;
    //
    private RelativeLayout re;
    //    未上报表
    private ArrayList<HashMap<String, String>> noUpEmergencyList;
    //    是否上报
    private String isupload = "0";
    private ImageView common_sousuokuang_sousuo, common_sousuokuang_xinxi;
    private EditText common_sousuokuang_shuru;

    //    新建MapView
    private MapView mapView = null;
    private ArcGISTiledMapServiceLayer arcGISTiledMapServiceLayer = null;
    private ArcGISDynamicMapServiceLayer arcGISTiledMapServiceLayer1 = null;
    GraphicsLayer graphicsLayer;
    Callout callout;
    LocationDisplayManager ls;
    GpsKaiqi gsp;
    Handler handler = new Handler();
    double scale;
    private LinearLayout melin;
    private TextView melocation;

    private ImageView bianhua;
    //获取1pt对应的像素值
    private int width;
    private float pt = (float) (72 / 2.54);
    private float px;
    private int vv;
    private LinearLayout.LayoutParams paramsfull;
    private ImageButton zoom_in, zoom_out;
    private ImageView wolocation, daohang;
    private double lon, lat;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Baseactivity.addactvity(this);
        initView();
        initCtrl();
        helper = new HelperDb(this);
        noUpEmergencyList = helper.getEmergencylist(Untils.tufaType, isupload);
    }

    private void initCtrl() {
        width = DataTools.getViewWidth(melocation);
        scale = mapView.getScale();
        vv = width;
        paramsfull = new LinearLayout.LayoutParams(vv + 30, ViewGroup.LayoutParams.WRAP_CONTENT);
        bianhua.setLayoutParams(paramsfull);
        gsp = new GpsKaiqi(MainActivity.this, "为了定位准确，请开启GPS");
        String strMapUrl = "http://map.geoq.cn/ArcGIS/rest/services/ChinaOnlineCommunity/MapServer";
        this.arcGISTiledMapServiceLayer = new ArcGISTiledMapServiceLayer(strMapUrl);
        Envelope env = new Envelope(116.21968952721559, 39.767971655227115, 116.48440413622637, 39.97385767909881);
//        this.mapView.addLayer(arcGISTiledMapServiceLayer);//添加并显示地图
        mapView.setExtent(env);
        String strMapUrl1 = UploadUrl.dituurl + "/arcgis/rest/services/20131125NSBDgongcheng/MapServer";

        this.arcGISTiledMapServiceLayer1 = new ArcGISDynamicMapServiceLayer(strMapUrl1);
        this.mapView.addLayer(arcGISTiledMapServiceLayer1);//添加并显示地图this.arcGISTiledMapServiceLayer = new ArcGISTiledMapServiceLayer(strMapUrl);
        ArcGISRuntime.setClientId("9yNxBahuPiGPbsdi");//去水印
        //设置图片标记，将其放入res/drawable中，并在此处选择设置
        ls = mapView.getLocationDisplayManager();//通过map对象获取定位服务
        ls.setAccuracyCircleOn(true);
        ls.setAllowNetworkLocation(true);
        ls.setAutoPanMode(LocationDisplayManager.AutoPanMode.NAVIGATION);
        ls.setLocationListener(lisr);
//        mapView.setMapBackground(0Xffffff, 0X000000, 20, 1);
        ls.start();
        xuncha_btn.setOnClickListener(this);
        shijiansb_btn.setOnClickListener(this);
        saoyis_btn.setOnClickListener(this);
        wode_btn.setOnClickListener(this);
        daohang.setOnClickListener(this);
        common_sousuokuang_sousuo.setOnClickListener(this);
        common_sousuokuang_shuru.setOnClickListener(this);
        common_sousuokuang_xinxi.setOnClickListener(this);
        common_sousuokuang_shuru.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View view, boolean b) {
                if (b) {
                    Untils.isLuxian = false;
                    Intent intent = new Intent(MainActivity.this, SearchInfoActivity.class);
                    Untils.SEARCHMODE = true;
                    startActivity(intent);
                }
            }
        });
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        params.bottomMargin = DataTools.getViewHeight(switch_frag) + 10;
        params.gravity = Gravity.BOTTOM | Gravity.LEFT;
        melin.setLayoutParams(params);
        mapView.setOnZoomListener(new OnZoomListener() {
            @Override
            public void preAction(float v, float v1, double v2) {

            }

            @Override
            public void postAction(float v, float v1, double v2) {
                scale = mapView.getScale();
                melocation.setText((Untils.setkm((scale / 100))));
                width = DataTools.getViewWidth(melocation);
                paramsfull = new LinearLayout.LayoutParams(width + 30 + Untils.setjuli((scale / 100)), ViewGroup.LayoutParams.WRAP_CONTENT);
                bianhua.setLayoutParams(paramsfull);


            }
        });
        mapView.setMinScale(1E8);
        mapView.setMaxScale(1000);
        zoom_out.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mapView.zoomout();
//                melocation.setText((int)(mapView.getScale()/100)+"米"+mapView.getRotation());
            }
        });
        zoom_in.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mapView.zoomin();
//                melocation.setText((int)(mapView.getScale()/100)+"米"+mapView.getRotation());
            }
        });
        wolocation.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                mapView.centerAt(lat, lon, true);
            }
        });
    }

    LocationListener lisr = new LocationListener() {
        boolean locationChanged = false;

        @Override
        public void onLocationChanged(Location loc) {
            if (!locationChanged) {
                locationChanged = true;
                double locy = loc.getLatitude();
                double locx = loc.getLongitude();
                lon = locx;
                lat = locy;
                Point wgspoint = new Point(locx, locy);
                Point mapPoint = (Point) GeometryEngine.project(wgspoint, SpatialReference.create(4326), mapView.getSpatialReference());
                Unit mapUnit = mapView.getSpatialReference().getUnit();
                double zoomWidth = Unit.convertUnits(20, Unit.create(LinearUnit.Code.MILE_US), mapUnit);
                Envelope zoomExtent = new Envelope(mapPoint, zoomWidth, zoomWidth);
                mapView.setExtent(zoomExtent, 20, true);
//                melocation.setText((int)(mapView.getScale()/100)+"米");
            }
        }

        @Override
        public void onStatusChanged(String provider, int status, Bundle extras) {

        }

        @Override
        public void onProviderEnabled(String provider) {

        }

        @Override
        public void onProviderDisabled(String provider) {
            if (!gsp.isShowing()) {
                gsp.show();
            }

        }
    };

    private void initView() {
        wolocation = (ImageView) findViewById(R.id.wolocation);
        daohang = (ImageView) findViewById(R.id.daohang);
        zoom_in = (ImageButton) findViewById(R.id.zoom_in);
        zoom_out = (ImageButton) findViewById(R.id.zoom_out);
        bianhua = (ImageView) findViewById(R.id.bianhua);
        switch_frag = (LinearLayout) findViewById(R.id.switch_frag);
        melin = (LinearLayout) findViewById(R.id.melin);
        melocation = (TextView) findViewById(R.id.melocation);
        mapView = (MapView) findViewById(R.id.map);
        common_sousuokuang_sousuo = (ImageView) findViewById(R.id.common_sousuokuang_sousuo);
        common_sousuokuang_shuru = (EditText) findViewById(R.id.common_sousuokuang_shuru);
        common_sousuokuang_xinxi = (ImageView) findViewById(R.id.common_sousuokuang_xinxi);
        Linear_btn_Main = (LinearLayout) findViewById(R.id.switch_frag);
        xuncha_btn = (LinearLayout) findViewById(R.id.xuncha_btn);
        shijiansb_btn = (LinearLayout) findViewById(R.id.shijiansb_btn);
        saoyis_btn = (LinearLayout) findViewById(R.id.saoyis_btn);
        wode_btn = (LinearLayout) findViewById(R.id.wode_btn);
    }


    @Override
    public void onClick(View v) {
        Intent intent = null;
        switch (v.getId()) {
            case R.id.daohang:
                Untils.isLuxian = true;
                intent = new Intent(MainActivity.this, LuxianActivity.class);
                intent.putExtra("me", "我的位置");
                intent.putExtra("melon", lon);
                intent.putExtra("melat", lat);
                break;
            case R.id.xuncha_btn:
                Untils.isWode = false;
                if (helper.getInspectionmessage1().size() <= 0) {
                    intent = new Intent(MainActivity.this, StartXunchatbActivity.class);
                } else {
//                    Log.e("dddd", helper.getInspectionmessage1(DataTools.getLocaleMonth()).get(Untils.inspectionmessage[1])+"dd");
                    Untils.starttime = helper.getInspectionmessage1().get(Untils.inspectionmessage[1]);
                    Untils.taskid = helper.getInspectionmessage1().get(Untils.inspectionmessage[0]);
                    Dialog dialog = new Dialog(MainActivity.this, Untils.taskid);
                    dialog.setCanceledOnTouchOutside(false);
                    dialog.show();
                    return;
                }
                break;
            case R.id.shijiansb_btn:
                if (noUpEmergencyList.size() != 0) {
//                    Log.e("1111", "noUpEmergencyList--" + noUpEmergencyList.size());
                    intent = new Intent(MainActivity.this, ChooseshijsbActivity.class);
                    intent.putExtra("Activity", Untils.tufashijian);
                } else {
                    intent = new Intent(MainActivity.this, ShijiansbActivity.class);
                }
                break;
            case R.id.saoyis_btn:
                intent = new Intent(MainActivity.this, RealTimeActivity.class);
                intent.putExtra("who", "YYY");
//                intent = new Intent(MainActivity.this, SaoyisActivity.class);
                break;
            case R.id.wode_btn:
                Untils.isWode = true;
                intent = new Intent(MainActivity.this, WodeActivity.class);
                intent.putExtra("who", "XXX");
                break;
            case R.id.common_sousuokuang_xinxi:
                intent = new Intent(MainActivity.this, WodeActivity.class);
                break;
            case R.id.common_sousuokuang_shuru:
            case R.id.common_sousuokuang_sousuo:
                Untils.isLuxian = false;
                intent = new Intent(MainActivity.this, SearchInfoActivity.class);
                Untils.SEARCHMODE = true;
                break;
        }
        Untils.setHidden(this);
        startActivity(intent);
    }

    @Override
    protected void onRestart() {
        noUpEmergencyList = helper.getEmergencylist(Untils.tufaType, isupload);
//        String strMapUrl1 = "http://192.168.0.121:6080/arcgis/rest/services/20131125NSBDgongcheng/MapServer";
//
//        ArcGISImageServiceLayer arcGISTiledMapServiceLayer1 = new ArcGISImageServiceLayer(strMapUrl1,null);
//        this.mapView.addLayer(arcGISTiledMapServiceLayer1);//添加并显示地图this.arcGISTiledMapServiceLayer = new ArcGISTiledMapServiceLayer(strMapUrl);
        super.onRestart();
    }

    @Override
    protected void onDestroy() {
        super.onDestroy();
        ls.stop();
    }
}
