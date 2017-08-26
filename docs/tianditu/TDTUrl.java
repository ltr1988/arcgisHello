package com.jiangyonghao.recycleview.nanshuibeidiao.tianditu;

import com.esri.android.map.MapView;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.UploadUrl;

import java.util.Random;


public class TDTUrl  {
    private TianDiTuTiledMapServiceType _tiandituMapServiceType;
    private int _level;
    private int _col;
    private int _row;
    public TDTUrl(int level, int col, int row,TianDiTuTiledMapServiceType tiandituMapServiceType){
        this._level=level;
        this._col=col;
        this._row=row;
        this._tiandituMapServiceType=tiandituMapServiceType;
    }
    public String generatUrl(){
        /**
         * 天地图矢量、影像
         * */
        StringBuilder url=new StringBuilder(UploadUrl.tianditu+"/gxpt/service/wmts?SERVICE=WMTS&VERSION=1.0.0&REQUEST=GetTile");
//        Random random=new Random();
//        int subdomain = (random.nextInt(6) + 1);
//        url.append(subdomain);
        switch(this._tiandituMapServiceType){
            case VEC_C:
                url.append(".tianditu.com/DataServer?T=vec_c&X=").append(this._col).append("&Y=").append(this._row).append("&L=").append(this._level);
                //url.append(".tianditu.com/vec_c/wmts?request=GetTile&service=wmts&version=1.0.0&layer=vec&style=default&format=tiles&TileMatrixSet=c&TILECOL=").append(this._col).append("&TILEROW=").append(this._row).append("&TILEMATRIX=").append(this._level);
                //url.append(".tianditu.com/DataServer?T=vec_w&X=").append(this._col).append("&Y=").append(this._row).append("&L=").append(this._level);
                break;
            case CVA_C:
                url.append(".tianditu.com/DataServer?T=cva_c&X=").append(this._col).append("&Y=").append(this._row).append("&L=").append(this._level);
                //url.append(".tianditu.com/DataServer?T=cva_w&X=").append(this._col).append("&Y=").append(this._row).append("&L=").append(this._level);
                break;
            case CIA_C:
                url.append(".tianditu.com/DataServer?T=cia_c&X=").append(this._col).append("&Y=").append(this._row).append("&L=").append(this._level);
                break;
            case IMG_C:
                url.append(".tianditu.com/DataServer?T=img_c&X=").append(this._col).append("&Y=").append(this._row).append("&L=").append(this._level);
                break;
            case CIVGPS:
                url.append("&LAYER="
                        + "nsbdbasemap" + "&STYLE=default&FORMAT=image/png&tilematrixset="
                        + "nsbdbasemap" + "&tilecol=").append(this._col).append("&tilerow=").append(this._row).append("&tilematrix=nsbdbasemap:").append(this._level);
                break;
            case CIVYINGXIANG:
                url.append("&LAYER="
                        + "nsbdbasemap_img" + "&STYLE=default&FORMAT=image/png&tilematrixset="
                        + "nsbdbasemap" + "&tilecol=").append(this._col).append("&tilerow=").append(this._row).append("&tilematrix=nsbdbasemap:").append(this._level);
                break;
            default:
                return null;
        }
        return url.toString();
    }

}
