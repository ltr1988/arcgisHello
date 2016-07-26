//
//  CommonDefine.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#define WMSURL @"http://%@:6080/arcgis/services/nsbd_gongcheng_test/MapServer/WMSServer"
#define WMSRESTURL @"http://%@:6080/arcgis/rest/services/nsbd_gongcheng_test/MapServer/"
#define WMTSRESTURL @"http://%@:6080/arcgis/rest/services/test_BJDLG/MapServer"
#define WMS_FIND_URL @"http://%@:6080/arcgis/services/nsbd_gongcheng_all/MapServer/WMSServer"

#define WMSREST_FIND_URL @"http://%@:6080/arcgis/rest/services/nsbd_gongcheng_all/MapServer/0"

#define HOSTIP @"192.168.1.101"

#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}


//此宏使用的是copy，即：OBJC_ASSOCIATION_COPY_NONATOMIC
#define ADD_DYNAMIC_PROPERTY(PROPERTY_TYPE,PROPERTY_NAME,SETTER_NAME) \
@dynamic PROPERTY_NAME; \
static char kProperty##PROPERTY_NAME; \
- ( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
return ( PROPERTY_TYPE ) objc_getAssociatedObject(self, &(kProperty##PROPERTY_NAME)); \
} \
\
- (void) SETTER_NAME :( PROPERTY_TYPE ) PROPERTY_NAME \
{ \
objc_setAssociatedObject(self, &(kProperty##PROPERTY_NAME), PROPERTY_NAME, OBJC_ASSOCIATION_COPY_NONATOMIC); \
} \

//block
typedef void (^ActionCallback)();

//Font
#define UI_FONT(size) [UIFont systemFontOfSize:size]
#define UI_BOLD_FONT(size) [UIFont boldSystemFontOfSize:size]

//Color
#define UI_COLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define UI_COLOR_A(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define UI_COLOR_HEX(hex) [UIColor colorWithRed:((hex & 0xFF0000) >> 16)/255.0f green:((hex & 0x00FF00) >> 8)/255.0f blue:(hex & 0x0000FF)/255.0f alpha:1]
#define HEXCOLOR(c) [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:((c)&0xFF)/255.0  alpha:((c>>24)&0xFF)/255.0]

#define UIImageViewDefaultColor UI_COLOR(0xf2, 0xf2, 0xf2)


#endif /* CommonDefine_h */
