package com.jiangyonghao.recycleview.nanshuibeidiao.tianditu;

import android.util.Log;

import com.esri.android.map.TiledServiceLayer;
import com.esri.core.geometry.Envelope;
import com.esri.core.geometry.Point;
import com.esri.core.geometry.SpatialReference;
import com.esri.core.io.UserCredentials;

import java.io.BufferedInputStream;
import java.io.ByteArrayOutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.concurrent.RejectedExecutionException;

public class TianDiTuTiledMapServiceLayer extends TiledServiceLayer {
    private TianDiTuTiledMapServiceType _mapType;
    private TileInfo tiandituTileInfo;
    public TianDiTuTiledMapServiceLayer() {
        this(null, null,true);
    }
    public TianDiTuTiledMapServiceLayer(TianDiTuTiledMapServiceType mapType){
        this(mapType, null,true);
    }

    public TianDiTuTiledMapServiceLayer(TianDiTuTiledMapServiceType mapType,UserCredentials usercredentials){
        this(mapType, usercredentials, true);
    }
    public TianDiTuTiledMapServiceLayer(TianDiTuTiledMapServiceType mapType, UserCredentials usercredentials, boolean flag){
        super("");
        this._mapType=mapType;
        setCredentials(usercredentials);

        if(flag)
            try
            {
                getServiceExecutor().submit(new Runnable() {

                    public final void run()
                    {
                        a.initLayer();
                    }

                    final TianDiTuTiledMapServiceLayer a;


                    {
                        a = TianDiTuTiledMapServiceLayer.this;
                        //super();
                    }
                });
                return;
            }
            catch(RejectedExecutionException _ex) { }
    }
    public TianDiTuTiledMapServiceType getMapType(){
        return this._mapType;
    }
    protected void initLayer(){
        this.buildTileInfo();
        this.setFullExtent(new Envelope(-180,-90,180,90));
//        this.setDefaultSpatialReference(SpatialReference.create(4490));   //CGCS2000
        this.setDefaultSpatialReference(SpatialReference.create(4326));
        this.setInitialExtent(new Envelope(102.869399,35.258727,130.055181,49.897225));
        super.initLayer();
    }
    public void refresh()
    {
        try
        {
            getServiceExecutor().submit(new Runnable() {

                public final void run()
                {
                    if(a.isInitialized())
                        try
                        {
                            a.b();
                            a.clearTiles();
                            return;
                        }
                        catch(Exception exception)
                        {
                            Log.e("ArcGIS", "Re-initialization of the layer failed.", exception);
                        }
                }

                final TianDiTuTiledMapServiceLayer a;


                {
                    a = TianDiTuTiledMapServiceLayer.this;
                    //super();
                }
            });
            return;
        }
        catch(RejectedExecutionException _ex)
        {
            return;
        }
    }
    final void b()
            throws Exception
    {

    }

    @Override
    protected byte[] getTile(int level, int col, int row) throws Exception {
        /**
         *
         * */

        byte[] result = null;
        try {
            ByteArrayOutputStream bos = new ByteArrayOutputStream();

            URL sjwurl = new URL(this.getTianDiMapUrl(level, col, row));
            HttpURLConnection httpUrl = null;
            BufferedInputStream bis = null;
            byte[] buf = new byte[1024];

            httpUrl = (HttpURLConnection) sjwurl.openConnection();
            httpUrl.connect();
            bis = new BufferedInputStream(httpUrl.getInputStream());

            while (true) {
                int bytes_read = bis.read(buf);
                if (bytes_read > 0) {
                    bos.write(buf, 0, bytes_read);
                } else {
                    break;
                }
            }
            ;
            bis.close();
            httpUrl.disconnect();

            result = bos.toByteArray();
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        return result;
    }


    @Override
    public TileInfo getTileInfo(){
        return this.tiandituTileInfo;
    }
    /**
     *
     * */
    private String getTianDiMapUrl(int level, int col, int row){

        String url=new TDTUrl(level,col,row,this._mapType).generatUrl();
        return url;
    }

    private void buildTileInfo()
    {
        Point originalPoint=new Point(115.416683,41.059251);
//        Point originalPoint=new Point(115.416683,41.532368999999996);
        double[] scales = {3241812.067640091,1620906.0338200454,810453.0169100227,405226.50845501135,202613.25422750568,101306.62711375284,50653.31355687642,25326.65677843821,12663.328389219105,6331.664194609552,3165.832097304776,1582.916048652388,791.458024326194,395.729012163097,197.8645060815485,98.93225304077426,49.46612652038713,24.733063260193564,12.366531630096782,6.183265815048391};
        double[] resolutions = {0.008168804687499975, 0.004084402343749988, 0.002042201171874994, 0.001021100585937497, 5.105502929687485E-4, 2.5527514648437423E-4, 1.2763757324218711E-4, 6.381878662109356E-5, 3.190939331054678E-5, 1.595469665527339E-5, 7.977348327636695E-6, 3.988674163818347E-6, 1.9943370819091737E-6, 9.971685409545868E-7, 4.985842704772934E-7, 2.492921352386467E-7, 1.2464606761932335E-7, 6.232303380966168E-8, 3.116151690483084E-8, 1.558075845241542E-8};

        int levels=18;
        int dpi=96;
        int tileWidth=256;
        int tileHeight=256;
        this.tiandituTileInfo=new com.esri.android.map.TiledServiceLayer.TileInfo(originalPoint, scales, resolutions, levels, dpi, tileWidth,tileHeight);
        this.setTileInfo(this.tiandituTileInfo);
    }

}
