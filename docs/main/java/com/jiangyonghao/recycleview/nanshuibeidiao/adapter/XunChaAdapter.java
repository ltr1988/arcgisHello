package com.jiangyonghao.recycleview.nanshuibeidiao.adapter;

import android.content.Context;
import android.content.Intent;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.BaseAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.jiangyonghao.recycleview.nanshuibeidiao.R;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.ChooseshijsbActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.DaNingDoublePaiActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.DongGanQufenshuiActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.DongGanQupaikongActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.DongGanQupaiqiActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.GuanXianActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.HistoryXunChaActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.ListGuanXianActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.SouthGQGuanXianActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.SouthGQPaiKJActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.SouthGQPaiQFActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.XunChaActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.activity.XunChaNetlistActivity;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.DataTools;
import com.jiangyonghao.recycleview.nanshuibeidiao.common.Untils;
import com.jiangyonghao.recycleview.nanshuibeidiao.commondb.HelperDb;
import com.jiangyonghao.recycleview.nanshuibeidiao.entity.XunChaInfo;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * Created by user on 2016/8/15.
 */
public class XunChaAdapter extends BaseAdapter {
    List<XunChaInfo> list = new ArrayList<XunChaInfo>();
    LayoutInflater inflater = null;
    Context context = null;
    HelperDb helperDb = null;
    ArrayList<HashMap<String, String>> mapList = null;
    String wode="";

    public XunChaAdapter(Context context) {
        this.context = context;
        inflater = LayoutInflater.from(context);
        helperDb = new HelperDb(context);
        mapList = new ArrayList<>();
    }


    public void addDatas(List<XunChaInfo> li) {
        list.addAll(li);
        notifyDataSetChanged();
    }

    @Override
    public int getCount() {
        return list.size();
    }

    @Override
    public Object getItem(int position) {
        return list.get(position);
    }

    @Override
    public long getItemId(int position) {
        return position;
    }

