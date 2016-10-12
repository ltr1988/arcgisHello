package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

/**
 * Created by user on 2016/9/5.
 */
public class WaitInfo {
    private String id;
    private String title;
    private String occurTime;
    private String occurLocation;
    private String creatorName;
    private String departName;
    private String category;
    private String responseLevel;

    public WaitInfo(String id, String title, String occurTime, String occurLocation, String creatorName, String departName, String category, String responseLevel) {
        this.id = id;
        this.title = title;
        this.occurTime = occurTime;
        this.occurLocation = occurLocation;
        this.creatorName = creatorName;
        this.departName = departName;
        this.category = category;
        this.responseLevel = responseLevel;
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

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getResponseLevel() {
        return responseLevel;
    }

    public void setResponseLevel(String responseLevel) {
        this.responseLevel = responseLevel;
    }
}
