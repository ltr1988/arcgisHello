package com.hvit.tianditu;

import android.app.Activity;
import android.os.Bundle;


import com.esri.android.map.MapView;
import com.esri.android.map.event.OnZoomListener;


public class TianDiTuActivity extends Activity {
	
	MapView mMapView ;
	TianDiTuTiledMapServiceLayer t_vec;
	TianDiTuTiledMapServiceLayer t_cva;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

		mMapView  = (MapView) findViewById(R.id.map_mapView);;
		t_vec = new TianDiTuTiledMapServiceLayer(TianDiTuTiledMapServiceType.VEC_C);
		mMapView.addLayer(t_vec);
		t_cva = new TianDiTuTiledMapServiceLayer(TianDiTuTiledMapServiceType.CVA_C);
		mMapView.addLayer(t_cva);
		mMapView.setOnZoomListener(new OnZoomListener() {
		
		@Override
		public void preAction(float paramFloat1, float paramFloat2,
				double paramDouble) {
			// TODO Auto-generated method stub
			//缩放后
			//map_tidiOld2.clearTiles();
			//map_tidiOld2.refresh();
		}
		
		@Override
		public void postAction(float paramFloat1, float paramFloat2,
				double paramDouble) {
			// TODO Auto-generated method stub
			//缩放前 防止标注重叠
			//map_tidiOld2.clearTiles();
			t_cva.refresh();
		}
	});
    }

	@Override 
	protected void onDestroy() { 
		super.onDestroy();
 }
	@Override
	protected void onPause() {
		super.onPause();
		mMapView.pause();
 }
	@Override 	protected void onResume() {
		super.onResume(); 
		mMapView.unpause();
	}

}