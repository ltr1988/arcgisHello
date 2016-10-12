package com.jiangyonghao.recycleview.nanshuibeidiao.entity;

/**
 * Created by user on 2016/8/29.
 */
public class ItemChoice {
    private String title;
    private String neirongzuo;
    private boolean choicezuo;
    private String neirongyou;
    private boolean choiceyou;

    public ItemChoice(String title, String neirongzuo, boolean choicezuo, String neirongyou, boolean choiceyou) {
        this.title = title;
        this.neirongzuo = neirongzuo;
        this.choicezuo = choicezuo;
        this.neirongyou = neirongyou;
        this.choiceyou = choiceyou;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getNeirongzuo() {
        return neirongzuo;
    }

    public void setNeirongzuo(String neirongzuo) {
        this.neirongzuo = neirongzuo;
    }

    public boolean isChoicezuo() {
        return choicezuo;
    }

    public void setChoicezuo(boolean choicezuo) {
        this.choicezuo = choicezuo;
    }

    public String getNeirongyou() {
        return neirongyou;
    }

    public void setNeirongyou(String neirongyou) {
        this.neirongyou = neirongyou;
    }

    public boolean isChoiceyou() {
        return choiceyou;
    }

    public void setChoiceyou(boolean choiceyou) {
        this.choiceyou = choiceyou;
    }
}
