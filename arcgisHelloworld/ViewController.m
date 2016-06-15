//
//  ViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/9.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "ViewController.h"
#import <Arcgis/Arcgis.h>
#import <objc/runtime.h>
#import "RouteManager.h"
#import "DetailInfoViewController.h"

#define WMSURL @"http://%@:6080/arcgis/services/nsbd_gongcheng_test/MapServer/WMSServer"
#define WMSRESTURL @"http://%@:6080/arcgis/rest/services/nsbd_gongcheng_test/MapServer/"
#define WMTSRESTURL @"http://%@:6080/arcgis/rest/services/test_BJDLG/MapServer"


@interface ViewController () <UIAlertViewDelegate,AGSMapViewTouchDelegate, AGSCalloutDelegate, AGSIdentifyTaskDelegate,AGSMapViewLayerDelegate>
{
    NSString *ip;
    NSDictionary *calloutInfo;
    UIAlertView *alart;
}
@property (weak, nonatomic) IBOutlet AGSMapView *mapView;
@property (nonatomic, strong) AGSIdentifyTask *identifyTask;
@property (nonatomic, strong) AGSIdentifyParameters *identifyParams;
@property (nonatomic, strong) AGSPoint* mappoint;

@property (nonatomic, strong) NSMutableArray *featureLayers;
@end

@implementation ViewController

- (void) viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void) viewWillDisappear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.mapView.touchDelegate = self;
    self.mapView.callout.delegate = self;
    
    self.featureLayers = [NSMutableArray array];
    self.mapView.layerDelegate = self;

    [self setupSubviews];
    ip = @"192.168.1.106";
    
    //create identify task
    [self doReload];
    
    
    //create identify parameters
    self.identifyParams = [[AGSIdentifyParameters alloc] init];
}

-(void) doReload
{
    [self setupLayers];
    self.identifyTask = [AGSIdentifyTask identifyTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:WMSRESTURL,ip]]];
    self.identifyTask.delegate = self;
}

-(UIView*) pickPointView
{
    float height = CGRectGetHeight(self.tabBarController.tabBar.frame);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-30-height, kScreenWidth, 30)];
    view.tag = 998;
    //view.hidden = YES;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor blackColor];
    [view addSubview:label];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(kScreenWidth - 40, 3, 40, 24)];
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pickPoint) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [view addSubview:btn];
    return view;
}

-(void)pickPoint
{
    AGSPoint *point = (AGSPoint *)[[AGSGeometryEngine defaultGeometryEngine] projectGeometry:self.mapView.mapAnchor
                                   
                                                                       toSpatialReference:[AGSSpatialReference webMercatorSpatialReference]];
    
    [[RouteManager sharedInstance] setPoint:CGPointMake(point.x, point.y)];
    [self.tabBarController setSelectedIndex:1];
}

