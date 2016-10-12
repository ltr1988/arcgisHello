package com.jiangyonghao.recycleview.nanshuibeidiao.common;

import android.annotation.TargetApi;
import android.app.Activity;
import android.content.Context;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.os.Build;
import android.provider.Settings;
import android.telephony.TelephonyManager;

import java.util.List;

/**
 * Created by jiangyonghao on 2016/8/26.
 */
public class StringUntils {
        /**
         * 检查手机上是否安装了指定的软件
         *
         * @param context
         * @param packageName：应用包名
         * @return
         */
        public static boolean isInstalled(Context context, String packageName) {
            final PackageManager packageManager = context.getPackageManager();
            List<PackageInfo> packageInfos = packageManager.getInstalledPackages(0);
            if (packageInfos != null) {
                for (int i = 0; i < packageInfos.size(); i++) {
                    String pkName = packageInfos.get(i).packageName;
                    if (pkName.equals(packageName)) return true;
                }
            }
            return false;
        }
    // 判断当前设备是否为手机
    public static boolean isPhone(Context context) {
        TelephonyManager telephony = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
        if (telephony.getPhoneType() == TelephonyManager.PHONE_TYPE_NONE) {
            return false;
        } else {
            return true;
        }
    }

    @TargetApi(Build.VERSION_CODES.CUPCAKE)
    public static String getDeviceIMEI(Context context) {
        String deviceId;
        if (isPhone(context)) {
            TelephonyManager telephony = (TelephonyManager) context.getSystemService(Context.TELEPHONY_SERVICE);
            deviceId = telephony.getDeviceId();

        } else {
            deviceId = Settings.Secure.getString(context.getContentResolver(), Settings.Secure.ANDROID_ID);

        }
        return deviceId;
    }
    /**
     * 获取设备型号
     */
    public static String getPhototype(){
        String type= Build.MODEL;
        return type;
    }
    /**
     * 获取设备品牌
     */
    public static String getPhotobrand(){
        String type= Build.BRAND;
        return type;
    }
    /**
     * 获取设备系统版本号  一定要加权限READ_PHONE_STATE
     */
    public static  String getSystemnumber(){
        String number = Build.VERSION.RELEASE;
        return number;
    }
    /**
     * 获取软件的版本号
     */
    public static String getVersion(Context context){
        PackageManager manager = context.getPackageManager();
        try {
            PackageInfo info = manager.getPackageInfo(context.getPackageName(),0);
            String version=info.versionName;
            return version;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "1.0";
    }
    // 判断当前是否有网络连接
    public static boolean isOnline(Context context) {
        ConnectivityManager manager = (ConnectivityManager) context.getSystemService(Activity.CONNECTIVITY_SERVICE);
        NetworkInfo info = manager.getActiveNetworkInfo();
        if (info != null && info.isConnected()) {
            return true;
        }
        return false;
    }
}