    @Override
    public View getView(final int position, View convertView, ViewGroup parent) {
        ViewHolder holder = null;
        if (convertView == null) {
            holder = new ViewHolder();
            convertView = inflater.inflate(R.layout.item_for_xuncha, null);
            holder.textView_neirong = (TextView) convertView.findViewById(R.id.textView_xuncha_neirong);
            holder.textView_hint = (TextView) convertView.findViewById(R.id.textView_xuncha_hint);
            holder.imageView_into = (ImageView) convertView.findViewById(R.id.imageView_xuncha_into);
            convertView.setTag(holder);
        } else {
            holder = (ViewHolder) convertView.getTag();
        }
        holder.textView_neirong.setText(list.get(position).getNeirong());
        holder.textView_hint.setText(list.get(position).getHint());
        convertView.setOnClickListener(new View.OnClickListener() {
            Intent intent;
                                           @Override
                                           public void onClick(View v) {
                                               if (list.get(position).getNeirong().equals("大宁管线")) {//暂时模拟 以后改成应有的模块
                                                   Untils.caremtype = Untils.daningguanxianType;
                                                   if (Untils.isWode){
                                                       intent=new Intent(context, ListGuanXianActivity.class);
                                                   }else{
                                                       mapList = helperDb.getLinepipelist(Untils.daningguanxianType, Untils.starttime, Untils.noupload,Untils.guanxian);
                                                       if (mapList.size() > 0) {//如果isupload=0存在证明任务中存在未完成的管线表单，进入未完成
                                                           intent = new Intent(context, ListGuanXianActivity.class);//调到list管线然后选择进入哪一个管线列表
                                                           intent.putExtra("未完成", (Serializable) mapList);
                                                       } else {
                                                           intent = new Intent(context, GuanXianActivity.class);
                                                       }
                                                   }
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("type", Untils.daningguanxianType);
                                                   context.startActivity(intent);

                                               } else if (list.get(position).getNeirong().equals("东干渠管线")) {//暂时模拟 以后改成应有的模块
                                                   Intent intent = null;
                                                   Untils.caremtype = Untils.dongganquguanxianType;
                                                   if (Untils.isWode){
                                                       intent = new Intent(context, ListGuanXianActivity.class);//调到list管线然后选择进入哪一个管线列表
                                                   }else {
                                                       mapList = helperDb.getLinepipelist(Untils.dongganquguanxianType, Untils.starttime, Untils.noupload,Untils.guanxian);
                                                       if (mapList.size() > 0) {//如果isupload=0存在证明任务中存在未完成的管线表单，进入未完成
                                                           intent = new Intent(context, ListGuanXianActivity.class);//调到list管线然后选择进入哪一个管线列表
                                                           intent.putExtra("未完成", (Serializable) mapList);
//                                                       Untils.isUncompleted = true;
                                                       } else {
                                                           intent = new Intent(context, GuanXianActivity.class);
                                                       }
                                                   }

                                                   intent.putExtra("code",list.get(position).getCode());
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("type", Untils.dongganquguanxianType);
                                                   context.startActivity(intent);
                                               } else if (list.get(position).getNeirong().equals("东干渠排气阀井")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.dongganqupaiqiType;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.dongganpaiqi);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   context.startActivity(intent);
                                               } else if (list.get(position).getNeirong().equals("东干渠排空井")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.dongganqupaikongType;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.dongganpaikong);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   context.startActivity(intent);
                                               } else if (list.get(position).getNeirong().equals("东干渠分水口")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.dongganqufenshuiType;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.dongganqufen);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   context.startActivity(intent);

                                               } else if (list.get(position).getNeirong().equals("南干渠排空井上段")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.nanganqupaikongjingshang;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.nanqupaikongxia);
                                                   intent.putExtra("type",Untils.nanganqupaikongjingshang);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   context.startActivity(intent);
                                               } else if (list.get(position).getNeirong().equals("南干渠排空井下段")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.nanganqupaikongjingxia;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.nanqupaikongxia);
                                                   intent.putExtra("type",Untils.nanganqupaikongjingxia);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   context.startActivity(intent);
                                               } else if (list.get(position).getNeirong().equals("南干渠排气阀井上段")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.nanganqupaiqifashang;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.nanganpaiqishang);
                                                   intent.putExtra("type",Untils.nanganqupaiqifashang);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   context.startActivity(intent);

                                               } else if (list.get(position).getNeirong().equals("南干渠排气阀井下段")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.nanganqupaiqifaxia;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.nanganpaiqishang);
                                                   intent.putExtra("type",Untils.nanganqupaiqifaxia);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   context.startActivity(intent);
                                               } else if (list.get(position).getNeirong().equals("南干渠管线")) {
                                                   Intent intent = null;
                                                   Untils.caremtype = Untils.nanganquguanxianType;
                                                   if (Untils.isWode){
                                                       intent = new Intent(context, ListGuanXianActivity.class);//调到list管线然后选择进入哪一个管线列表

                                                   }else {
                                                       mapList = helperDb.getLinepipelist(Untils.nanganquguanxianType, Untils.starttime, Untils.noupload,Untils.nanganlinepipe);
                                                       if (mapList.size() > 0) {//如果isupload=0存在证明任务中存在未完成的管线表单，进入未完成
                                                           intent = new Intent(context, ListGuanXianActivity.class);//调到list管线然后选择进入哪一个管线列表
                                                           intent.putExtra("未完成", (Serializable) mapList);
                                                       } else {
                                                           intent = new Intent(context, SouthGQGuanXianActivity.class);
                                                       }
                                                   }

                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("type", Untils.nanganquguanxianType);
                                                   context.startActivity(intent);
                                               } else if (list.get(position).getNeirong().equals("大宁排气阀井")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.daningpaiqifajing;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.daning);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   intent.putExtra("type", Untils.daningpaiqifajing);//大宁排气阀井
                                                   context.startActivity(intent);

                                               } else if (list.get(position).getNeirong().equals("大宁排空井")) {
                                                   intent= new Intent(context, XunChaNetlistActivity.class);
                                                   Untils.caremtype = Untils.daningpaikongjing;
                                                   intent.putExtra("time", Untils.time);
                                                   intent.putExtra("nameType",Untils.daning);
                                                   intent.putExtra("code",list.get(position).getCode());
                                                   intent.putExtra("type", Untils.daningpaikongjing);//大宁排k井
                                                   context.startActivity(intent);
                                               }
