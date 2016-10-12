package com.jiangyonghao.recycleview.nanshuibeidiao.common;

import android.app.Activity;
import android.content.Context;
import android.content.SharedPreferences;

/**
 * Created by jiangyonghao on 2016/8/16.
 */
public class SharedprefrenceHelper {
    private static SharedprefrenceHelper sph = new SharedprefrenceHelper();
    private static SharedPreferences sp;

    private SharedprefrenceHelper() {
    }

    ;

    public static SharedprefrenceHelper getInstance(Context context) {
        if (sp == null) {
            sp = context.getSharedPreferences("myloginshare",
                    Activity.MODE_PRIVATE);
        }
        return sph;
    }

    public void setUsername(String username) {
        sp.edit().putString("username", username).commit();
    }

    public String getUsername() {
        return sp.getString("username", "");
    }

    public void setUserpass(String username) {
        sp.edit().putString("userpass", username).commit();
    }

    public String getUserpass() {
        return sp.getString("userpass", "");
    }

    public void setIsShou(String shouci) {
        sp.edit().putString("shouci", shouci).commit();
    }

    public String getIsShow() {
        return sp.getString("shouci", "false");
    }
    public void settoken(String shouci) {
        sp.edit().putString("token", shouci).commit();
    }

    public String gettoken() {
        return sp.getString("token", "");
    }
}
