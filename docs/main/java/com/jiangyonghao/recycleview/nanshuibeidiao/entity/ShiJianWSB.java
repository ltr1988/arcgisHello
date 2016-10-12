package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

/**
 * Created by user on 2016/9/6.
 */
public class ShiJianWSB {
    private String id;
    private String title;
    private String occurTime;
    private String occurLocation;
    private String creatorName;
    private String departName;
    private String status;


    public ShiJianWSB(String id, String title, String occurTime, String occurLocation, String creatorName, String departName, String status) {
        this.id = id;
        this.title = title;
        this.occurTime = occurTime;
        this.occurLocation = occurLocation;
        this.creatorName = creatorName;
        this.departName = departName;
        this.status = status;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getOccurTime() {
        return occurTime;
    }

    public void setOccurTime(String occurTime) {
        this.occurTime = occurTime;
    }

    public String getOccurLocation() {
        return occurLocation;
    }

    public void setOccurLocation(String occurLocation) {
        this.occurLocation = occurLocation;
    }

    public String getCreatorName() {
        return creatorName;
    }

    public void setCreatorName(String creatorName) {
        this.creatorName = creatorName;
    }

    public String getDepartName() {
        return departName;
    }

    public void setDepartName(String departName) {
        this.departName = departName;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}