//                                               if (list.get(position).getNeirong().equals("大宁管线")) {//暂时模拟 以后改成应有的模块
//                                                   Intent intent = null;
//                                                   Untils.caremtype = Untils.daningguanxianType;
//                                                   mapList = helperDb.getLinepipelist(Untils.daningguanxianType, Untils.starttime, Untils.noupload,Untils.guanxian);
//                                                   if (mapList.size() > 0) {//如果isupload=0存在证明任务中存在未完成的管线表单，进入未完成
//                                                       intent = new Intent(context, ListGuanXianActivity.class);//调到list管线然后选择进入哪一个管线列表
//                                                       intent.putExtra("未完成", (Serializable) mapList);
//                                                   } else {
//                                                       intent = new Intent(context, GuanXianActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.daningguanxianType);
//                                                   context.startActivity(intent);
//
//
//                                               } else if (list.get(position).getNeirong().equals("东干渠管线")) {//暂时模拟 以后改成应有的模块
//                                                   Intent intent = null;
//                                                   Untils.caremtype = Untils.dongganquguanxianType;
//                                                   mapList = helperDb.getLinepipelist(Untils.dongganquguanxianType, Untils.starttime, Untils.noupload,Untils.guanxian);
//                                                   if (mapList.size() > 0) {//如果isupload=0存在证明任务中存在未完成的管线表单，进入未完成
//                                                       intent = new Intent(context, ListGuanXianActivity.class);//调到list管线然后选择进入哪一个管线列表
//                                                       intent.putExtra("未完成", (Serializable) mapList);
////                                                       Untils.isUncompleted = true;
//                                                   } else {
//                                                       intent = new Intent(context, GuanXianActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.dongganquguanxianType);
//                                                   context.startActivity(intent);
//                                               } else if (list.get(position).getNeirong().equals("东干渠排气阀井")) {
//                                                   Intent intent;
//                                                   Untils.caremtype = Untils.dongganqupaiqiType;
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.dongganqupaiqiType, Untils.dongganpaiqi );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.dongganpaiqi);
//                                                   } else {
//                                                       intent = new Intent(context, DongGanQupaiqiActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   context.startActivity(intent);
//                                               } else if (list.get(position).getNeirong().equals("东干渠排空井")) {
//                                                   Intent intent;
//                                                   Untils.caremtype = Untils.dongganqupaikongType;
//                                                   Log.e("dd", "onClick: "+Untils.starttime );
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.dongganqupaikongType, Untils.dongganpaikong );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.dongganpaikong);
//                                                   } else {
//                                                       intent = new Intent(context, DongGanQupaikongActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//
//                                                   context.startActivity(intent);
//                                               } else if (list.get(position).getNeirong().equals("东干渠分水口")) {
//                                                   Untils.caremtype = Untils.dongganqufenshuiType;
//                                                   Intent intent;
//
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.dongganqufenshuiType, Untils.dongganqufen );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.dongganqufen);
//                                                   } else {
//                                                       intent = new Intent(context, DongGanQufenshuiActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   context.startActivity(intent);
//
//                                               } else if (list.get(position).getNeirong().equals("南干渠排空井上段")) {
//                                                   Intent intent;
//                                                   Untils.caremtype = Untils.nanganqupaikongjingshang;
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.nanganqupaikongjingshang, Untils.nanqupaikongxia );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.nanqupaikongxia);
//                                                   } else {
//                                                       intent = new Intent(context, SouthGQPaiKJActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.nanganqupaikongjingshang);//南干渠排空井上段
//                                                   context.startActivity(intent);
//                                               } else if (list.get(position).getNeirong().equals("南干渠排空井下段")) {
//                                                   Intent intent;
//                                                   Untils.caremtype = Untils.nanganqupaikongjingxia;
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.nanganqupaikongjingxia, Untils.nanqupaikongxia );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.nanqupaikongxia);
//                                                   } else {
//                                                       intent = new Intent(context, SouthGQPaiKJActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.nanganqupaikongjingxia);//南干渠排空井上段
//                                                   context.startActivity(intent);
//                                               } else if (list.get(position).getNeirong().equals("南干渠排气阀井上段")) {
//                                                   Untils.caremtype = Untils.nanganqupaiqifashang;
//                                                   Intent intent;
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.nanganqupaiqifashang, Untils.nanganpaiqishang );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.nanganpaiqishang);
//                                                   } else {
//                                                       intent = new Intent(context, SouthGQPaiQFActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.nanganqupaiqifashang);//南干渠排气阀井上段
//                                                   context.startActivity(intent);
//                                               } else if (list.get(position).getNeirong().equals("南干渠排气阀井下段")) {
//                                                   Intent intent;
//                                                   Untils.caremtype = Untils.nanganqupaiqifaxia;
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.nanganqupaiqifaxia, Untils.nanganpaiqishang );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.nanganpaiqishang);
//                                                   } else {
//                                                       intent = new Intent(context, SouthGQPaiQFActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.nanganqupaiqifaxia);//南干渠排气阀井下段
//                                                   context.startActivity(intent);
//                                               } else if (list.get(position).getNeirong().equals("南干渠管线")) {
////                                                   Intent intent;
////                                                   Untils.caremtype = Untils.nanganquguanxianType;
////                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.nanganquguanxianType, Untils.nanganlinepipe);
////                                                   if (datalist.size() != 0) {
////                                                       intent = new Intent(context, ChooseshijsbActivity.class);
////                                                       intent.putExtra("Activity", Untils.nanganlinepipe);
////                                                   } else {
////                                                       intent = new Intent(context, SouthGQGuanXianActivity.class);
////                                                   }
////                                                   intent.putExtra("time", Untils.time);
////                                                   intent.putExtra("type", Untils.nanganquguanxianType);//南干渠管线
////                                                   context.startActivity(intent);
//
//
//
//
//
//                                                   Intent intent = null;
//                                                   Untils.caremtype = Untils.nanganquguanxianType;
//                                                   mapList = helperDb.getLinepipelist(Untils.nanganquguanxianType, Untils.starttime, Untils.noupload,Untils.nanganlinepipe);
//                                                   if (mapList.size() > 0) {//如果isupload=0存在证明任务中存在未完成的管线表单，进入未完成
//                                                       intent = new Intent(context, ListGuanXianActivity.class);//调到list管线然后选择进入哪一个管线列表
//                                                       intent.putExtra("未完成", (Serializable) mapList);
//                                                   } else {
//                                                       intent = new Intent(context, SouthGQGuanXianActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.nanganquguanxianType);
//                                                   context.startActivity(intent);
//
//                                               } else if (list.get(position).getNeirong().equals("大宁排气阀井")) {
//                                                   Intent intent;
//                                                   Untils.caremtype = Untils.daningpaiqifajing;
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.daningpaiqifajing, Untils.daning );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.daning);
//                                                   } else {
//                                                       intent = new Intent(context, DaNingDoublePaiActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.daningpaiqifajing);//大宁排气阀井
//                                                   context.startActivity(intent);
//                                               } else if (list.get(position).getNeirong().equals("大宁排空井")) {
//                                                   Intent intent;
//                                                   Untils.caremtype = Untils.daningpaikongjing;
//                                                   ArrayList<HashMap<String, String>> datalist = helperDb.getDatalist("0", Untils.daningpaikongjing, Untils.daning );
//                                                   if (datalist.size() != 0) {
//                                                       intent = new Intent(context, ChooseshijsbActivity.class);
//                                                       intent.putExtra("Activity", Untils.daning);
//                                                   } else {
//                                                       intent = new Intent(context, DaNingDoublePaiActivity.class);
//                                                   }
//                                                   intent.putExtra("time", Untils.time);
//                                                   intent.putExtra("type", Untils.daningpaikongjing);//大宁排空井
//                                                   context.startActivity(intent);
//                                                   Untils.setIssave();
//                                               }
                                           }
                                       }

        );
        return convertView;
    }

    public class ViewHolder {
        TextView textView_neirong, textView_hint;
        ImageView imageView_into;
    }
}
