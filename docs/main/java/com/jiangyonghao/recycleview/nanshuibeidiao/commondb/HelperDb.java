package com.jiangyonghao.recycleview.nanshuibeidiao.commondb;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.util.Log;

import com.jiangyonghao.recycleview.nanshuibeidiao.common.SharedprefrenceHelper;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.database.SCardDatabase;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ImageItem;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.ShiJianWSB;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class HelperDb extends SCardDatabase {

    private static final String DIR = Untils.SDpath + Untils.databasefoldername;
    private static String NAME = Untils.database;
    private static final int VERSION = 1;
    private Context context;
    private Map<String, String> map;
    private String sql = " where type=? and starttime =? ";
    private String sql3 = " where type=? and time =? ";
    private String sql1 = " where type = ? and isupload = ?";
    private String sql2 = " where id=? ";
    private String sqlxun = " where isnew=0 and starttime =? ";
    private String sqlxun1 = " where isnew=0 ";
    private String sql4 = " where starttime = ? and isupload = ? and createtime = ? and type = ? ";
    private String sql5 = " where isupload = ? and type = ? and starttime = ?";
    private String mohuchaxun = " where name like ";
    private String sql6 = " where starttime = ? and isupload = ? and wellnum= ? and type = ? ";
    private String sql7 = " where starttime = ? and isupload = ? and wellnum= ? and type = ? ";
    public HelperDb(Context context) {
        super(context, DIR, NAME, null, VERSION);
        this.context = context;
        super.getWritableDatabase();
    }

/**
 * update 根据id实时修改
 * updatestarttime 根据时间实时修改，这个最好别用，会有错误的地方
 * insertSingleData 插入单条数据
 * delete 删除数据根据id
 * getSingledata 获取单条数据，这个是回显调用的
 * getDatalist 获取多条数据，这是列表用的到的
 */
    /**
     * 实时修改数据库接口
     *
     * @param ID
     * @param key
     * @param value
     * @param table
     */
    public void update(String ID, String key, String value, String table) {
        ContentValues cv = new ContentValues();
        cv.put(key, value);
        super.getWritableDatabase().update(table, cv, "id=?", new String[]{ID});
    }

    public void updatestarttime(String starttime, String key, String value, String table) {
        ContentValues cv = new ContentValues();
        cv.put(key, value);
        super.getWritableDatabase().update(table, cv, "starttime = ?", new String[]{starttime});
    }
    public void updatecreattime(String key, String value) {
        ContentValues cv = new ContentValues();
        cv.put(key, value);
        super.getWritableDatabase().update("searchrecord", cv, "createtime = ?", new String[]{key});
    }

    /**
     * 根据表名往表中插入新数据
     *
     * @param map
     * @param tablename
     */

    public void insertSingleData(HashMap<String, String> map, String tablename) {
        ContentValues cv = new ContentValues();
        String[] fujian = getColumnNames(tablename);
        for (int i = 0; i < fujian.length; i++) {
            cv.put(fujian[i], map.get(fujian[i]));
        }
        super.getWritableDatabase().insert(tablename, null, cv);
        super.close();
    }

    /**
     * 删除数据
     *
     * @param ID
     * @param table
     */
    public void delete(String ID, String table) {
        super.getWritableDatabase().delete(table, "id=?", new String[]{ID});
    }

    public void deletefujian(String starttime, String path) {
        Log.e("dd", "deletefujianxiangdui: " + starttime + path);
        super.getWritableDatabase().delete(Untils.fujian, "time=? and path=?", new String[]{starttime, path});
    }

    public void deletefujianxiangdui(String starttime, String path) {
        Log.e("dd", "deletefujianxiangdui: " + starttime + path);
        super.getWritableDatabase().delete(Untils.fujian, "time=? and xiangdui=?", new String[]{starttime, path});
    }

    /**
     * 查询多条数据以及单条数据
     */
    public HashMap<String, String> getSingledata(String starttime, String isupload, String createtime, String type, String table) {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + table + sql4, new String[]{starttime, isupload, createtime, type});
        String[] fujian = getColumnNames(table);
        while (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }
    public HashMap<String, String> getSingledata2( String wellnum, String type, String table) {
        Cursor cursor = null;
        String csql="";
        if (table.equals(Untils.dongganqufen)){
            csql=sql7;
        }else {
            csql=sql6;
        }

        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + table + csql, new String[]{Untils.starttime, "0", wellnum, type});
        String[] fujian = getColumnNames(table);
        while (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }
    public HashMap<String, String> getSingletufa(String isupload, String starttime, String type, String table) {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + table + sql5, new String[]{isupload,type,starttime});
        String[] fujian = getColumnNames(table);
        while (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }
    public ArrayList<HashMap<String, String>> getDatalist(String isupload, String type, String table) {
        Cursor cursor = null;
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + table + sql5, new String[]{isupload, type,Untils.starttime});
        String[] fujian = getColumnNames(table);
        while (cursor.moveToNext()) {
            HashMap<String, String> map = new HashMap<>();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }
    public ArrayList<HashMap<String, String>> getDatalistjing(String isupload, String type, String table,String jinghao) {
        Cursor cursor = null;
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + table + sql5+" and wellnum = ?", new String[]{isupload, type,Untils.starttime,jinghao});
        String[] fujian = getColumnNames(table);
        while (cursor.moveToNext()) {
            HashMap<String, String> map = new HashMap<>();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }
    /**
     * 我的突发事件上报专用
     * @param isupload
     * @param type
     * @param table
     * @return
     */
    public ArrayList<HashMap<String, String>> getDatalist3(String isupload, String type, String table) {
        Cursor cursor = null;
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + table + sql5, new String[]{isupload, type});
        String[] fujian = getColumnNames(table);
        while (cursor.moveToNext()) {
            HashMap<String, String> map = new HashMap<>();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }
    /**
     * 查询与插入附件表数据
     */
    public ArrayList<ImageItem> getAttachmentformlist(String type, String starttime) {
        Cursor cursor = null;
        ArrayList<ImageItem> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.fujian + sql3 + " order by cuntype asc", new String[]{type, starttime});
        String[] fujian = getColumnNames(Untils.fujian);
        while (cursor.moveToNext()) {
            ImageItem map = new ImageItem();
            for (int i = 0; i < fujian.length; i++) {
//                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
                if (fujian[i].equals(Untils.attachmentform[3])) {
                    map.setSelected(true);

                    map.setImagePath(cursor.getString(cursor.getColumnIndex(fujian[i])));
                } else if (fujian[i].equals(Untils.attachmentform[7])) {
                    map.setType(cursor.getString(cursor.getColumnIndex(fujian[i])));
                } else if (fujian[i].equals(Untils.attachmentform[6])) {
                    map.setPath(cursor.getString(cursor.getColumnIndex(fujian[i])));
                }
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }
    public ArrayList<HashMap> getAttachmentformlist(String id) {
        Cursor cursor = null;
        ArrayList<HashMap> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.fujian +  " where fkid ='"+id+"' order by cuntype asc",null);
        String[] fujian = getColumnNames(Untils.fujian);
        while (cursor.moveToNext()) {
            HashMap map = new HashMap();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }
    public HashMap<String, String> getAttachmentform(String type, String starttime) {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.fujian + sql, new String[]{type, starttime});
        String[] fujian = getColumnNames(Untils.fujian);
        while (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }

    public void setinsertAttachmentform(HashMap<String, String> map) {
        ContentValues cv = new ContentValues();
        String[] fujian = getColumnNames(Untils.fujian);
        for (int i = 0; i < fujian.length; i++) {
            cv.put(fujian[i], map.get(fujian[i]));
        }
        super.getWritableDatabase().insert(Untils.fujian, null, cv);
        super.close();
    }

    /**
     * 查询与插入巡查信息
     */
    public HashMap<String, String> getInspectionmessage(String starttime) {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.xunchaxinxi + sqlxun + " order by starttime desc", new String[]{starttime});
        String[] fujian = getColumnNames(Untils.xunchaxinxi);
        if (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }

    public HashMap<String, String> getInspectionmessage1() {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.xunchaxinxi + sqlxun1+"and name= '"+ SharedprefrenceHelper.getInstance(context).getUsername()+ "' order by starttime desc", null);
        String[] fujian = getColumnNames(Untils.xunchaxinxi);
        if (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        Log.e("ddd", "getInspectionmessage1: "+map.toString() );
        cursor.close();
        super.close();
        return map;
    }

    public void setinsertInspectionmessage(HashMap<String, String> map) {
        ContentValues cv = new ContentValues();
        String[] fujian = getColumnNames(Untils.xunchaxinxi);
        for (int i = 0; i < fujian.length; i++) {
            cv.put(fujian[i], map.get(fujian[i]));
        }
        super.getWritableDatabase().insert(Untils.xunchaxinxi, null, cv);
        super.close();
    }

    /**
     * 查询全部管线表和南干渠管线表
     */
    public ArrayList<HashMap<String, String>> getLinepipelist(String type, String starttime, String upload,String table) {
        Cursor cursor = null;
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " +table + sql + " and isupload =?", new String[]{type, starttime, upload});
        String[] fujian = getColumnNames(table);
        while (cursor.moveToNext()) {
            HashMap<String, String> map = new HashMap<>();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }

    /**
     * 查询单行管线表
     */
    public HashMap<String, String> getLinepipe(String type, String starttime, String creattime) {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.guanxian + sql + " and creattime = ? ", new String[]{type, starttime, creattime});
        String[] fujian = getColumnNames(Untils.guanxian);
        while (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }

    /**
     * 插入管线表
     */
    public void setinsertLinepipe(HashMap<String, String> map) {
        ContentValues cv = new ContentValues();
        String[] fujian = getColumnNames(Untils.guanxian);
        for (int i = 0; i < fujian.length; i++) {
            cv.put(fujian[i], map.get(fujian[i]));
        }
        super.getWritableDatabase().insert(Untils.guanxian, null, cv);
        super.close();
    }

    /**
     * 查询与插入突发表
     */
    public ArrayList<HashMap<String, String>> getEmergencyformlist(String type, String starttime, String upload) {
        Cursor cursor = null;
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.tufashijian + sql + " and isupload =?", new String[]{type, starttime, upload});
        String[] fujian = getColumnNames(Untils.tufashijian);
        while (cursor.moveToNext()) {
            HashMap<String, String> map = new HashMap<>();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }

    /**
     * 查询突发上报是否有未上报
     */

    public ArrayList<HashMap<String, String>> getEmergencylist(String type, String upload) {
        Cursor cursor = null;
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.tufashijian + sql1, new String[]{type, upload});
        String[] fujian = getColumnNames(Untils.tufashijian);
        while (cursor.moveToNext()) {
            HashMap<String, String> map = new HashMap<>();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }

    public HashMap<String, String> getEmergencyform(String type, String starttime) {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.tufashijian + sql, new String[]{type, starttime});
        String[] fujian = getColumnNames(Untils.tufashijian);
        while (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }

    //    根据ID查询 所有相关数据用于回显
    public HashMap<String, String> getEchoMsg(String id,String table) {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + table + sql2, new String[]{id});
        String[] fujian = getColumnNames(table);
        while (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }


    /**
     * 模糊查询搜索记录表
     */
    public ArrayList<HashMap<String, String>> mohuSearchlist(String name) {
        Cursor cursor = null;
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.search + mohuchaxun + "'%" + name + "%'" + " order by " + Untils.searchform[2] + " desc ", null);
        String[] fujian = getColumnNames(Untils.search);
        while (cursor.moveToNext()) {
            HashMap<String, String> map = new HashMap<>();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }
  /**
     * 查询所有搜索记录
     */
    public ArrayList<HashMap<String, String>> getAllSearchlist() {
        Cursor cursor = null;
        ArrayList<HashMap<String, String>> list = new ArrayList<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.search+" order by " + Untils.searchform[2] + " desc ", null);
        String[] fujian = getColumnNames(Untils.search);
        while (cursor.moveToNext()) {
            HashMap<String, String> map = new HashMap<>();
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
            list.add(map);
        }
        cursor.close();
        super.close();
        return list;
    }
    public void updatetime(String name, String key, String value, String table) {
        ContentValues cv = new ContentValues();
        cv.put(key, value);
        super.getWritableDatabase().update(table, cv, "name = ?", new String[]{name});
    }

    /**
     * 查询搜索记录表
     */
    public HashMap<String, String> getjilu(String name, String type) {
        Cursor cursor = null;
        HashMap<String, String> map = new HashMap<>();
        cursor = super.getReadableDatabase().rawQuery("select * from " + Untils.search + " where name = ? and islocate = ?", new String[]{name, type});
        String[] fujian = getColumnNames(Untils.search);
        while (cursor.moveToNext()) {
            for (int i = 0; i < fujian.length; i++) {
                map.put(fujian[i], cursor.getString(cursor.getColumnIndex(fujian[i])));
            }
        }
        cursor.close();
        super.close();
        return map;
    }

    /**
     * 查询全部巡查表
     * @return
     */
    public ArrayList<HashMap<String, String>> getAllXunCha(){
        ArrayList<HashMap<String,String>> AllXunlist=new ArrayList<>();
        return AllXunlist;
    }

    /**
     * @param db
     */
    @Override
    public void onCreate(SQLiteDatabase db) {
        // System.out.println(list.toString());
        String attachmentform = Untils.getAttachmentform("CREATE TABLE 'attachmentform'(");
        String inspectionmessage = Untils.getInspectionmessage("CREATE TABLE 'inspectionmessage'(");
        String linepipe = Untils.getLinepipe("CREATE TABLE 'linepipe'(");
        String emergencyform = Untils.getEmergencyform("CREATE TABLE 'emergencyform'(");
        String searchform = Untils.getSearchForm("CREATE TABLE 'searchrecord'(");
        String daning = Untils.getDaningjingForm("CREATE TABLE 'daning'(");
        String dongganqufenshui = Untils.getDongganqufenshuiForm("CREATE TABLE 'dongganqufenshui'(");
        String dongganpaikong = Untils.getDongganqupaikongForm("CREATE TABLE 'dongganpaikong'(");
        String dongganqupaiqi = Untils.getDongganqupaiqiForm("CREATE TABLE 'dongganpaiqi'(");
        String nanganqulinepipe = Untils.getNanganqulinepipeForm("CREATE TABLE 'nanganlinepipe'(");
//        String nanganpaikongshang = Untils.getNanganqupaikongshangForm("CREATE TABLE 'nanqupaikongshang'(");
        String nanganpaikongxia = Untils.getNanganqupaikongshangForm("CREATE TABLE 'nanqupaikong'(");
        String nanganpaiqishang = Untils.getNanganqupaiqishangForm("CREATE TABLE 'nanganpaiqi'(");
//        String nanganpaiqixia = Untils.getNanganqupaiqixiaForm("CREATE TABLE 'nanganpaiqixia'(");
        db.execSQL(attachmentform);
        db.execSQL(inspectionmessage);
        db.execSQL(linepipe);
        db.execSQL(emergencyform);
        db.execSQL(searchform);
        db.execSQL(daning);
        db.execSQL(dongganqufenshui);
        db.execSQL(dongganpaikong);
        db.execSQL(dongganqupaiqi);
        db.execSQL(nanganqulinepipe);
//        db.execSQL(nanganpaikongshang);
        db.execSQL(nanganpaikongxia);
        db.execSQL(nanganpaiqishang);
//        db.execSQL(nanganpaiqixia);
    }

    @Override
    public void onUpgrade(SQLiteDatabase db, int oldVersion, int newVersion) {
        db.execSQL("drop table if exists attachmentform");
        db.execSQL("drop table if exists inspectionmessage");
        db.execSQL("drop table if exists linepipe");
        db.execSQL("drop table if exists emergencyform");
        db.execSQL("drop table if exists searchrecord");
        db.execSQL("drop table if exists daning");
        db.execSQL("drop table if exists dongganqufenshui");
        db.execSQL("drop table if exists dongganpaikong");
        db.execSQL("drop table if exists dongganpaiqi");
        db.execSQL("drop table if exists nanganlinepipe");
//        db.execSQL("drop table if exists nanqupaikongshang");
        db.execSQL("drop table if exists nanqupaikong");
        db.execSQL("drop table if exists nanganpaiqi");
//        db.execSQL("drop table if exists nanganpaiqixia");
        onCreate(db);
    }

    /**
     * 获取数据库里面的属性
     * <p/>
     * table数据库表的名字
     *
     * @param table
     * @return
     */
    public String[] getColumnNames(String table) {
        String strSql = ("select * FROM " + table);
        Cursor oCursor = null;
        try {
            oCursor = super.getReadableDatabase().rawQuery(strSql, null);
            if (oCursor == null) {
                oCursor.close();
                return null;
            }
            String[] s = oCursor.getColumnNames();
            oCursor.close();
//            super.close();
            return s;
        } catch (Exception e) {
            e.toString();
        }
        return null;
    }


}
