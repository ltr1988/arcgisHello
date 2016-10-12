package com.jiangyonghao.recycleview.nanshuibeidiao.common;

import java.util.HashMap;
import java.util.Map;

import android.Manifest;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;

import com.jiangyonghao.recycleview.nanshuibeidiao.view.GpsKaiqi;

/**获得当前经纬度工具类*/
public class LongLatitudeUtils {
	// private static Context context;
	private static String serviceName = Context.LOCATION_SERVICE;
	private static LocationManager locationManager;
	/** 纬度 */
	private static double lat;
	/** 经度 */
	private static double lng;
	Criteria criteria;
	String provider;
	public static long refresh_time = 6000;
	private SharedPreferences prefs;
	// private Location location;

	public LongLatitudeUtils(Context context) {
		// TODO Auto-generated constructor stub
		super();
		// this.context = context;
		prefs=context.getSharedPreferences("timeAccount", Context.MODE_PRIVATE);
		refresh_time=Integer.parseInt(prefs.getString("time", "1"))*60*1000;
		initLocation(context);
	}

	private void initLocation(Context context) {
		if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
			if (context.checkSelfPermission(Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && context.checkSelfPermission(Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
				// TODO: Consider calling
				//    Activity#requestPermissions
				// here to request the missing permissions, and then overriding
				//   public void onRequestPermissionsResult(int requestCode, String[] permissions,
				//                                          int[] grantResults)
				// to handle the case where the user grants the permission. See the documentation
				// for Activity#requestPermissions for more details.
				return;
			}
		}
		// initGPS(locationManager);
		criteria = new Criteria();
		criteria.setAccuracy(Criteria.ACCURACY_FINE);
		criteria.setAltitudeRequired(false);
		criteria.setBearingRequired(false);
		criteria.setCostAllowed(true);
		criteria.setPowerRequirement(Criteria.POWER_HIGH);
		provider = locationManager.getBestProvider(criteria, true);
		Location location = locationManager.getLastKnownLocation(provider);
		if(location!=null){
			updateWithNewLocation(location);}
		locationManager.requestLocationUpdates(provider,5000, 10,locationListener);
//		locationManager.requestLocationUpdates(provider, 5000, 10, locationListener);

	}

	/**
	 * 根据GPS状态初始化设置
	 *
	 * @return
	 */
	public static boolean initGPS(final Context context) {
//		locationManager = (LocationManager) context
//				.getSystemService(serviceName);
		locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
		// 通过GPS卫星定位，定位级别可以精确到街（通过24颗卫星定位，在室外和空旷的地方定位准确�?��?�度快）
		boolean gps = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
		// Log.e("isProviderEnabled", locationManager
		// .isProviderEnabled(LocationManager.NETWORK_PROVIDER)+"**");
		boolean flag = false;
		if (!gps) {
			GpsKaiqi gpsKaiqi = new GpsKaiqi(context, "GPS已关闭,为了获取天气,请开启!");
			gpsKaiqi.setCanceledOnTouchOutside(false);
			gpsKaiqi.show();
		} else {
			flag = true;
		}
		return flag;
	}
	public static boolean initGPS1(final Context context) {
//		locationManager = (LocationManager) context
//				.getSystemService(serviceName);
		locationManager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
		// 通过GPS卫星定位，定位级别可以精确到街（通过24颗卫星定位，在室外和空旷的地方定位准确�?��?�度快）
		boolean gps = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER);
		// Log.e("isProviderEnabled", locationManager
		// .isProviderEnabled(LocationManager.NETWORK_PROVIDER)+"**");
		boolean flag = false;
		if (!gps) {
//			GpsKaiqi gpsKaiqi = new GpsKaiqi(context, "GPS已关闭,为了精准定位,请开启!");
//			gpsKaiqi.setCanceledOnTouchOutside(false);
//			gpsKaiqi.show();
		} else {
			flag = true;
		}
		return flag;
	}
	// public static double[] getLonglatitude() {
	// double[] longlatitude = new double[2];
	// longlatitude[0] = getLatLongTitude().get("经度");
	// longlatitude[2] = getLatLongTitude().get("纬度");
	//
	// return longlatitude;
	// }

	private LocationListener locationListener = new LocationListener() {
		public void onLocationChanged(Location location) {
			updateWithNewLocation(location);
		}

		public void onProviderDisabled(String provider) {
			updateWithNewLocation(null);
		}

		public void onProviderEnabled(String provider) {
		}

		public void onStatusChanged(String provider, int status, Bundle extras) {
		}
	};

	public void updateWithNewLocation(Location location) {

		// Map<String, Double> LatLongTitude = new HashMap<String, Double>();

		try {
			Thread.sleep(0);// 因为真机获取gps数据需要一定的时间，为了保证获取到，采取系统休眠的延迟方法
		} catch (InterruptedException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}
		if (location != null) {
			double lat = location.getLatitude();
			double lng = location.getLongitude();
			LongLatitudeUtils.lat = lat;
			LongLatitudeUtils.lng = lng;

		} else {
//			provider = locationManager.getBestProvider(criteria, true);
//			Location location1 = locationManager.getLastKnownLocation(provider);
//			updateWithNewLocation(location);
//			locationManager.requestLocationUpdates(provider, refresh_time, 10,
//					locationListener);
			double lat = 0;
			double lng = 0;
			LongLatitudeUtils.lat = lat;
			LongLatitudeUtils.lng = lng;

		}
	}

	public Map<String, Double> getLatLongTitude() {

		Map<String, Double> LatLongTitude = new HashMap<String, Double>();
//		LatLongTitude.put("纬度", lat==0?29.161756:lat);
//		LatLongTitude.put("经度", lng==0?116.17218:lng);
		LatLongTitude.put("纬度", lat);
		LatLongTitude.put("经度", lng);
		//洪河47.723621 133.612976
//		LatLongTitude.put("纬度",lat==0? 47.723621:lat);
//		LatLongTitude.put("经度", lng==0? 133.612976:lng);

		return LatLongTitude;
	}
}
