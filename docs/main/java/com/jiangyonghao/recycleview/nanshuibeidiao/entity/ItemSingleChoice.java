package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

/**
 * Created by administrator on 2016/8/29.
 */
public class ItemSingleChoice {
    private String neirong;
    private boolean choice;
    private String key;

    public ItemSingleChoice(String neirong, boolean choice) {
        this.neirong = neirong;
        this.choice = choice;
    }
    public ItemSingleChoice(String neirong, boolean choice,String key) {
        this.neirong = neirong;
        this.choice = choice;
        this.key= key;
    }
    public String getNeirong() {
        return neirong;
    }

    public void setNeirong(String neirong) {
        this.neirong = neirong;
    }

    public boolean isChoice() {
        return choice;
    }

    public void setChoice(boolean choice) {
        this.choice = choice;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    @Override
    public String toString() {
        return "ItemSingleChoice{" +
                "neirong='" + neirong + '\'' +
                ", choice=" + choice +
                ", key='" + key + '\'' +
                '}';
    }
}
