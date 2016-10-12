package com.jiangyonghao.recycleview.nanshuibeidiao.activity;

import android.app.Activity;
import android.content.Intent;
import android.graphics.Color;
import android.location.Location;
import android.location.LocationListener;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.Gravity;
import android.view.View;
import android.view.ViewGroup;
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
import com.esri.android.map.ags.ArcGISTiledMapServiceLayer;
import com.esri.android.map.event.OnSingleTapListener;
import com.esri.android.map.event.OnZoomListener;
import com.esri.android.runtime.ArcGISRuntime;
import com.esri.core.geometry.Envelope;
import com.esri.core.geometry.GeometryEngine;
import com.esri.core.geometry.LinearUnit;
import com.esri.core.geometry.Point;
import com.esri.core.geometry.SpatialReference;
import com.esri.core.geometry.Unit;
import com.esri.core.tasks.geocode.Locator;
import com.esri.core.tasks.geocode.LocatorReverseGeocodeResult;
import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.Mstore;
import com.jiangyonghao.recycleview.nanshuibeidiao.view.GpsKaiqi;

import org.xutils.view.annotation.ContentView;
import org.xutils.view.annotation.Event;
import org.xutils.view.annotation.ViewInject;
import org.xutils.x;

import java.util.HashMap;
import java.util.Map;

