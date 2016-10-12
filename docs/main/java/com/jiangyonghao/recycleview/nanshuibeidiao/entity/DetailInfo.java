package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

/**
 * Created by user on 2016/8/23.
 */
public class DetailInfo {
    private String title;
    private String neirong;

    public DetailInfo(String title, String neirong) {
        this.title = title;
        this.neirong = neirong;
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
}
