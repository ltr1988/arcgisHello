package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

import java.io.Serializable;

/**
 * Created by user on 2016/8/15.
 */
public class XunChaInfo implements Serializable{
    private String neirong;
    private String code;
    public XunChaInfo(String neirong, String hint) {
        this.neirong = neirong;
        this.hint = hint;
    }
    public XunChaInfo(String neirong, String hint,String code) {
        this.neirong = neirong;
        this.hint = hint;
        this.code=code;
    }
    private String hint;
    public String getHint() {
        return hint;
    }

    public void setHint(String hint) {
        this.hint = hint;
    }

    public String getNeirong() {
        return neirong;
    }

    public void setNeirong(String neirong) {
        this.neirong = neirong;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }
}