@ContentView(R.layout.activity_show_info_map)
public class ShowInfoMapActivity extends Baseactivity {
    @ViewInject(R.id.ditutitle)
    private TextView ditutitle;
    @ViewInject(R.id.common_sousuokuang_shuru)
    private EditText common_sousuokuang_shuru;
    private Mstore mstore;
    double scale;
    //获取1pt对应的像素值
    private int width;
    private float pt = (float) (72 / 2.54);
    private float px;
    private int vv;
    private LinearLayout.LayoutParams paramsfull;
    @ViewInject(R.id.zoom_in)
    private ImageButton zoom_in;
    @ViewInject(R.id.zoom_out)
    private ImageButton zoom_out;
    private double lon, lat;
    //    新建MapView
    @ViewInject(R.id.mapinfo)
    private MapView mapView = null;
    private ArcGISTiledMapServiceLayer arcGISTiledMapServiceLayer = null;
    GraphicsLayer graphicsLayer;
    LocationDisplayManager ls;
    @ViewInject(R.id.wolocation)
    private ImageView wolocation;
    @ViewInject(R.id.daohang)
    private ImageView daohang;
    @ViewInject(R.id.melin)
    private LinearLayout melin;
    @ViewInject(R.id.melocation)
    private TextView melocation;
    @ViewInject(R.id.bianhua)
    private ImageView bianhua;
    private GpsKaiqi gsp;
    @ViewInject(R.id.show_info_go)
    private LinearLayout show_info_go;
    @ViewInject(R.id.bottomshowre)
    private RelativeLayout bottomshowre;
    @ViewInject(R.id.bottomshow_name)
    private TextView bottomshow_name;
    @ViewInject(R.id.bottomshow_danwei)
    private TextView bottomshow_danwei;
    private Intent intent;
    Callout callout;
    com.esri.core.geometry.Point lt;
    TextView msg;
    private String address;
    private Handler handler = new Handler() {
        @Override
        public void handleMessage(Message ms) {
            super.handleMessage(ms);
            address = (String) ms.obj;
            msg.setText(address);
            callout.show(lt, msg);

        }
    };
    @ViewInject(R.id.sousuokuangxianxian)
    private LinearLayout sousuokuangxianxian;
    @ViewInject(R.id.dituxuandianlin)
    private LinearLayout dituxuandianlin;
    private boolean issingle = false;
    private Map map = new HashMap();
    private boolean isdianji = false;
    private ArcGISDynamicMapServiceLayer arcGISTiledMapServiceLayer1 = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        x.view().inject(this);
        Baseactivity.addactvity(this);
        daohang.setVisibility(View.INVISIBLE);
        mstore = new Mstore();
        map = (Map) getIntent().getSerializableExtra("map");
        infous();
        initCtrl();

    }

    private void sendDataBack() {
        intent = new Intent();
        if (issingle) {
            intent.putExtra("address", address);
            intent.putExtra("lat", lat);
            intent.putExtra("lon", lon);
        }
        // resultCode：结果码，表示数据是否回传成功
        setResult(Activity.RESULT_OK, intent);
        finish();
    }

    private void initCtrl() {
        callout = mapView.getCallout();//在mapView获取callout显示

        scale = mapView.getScale();
        width = DataTools.getViewWidth(melocation);
        vv = width;
        paramsfull = new LinearLayout.LayoutParams(vv + 30, ViewGroup.LayoutParams.WRAP_CONTENT);
        bianhua.setLayoutParams(paramsfull);
        gsp = new GpsKaiqi(ShowInfoMapActivity.this, "为了定位准确，请开启GPS");
//        String strMapUrl = "http://map.geoq.cn/ArcGIS/rest/services/ChinaOnlineCommunity/MapServer";
//        this.arcGISTiledMapServiceLayer = new ArcGISTiledMapServiceLayer(strMapUrl);
//        this.mapView.addLayer(arcGISTiledMapServiceLayer);//添加并显示地图
        Envelope env = new Envelope(116.21968952721559, 39.767971655227115, 116.48440413622637, 39.97385767909881);
//        this.mapView.addLayer(arcGISTiledMapServiceLayer);//添加并显示地图
        mapView.setExtent(env);
        String strMapUrl1 = UploadUrl.dituurl + "/arcgis/rest/services/20131125NSBDgongcheng/MapServer";

        this.arcGISTiledMapServiceLayer1 = new ArcGISDynamicMapServiceLayer(strMapUrl1);
        this.mapView.addLayer(arcGISTiledMapServiceLayer1);
        ArcGISRuntime.setClientId("9yNxBahuPiGPbsdi");//去水印
        //设置图片标记，将其放入res/drawable中，并在此处选择设置
        ls = mapView.getLocationDisplayManager();//通过map对象获取定位服务
        ls.setAccuracyCircleOn(true);
        ls.setAllowNetworkLocation(true);
        ls.setAutoPanMode(LocationDisplayManager.AutoPanMode.NAVIGATION);
        ls.setLocationListener(lisr);
        ls.start();
        FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
        if (show_info_go.isShown()) {
            params.bottomMargin = DataTools.getViewHeight(show_info_go) + 10 + DataTools.getViewHeight(bottomshowre);
        } else {
            params.bottomMargin = 10;
        }
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
        mapView.setOnSingleTapListener(new OnSingleTapListener() {
            @Override
            public void onSingleTap(float x, float y) {

                Point pt = mapView.toMapPoint(x, y);//pt为获取的单击点的墨卡托坐标
//                callout.hide();

                // i初始化地理编码服务
//                Locator al.createOnlineLocator("http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/Locators/ESRI_Geocode_USA/GeocodeServer");
                try {

                    int wkid = mapView.getSpatialReference().getID();
                    // 使其变成反地理编码并进行查询
                    LocatorReverseGeocodeResult result = Locator.createOnlineLocator(UploadUrl.dituurl + "/arcgis/rest/services/20131125NSBDgongcheng/MapServer").reverseGeocode(pt, 1000.00);
                    Log.e("dd", "onSingleTap: " + result.toString());
                } catch (Exception e) {
                    Log.e("dd", "onSingleTap: " + e.getMessage());
                }
                if (pt != null) {
                    if (map.size() == 0) {
                        issingle = true;
//                mapView.centerAt(pt, true);//设置地图中心为单击点
                        //将pt(墨卡托坐标)转化为点TouchPoint（wgs84坐标）
                        Point TouchPoint = (Point) GeometryEngine.project(pt,
                                SpatialReference.create(102100), SpatialReference.create(4326));
                        lon = TouchPoint.getX();
                        lat = TouchPoint.getY();

                        Untils.getweizhi(handler, TouchPoint.getX(), TouchPoint.getY(), ShowInfoMapActivity.this);

                        //设置callout的显示信息
                        Point location = new Point(TouchPoint.getX(), TouchPoint.getY());
                        lt = (Point) GeometryEngine.project(location,
                                SpatialReference.create(4326), SpatialReference.create(102100));
                        msg = new TextView(ShowInfoMapActivity.this);
                        msg.setBackgroundColor(Color.WHITE);
//                    msg.setText("fvv"+TouchPoint.getX()+","+TouchPoint.getY());
                        msg.setTextSize(12);
                        msg.setTextColor(Color.BLACK);
                        callout.setOffset(0, 0);
                    } else {
//                    Log.e("cq", "address is:" + address);
                        mapView.centerAt(Double.parseDouble(map.get("poiy").toString()), Double.parseDouble(map.get("poix").toString()), true);
                        lon = Double.parseDouble(map.get("poix").toString());
                        lat = Double.parseDouble(map.get("poiy").toString());
                        if (!isdianji) {
                            isdianji = true;
                            show_info_go.setVisibility(View.VISIBLE);
                            bottomshowre.setVisibility(View.VISIBLE);
                            FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                            params.bottomMargin = DataTools.getViewHeight(show_info_go) + 10 + DataTools.getViewHeight(bottomshowre);
                            params.gravity = Gravity.BOTTOM | Gravity.LEFT;
                            melin.setLayoutParams(params);
                        } else {
                            isdianji = false;
                            show_info_go.setVisibility(View.GONE);
                            bottomshowre.setVisibility(View.GONE);
                            FrameLayout.LayoutParams params = new FrameLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, ViewGroup.LayoutParams.WRAP_CONTENT);
                            params.bottomMargin = 10;
                            params.gravity = Gravity.BOTTOM | Gravity.LEFT;
                            melin.setLayoutParams(params);
                        }
                    }
                }
            }
        });
        if (map != null) {
            bottomshow_name.setText(map.get("name").toString());
            bottomshow_danwei.setText(map.get("mane").toString());
            ditutitle.setText(map.get("name").toString());
            Point location = new Point(Double.parseDouble(map.get("poix").toString()), Double.parseDouble(map.get("poiy").toString()));
            lt = (Point) GeometryEngine.project(location,
                    SpatialReference.create(4326), SpatialReference.create(102100));
            msg = new TextView(ShowInfoMapActivity.this);
            address = map.get("name").toString();
            msg.setBackgroundColor(Color.WHITE);
            msg.setTextSize(12);
            msg.setTextColor(Color.BLACK);
            callout.setOffset(0, 0);
            msg.setText(address);
            callout.show(lt, msg);
            mapView.centerAt(Double.parseDouble(map.get("poiy").toString()), Double.parseDouble(map.get("poix").toString()), true);
        }
    }

    LocationListener lisr = new LocationListener() {
        boolean locationChanged = false;

        @Override
        public void onLocationChanged(Location loc) {
            if (!locationChanged) {
                locationChanged = true;
                double locy = loc.getLatitude();
                double locx = loc.getLongitude();

                Point wgspoint = new Point(locx, locy);
                Point mapPoint = (Point) GeometryEngine.project(wgspoint, SpatialReference.create(4326), mapView.getSpatialReference());
                Unit mapUnit = mapView.getSpatialReference().getUnit();
                double zoomWidth = Unit.convertUnits(20, Unit.create(LinearUnit.Code.MILE_US), mapUnit);
                Envelope zoomExtent = new Envelope(mapPoint, zoomWidth, zoomWidth);
                if (map != null) {
                    mapView.setExtent(zoomExtent, 20, true);
                } else {

                    mapView.centerAt(Double.parseDouble(map.get("poiy").toString()), Double.parseDouble(map.get("poix").toString()), true);
                }
//                melocation.setText((int)(mapView.getScale()/100)+"米");
            } else {
                if (map != null) {
                    mapView.centerAt(Double.parseDouble(map.get("poiy").toString()), Double.parseDouble(map.get("poix").toString()), true);
                }
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

    private void infous() {
        if (getIntent().getStringExtra("zhi") != null) {
            sousuokuangxianxian.setVisibility(View.VISIBLE);
            dituxuandianlin.setVisibility(View.GONE);
            common_sousuokuang_shuru.setText(getIntent().getStringExtra("zhi"));
        } else {
            sousuokuangxianxian.setVisibility(View.GONE);
            dituxuandianlin.setVisibility(View.VISIBLE);
        }
        common_sousuokuang_shuru.setOnFocusChangeListener(new View.OnFocusChangeListener() {
            @Override
            public void onFocusChange(View view, boolean b) {
                if (b) {
//                    Intent intent = new Intent(ShowInfoMapActivity.this, SearchInfoActivity.class);
                    Untils.SEARCHMODE = true;
//                    startActivity(intent);
//                    finish();
                    sendDataBack();
                }
            }
        });
    }

    @Event(R.id.bottomshow_jiben)
    private void setOnJibenclick(View view) {
        Intent intent = new Intent(ShowInfoMapActivity.this, BasicInfoActivity.class);
        intent.putExtra("who", "XXX");
        startActivity(intent);
        finish();
    }

    @Event(R.id.common_sousuokuang_sousuo)
    private void setSousuoClick(View view) {
//        finish();
        sendDataBack();
    }

    @Event(R.id.common_sousuokuang_sousuo1)
    private void setBackClick(View view) {
//        finish();
        sendDataBack();
    }

    @Event(R.id.common_sousuokuang_xinxi)
    private void setXinxi(View view) {
        Intent intent = new Intent(ShowInfoMapActivity.this, WodeActivity.class);
        startActivity(intent);
        finish();
    }

    @Event(R.id.common_sousuokuang_shuru)
    private void setShuru(View view) {
        Intent intent = new Intent(ShowInfoMapActivity.this, SearchInfoActivity.class);
        Untils.SEARCHMODE = true;
        startActivity(intent);
        finish();
    }

    @Event(R.id.show_info_go)
    private void setClickdaohang(View view) {
        Mstore mstore = new Mstore();
        mstore.setSad("我的位置");
        mstore.setSlat(Baseactivity.lat + "");
        mstore.setSlon(Baseactivity.lon + "");
        mstore.setDad(map.get("name").toString());
        mstore.setDlon(map.get("poix").toString());
        mstore.setDlat(map.get("poiy").toString());
        Untils.ditu(ShowInfoMapActivity.this, mstore);

    }

    @Event(R.id.daozhequ)
    private void setClickdaozhe(View view) {
        Mstore mstore = new Mstore();
        mstore.setSad("我的位置");
        mstore.setSlat(Baseactivity.lat + "");
        mstore.setSlon(Baseactivity.lon + "");
        mstore.setDad(map.get("name").toString());
        mstore.setDlon(map.get("poix").toString());
        mstore.setDlat(map.get("poiy").toString());
        Untils.ditu(ShowInfoMapActivity.this, mstore);
    }
}
