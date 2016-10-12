package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

import android.graphics.drawable.Drawable;

/**
 * Created by user on 2016/8/23.
 */
public class SheBeiInfo {
    private String title;
    private String neirong;
    private String into;

    public SheBeiInfo(String title, String neirong, String into) {
        this.title=title;
        this.neirong=neirong;
        this.into=into;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getNeirong() {
        return neirong;
    }

    public void setNeirong(String neirong) {
        this.neirong = neirong;
    }

    public String getInto() {
        return into;
    }

    public void setInto(String into) {
        this.into = into;
    }
}
