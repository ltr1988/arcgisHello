//
//  TiandituTileOperation.m
//  CustomTiledLayerSample
//
//  Created by EsriChina_Mobile_MaY on 13-3-27.
//
//

#import "TianDiTuWMTSTileOperation.h"
#import "TianDiTuWMTSLayer.h"


#define kURLGetTile @"%@?service=wmts&request=gettile&version=1.0.0&layer=nsbdbasemap&format=image/png&tilematrixset=nsbdbasemap&tilecol=%d&tilerow=%d&tilematrix=nsbdbasemap:%d"

#define kURLGetImageTile @"%@?service=wmts&request=gettile&version=1.0.0&layer=nsbdbasemap_img&format=image/png&tilematrixset=nsbdbasemap_img&tilecol=%d&tilerow=%d&tilematrix=nsbdbasemap_img:%d"

@implementation TianDiTuWMTSTileOperation


- (id)initWithTileKey:(AGSTileKey *)tileKey TiledLayerInfo:(TianDiTuWMTSLayerInfo *)layerInfo target:(id)target action:(SEL)action{
	
	if (self = [super init]) {
		self.target = target;
		self.action = action;
		self.tileKey = tileKey;
		self.layerInfo = layerInfo;
	}
    return self;
}

-(void)main {
	//Fetch the tile for the requested Level, Row, Column
	@try {
        if (self.tileKey.level > self.layerInfo.maxZoomLevel ||self.tileKey.level < self.layerInfo.minZoomLevel) {
            return;
        }
        NSString *format = (self.layerInfo.mapType == NSBD_NORMAL)?kURLGetTile:kURLGetImageTile;
        NSString *baseUrl= [NSString stringWithFormat:format,self.layerInfo.url,self.tileKey.column,self.tileKey.row,self.tileKey.level];
        NSLog(baseUrl);
		NSURL* aURL = [NSURL URLWithString:baseUrl];
		self.imageData = [[NSData alloc] initWithContentsOfURL:aURL];
	}
	@catch (NSException *exception) {
		NSLog(@"main: Caught Exception %@: %@", [exception name], [exception reason]);
	}
	@finally {
		//Invoke the layer's action method
		[_target performSelector:_action withObject:self];
	}
    
}
@end
