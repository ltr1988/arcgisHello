package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

/**
 * 网络排气井号.
 */
public class NetDatalistEntity {
    private String number;
    private String id;
    private String name;
    private String starttime;
    private String endtime;
    public NetDatalistEntity(String number) {
        this.number = number;
    }

    public NetDatalistEntity(String id, String name, String starttime, String endtime) {
        this.id = id;
        this.name = name;
        this.starttime = starttime;
        this.endtime = endtime;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getStarttime() {
        return starttime;
    }

    public String getEndtime() {
        return endtime;
    }

    public String getNumber() {
        return number;
    }

}