-(void) setupSubviews
{
    [self.view addSubview:[self pickPointView]];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(navigationAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 20;
    [self.mapView addSubview:btn];
    
    UIButton *btnNavi = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 40, 40)];
    btnNavi.backgroundColor = [UIColor greenColor];
    [btnNavi setTitle:@"导航" forState:UIControlStateNormal];
    [btnNavi addTarget:self action:@selector(navi) forControlEvents:UIControlEventTouchUpInside];
    btnNavi.layer.cornerRadius = 20;
    [self.mapView addSubview:btnNavi];
    
    UIButton *btnTest = [[UIButton alloc] initWithFrame:CGRectMake(20, 140, 40, 40)];
    btnTest.backgroundColor = [UIColor redColor];
    [btnTest setTitle:@"配置" forState:UIControlStateNormal];
    [btnTest addTarget:self action:@selector(config) forControlEvents:UIControlEventTouchUpInside];
    btnTest.layer.cornerRadius = 20;
    [self.mapView addSubview:btnTest];
    
    alart = [[UIAlertView alloc] initWithTitle:@"配置" message:@"设置服务器地址" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alart.alertViewStyle = UIAlertViewStylePlainTextInput;
    alart.delegate = self;
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"Cancel"]) {
        NSLog(@"你点击了退出");
        
        
    }
    else if ([btnTitle isEqualToString:@"OK"] ) {
        UITextField *tf = [alart textFieldAtIndex:0];
        ip = tf.text;
        [self doReload];
    }
    [alart dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

-(void) config
{
    [alart show];
}

-(void) setupLayers
{
    if ([self.mapView mapLayers].count>0) {
        for (AGSLayer *layer in [[self.mapView mapLayers] copy]) {
            [self.mapView removeMapLayer:layer];
        }
    }
    //AGSCredential *credentail = [[AGSCredential alloc] initWithUser:@"arcgis" password:@"arcgis"];
    AGSTiledMapServiceLayer *tiledLayer = [[AGSTiledMapServiceLayer alloc] initWithURL:[NSURL URLWithString:
                                                                                        [NSString stringWithFormat:WMTSRESTURL,ip]]];
    
    
    
    AGSWMSLayer *wmsLayer =  [[AGSWMSLayer alloc] initWithURL:[NSURL URLWithString:
                                                               [NSString stringWithFormat:WMSURL,ip]]];

    
    AGSGraphicsLayer *glayer = [AGSGraphicsLayer graphicsLayer];
    
    //Add it to the map view
    [self.mapView addMapLayer:tiledLayer withName:@"Tiled Layer"];
    [self.mapView addMapLayer:wmsLayer withName:@"WMS Layer"];
    [self.mapView addMapLayer:glayer withName:@"Graphics Layer"];
    
    
    
}



-(void) addSymbol
{
    UIImageView *view = [self.mapView viewWithTag:999];
    if (view) {
        return;
    }
    
    UIImage *image = [UIImage imageNamed:@"RedPushpin"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.tag = 999;
    [imageView setCenter:self.mapView.center];
    [self.mapView addSubview:imageView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    //Pass the interface orientation on to the map's gps so that
    //it can re-position the gps symbol appropriately in
    //compass navigation mode
    self.mapView.locationDisplay.interfaceOrientation = interfaceOrientation;
    return YES;
}


- (void)viewDidUnload {
    //Stop the GPS, undo the map rotation (if any)
    if(self.mapView.locationDisplay.dataSourceStarted){
        [self.mapView.locationDisplay stopDataSource];
        self.mapView.rotationAngle = 0;
    }
    self.mapView = nil;
}


#pragma mark - AGSMapViewTouchDelegate methods

- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features{
    
    [self test];
    //store for later use
    self.mappoint = mappoint;
    
    //the layer we want is layer ‘5’ (from the map service doc)
   // self.identifyParams.layerIds = self.featureLayers;
    self.identifyParams.tolerance = 10;
    self.identifyParams.geometry = self.mappoint;
    self.identifyParams.dpi = 96;
    self.identifyParams.size = self.mapView.bounds.size;
    self.identifyParams.mapEnvelope = self.mapView.visibleArea.envelope;
    self.identifyParams.returnGeometry = YES;
    self.identifyParams.layerOption = AGSIdentifyParametersLayerOptionVisible;
    self.identifyParams.spatialReference = self.mapView.spatialReference;
    
    //execute the task
    [self.identifyTask executeWithParameters:self.identifyParams];
    
}
#pragma mark - AGSCalloutDelegate methods
//show the attributes if accessory button is clicked
- (void) didClickAccessoryButtonForCallout:(AGSCallout *)callout	{
    
    //save the selected graphic, to later assign to the results view controller
    
    DetailInfoViewController *detailVC = [[DetailInfoViewController alloc] initWithData:calloutInfo];
    
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - AGSIdentifyTaskDelegate methods
//results are returned
- (void)identifyTask:(AGSIdentifyTask *)identifyTask operation:(NSOperation *)op didExecuteWithIdentifyResults:(NSArray *)results {
    
    if ([results count] > 0) {
        
        //set the callout content for the first result
        //get the state name
        
        
        for (int i =0; i<[results count]; i++) {
            if (![((AGSIdentifyResult*)[results objectAtIndex:i]).feature.geometry isKindOfClass:[AGSPoint class]]) {
                continue;
            }
            
            NSString *name = [((AGSIdentifyResult*)[results objectAtIndex:i]).feature  attributeAsStringForKey:@"Name"];
            if (!name)
                continue;
            self.mapView.callout.title = name;
            self.mapView.callout.detail = @"Click for more detail..";
            
            calloutInfo = [[((AGSIdentifyResult*)[results objectAtIndex:i]).feature allAttributes] copy];
            
            
            //show callout
            [self.mapView.callout showCalloutAtPoint:self.mappoint forFeature:((AGSIdentifyResult*)[results objectAtIndex:0]).feature layer:((AGSIdentifyResult*)[results objectAtIndex:0]).feature.layer animated:YES];
            return;
        }
        
        
    }
    
    
}


//if there's an error with the query display it to the user
- (void)identifyTask:(AGSIdentifyTask *)identifyTask operation:(NSOperation *)op didFailWithError:(NSError *)error {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                    message:[error localizedDescription]
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

-(void) test
{
    AGSWMSLayer *layer = (AGSWMSLayer *)[self.mapView mapLayerForName:@"WMS Layer"];
    if (!layer.loaded || self.featureLayers.count>0) {
        return;
    }
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList(NSClassFromString(@"AGSWMSLayer"), &numIvars);
    //Ivar *vars = class_copyIvarList([UIView class], &numIvars);
    
    NSString *key=nil,*layerName=nil;
    for(int i = 0; i < numIvars; i++) {
        
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        
        if ([key isEqualToString:@"_layerNames"]) {
            
            layerName = (NSString *)object_getIvar(layer, thisIvar);
            break;
        }
    }
    
    free(vars);
    
    NSArray *layerNames = [layerName componentsSeparatedByString:@","];
    
    [self.featureLayers removeAllObjects];
    for (NSString* name in layerNames) {
        [self.featureLayers addObject: [NSNumber numberWithInteger:[name integerValue]]];
    }
    
}


-(void) navigationAction
{
    if(!self.mapView.locationDisplay.dataSourceStarted)
        [self.mapView.locationDisplay startDataSource];
    
    [self.mapView addObserver:self
                   forKeyPath:@"mapScale"
                      options:(NSKeyValueObservingOptionNew)
                      context:NULL];
  
    self.mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanModeDefault;
    
    //Set a wander extent equal to 75% of the map's envelope
    //The map will re-center on the location symbol only when
    //the symbol moves out of the wander extent
    self.mapView.locationDisplay.wanderExtentFactor = 0.75;
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    //if mapscale changed
//    if([keyPath isEqual:@"mapAnchor"]){
//        [self addSymbol];
//    }
}
#pragma mark AGSMapViewLayerDelegate
    
-(void) mapViewDidLoad:(AGSMapView*)mapView {
    
    [self navigationAction];
}


#pragma mark route-navi
-(void) navi
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    NSString *app_Name = [infoDictionary objectForKey:@"CFBundleName"];
    
    BOOL hasBaiduMap = NO;
    BOOL hasGaodeMap = NO;
    
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
        hasBaiduMap = YES;
    }
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]){
        hasGaodeMap = YES;
    }
    
    
    float currentLat,currentLon,_shopLat,_shopLon;
    if ([RouteManager sharedInstance].startPoint.x == 0 && [RouteManager sharedInstance].startPoint.y==0) {
        currentLon = self.mapView.locationDisplay.location.point.x;
        currentLat = self.mapView.locationDisplay.location.point.y;
    }else
    {
        currentLon = [RouteManager sharedInstance].startPoint.x;
        currentLat = [RouteManager sharedInstance].startPoint.y;
    }
    
    if ([RouteManager sharedInstance].endPoint.x == 0 && [RouteManager sharedInstance].endPoint.y==0) {
        _shopLon = self.mapView.locationDisplay.location.point.x;
        _shopLat = self.mapView.locationDisplay.location.point.y;
    }else
    {
        _shopLon = [RouteManager sharedInstance].endPoint.x;
        _shopLat = [RouteManager sharedInstance].endPoint.y;
    }

    if (hasBaiduMap)
    {
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:终点&mode=driving",currentLat, currentLon,_shopLat,_shopLon] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    }
    else if (hasGaodeMap)
    {
        
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=1&m=0&t=0",app_Name, currentLat, currentLon, @"我的起点" , _shopLat, _shopLon,@"我的终点"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
    }
}

@end


