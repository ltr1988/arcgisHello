//
//  ViewController.m
//  arcgisHelloworld
//
//  Created by fifila on 16/6/9.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapViewController.h"
#import "MapViewController+Action.h"

#import <objc/runtime.h>
#import "RouteManager.h"
#import "DetailInfoViewController.h"
#import "ItemCallOutView.h"
#import "CallOutItem.h"
#import "CommonDefine.h"
#import "AppDelegate.h"
#import "MapViewManager.h"

@interface MapViewController () <UIAlertViewDelegate,AGSMapViewTouchDelegate, AGSCalloutDelegate, AGSIdentifyTaskDelegate, AGSQueryTaskDelegate,AGSMapViewLayerDelegate>
{
    NSString *ip;
    UIAlertView *alart;
    UIView *maskView;
}
@property (nonatomic, strong) AGSIdentifyTask *identifyTask;
@property (nonatomic, strong) AGSQueryTask *queryTask;
@property (nonatomic, strong) AGSPoint* mappoint;

@property (nonatomic, strong) NSMutableArray *featureLayers;
@end

@implementation MapViewController

-(BOOL) hideNavBar
{
    return YES;
}


-(void) viewWillAppear:(BOOL)animated
{
    self.mapView = [MapViewManager sharedMapView];
    self.mapView.frame = self.view.bounds;
    [self.view insertSubview:self.mapView atIndex:0];
    self.mapView.touchDelegate = self;
    self.mapView.callout.delegate = self;
    self.mapView.layerDelegate = self;
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.mapView removeFromSuperview];
    self.mapView.touchDelegate = nil;
    self.mapView.callout.delegate = nil;
    self.mapView.layerDelegate = nil;
    self.mapView = nil;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.featureLayers = [NSMutableArray array];
    ip = HOSTIP;
    [self setupSubviews];
    
    //create identify task
    [self doReload];
    
    
}

-(void) doReload
{
    self.identifyTask = [AGSIdentifyTask identifyTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:WMSRESTURL,ip]]];
    self.identifyTask.delegate = self;
    self.queryTask = [AGSQueryTask queryTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:WMSREST_FIND_URL,ip]]];
    self.queryTask.delegate = self;
}

-(UIView*) pickPointView
{
    float height = CGRectGetHeight(self.tabBarController.tabBar.frame);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-30-height, kScreenWidth, 30)];
    view.tag = 998;
    view.backgroundColor = [UIColor whiteColor];
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
                                   
                                                                       toSpatialReference:[AGSSpatialReference wgs84SpatialReference]];
    
    [[RouteManager sharedInstance] setPoint:CGPointMake(point.x, point.y)];
    [self.tabBarController setSelectedIndex:1];
}

-(void) setupSubviews
{
   // [self.view]
    //[self.view addSubview:[self pickPointView]];
    
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 40, 40)];
    btn.backgroundColor = [UIColor blueColor];
    [btn setTitle:@"定位" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(actionNavigation) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius = 20;
    [self.view addSubview:btn];
    
    UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(80, 20, 40, 40)];
    btnSearch.backgroundColor = [UIColor yellowColor];
    [btnSearch setTitle:@"搜索" forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(actionSearch) forControlEvents:UIControlEventTouchUpInside];
    btnSearch.layer.cornerRadius = 20;
    [self.view addSubview:btnSearch];
    
    UIButton *btnNavi = [[UIButton alloc] initWithFrame:CGRectMake(20, 80, 40, 40)];
    btnNavi.backgroundColor = [UIColor greenColor];
    [btnNavi setTitle:@"导航" forState:UIControlStateNormal];
    [btnNavi addTarget:self action:@selector(navi) forControlEvents:UIControlEventTouchUpInside];
    btnNavi.layer.cornerRadius = 20;
    [self.view addSubview:btnNavi];
    
    UIButton *btnTest = [[UIButton alloc] initWithFrame:CGRectMake(20, 140, 40, 40)];
    btnTest.backgroundColor = [UIColor redColor];
    [btnTest setTitle:@"配置" forState:UIControlStateNormal];
    [btnTest addTarget:self action:@selector(actionConfig) forControlEvents:UIControlEventTouchUpInside];
    btnTest.layer.cornerRadius = 20;
    [self.view addSubview:btnTest];
    
    alart = [[UIAlertView alloc] initWithTitle:@"配置" message:@"设置服务器地址" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alart.alertViewStyle = UIAlertViewStylePlainTextInput;
    alart.delegate = self;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-80, kScreenWidth, 80)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    UIButton *btn1,*btn2,*btn3,*btn4;
    
    float width = kScreenWidth/4.0;
    float x = 0;
    
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(x, 20, width, 40)];
    btn1.backgroundColor = [UIColor greenColor];
    btn1.layer.borderColor = [UIColor whiteColor].CGColor;
    btn1.layer.borderWidth = 0.5;
    btn1.layer.cornerRadius = 20;
    [btn1 addTarget:self action:@selector(actionSearchUpload) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"巡查填报" forState:UIControlStateNormal];
    
    x = CGRectGetMaxX(btn1.frame);
    btn2 = [[UIButton alloc] initWithFrame:CGRectMake(x, 20, width, 40)];
    btn2.backgroundColor = [UIColor redColor];
    btn2.layer.borderColor = [UIColor whiteColor].CGColor;
    btn2.layer.borderWidth = 0.5;
    btn2.layer.cornerRadius = 20;
    [btn2 addTarget:self action:@selector(actionEventUpload) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"事件上报" forState:UIControlStateNormal];
    
    x = CGRectGetMaxX(btn2.frame);
    btn3 = [[UIButton alloc] initWithFrame:CGRectMake(x, 20, width, 40)];
    btn3.backgroundColor = [UIColor purpleColor];
    btn3.layer.borderColor = [UIColor whiteColor].CGColor;
    btn3.layer.borderWidth = 0.5;
    btn3.layer.cornerRadius = 20;
    [btn3 addTarget:self action:@selector(actionQRCodeSwipe) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"扫一扫" forState:UIControlStateNormal];
    
    x = CGRectGetMaxX(btn3.frame);
    btn4 = [[UIButton alloc] initWithFrame:CGRectMake(x, 20, width, 40)];
    btn4.backgroundColor = [UIColor lightGrayColor];
    btn4.layer.borderColor = [UIColor whiteColor].CGColor;
    btn4.layer.borderWidth = 0.5;
    btn4.layer.cornerRadius = 20;
    [btn4 addTarget:self action:@selector(actionQRCodeMyWork) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTitle:@"我的工作" forState:UIControlStateNormal];
    
    [bottomView addSubview:btn1];
    
    [bottomView addSubview:btn2];
    [bottomView addSubview:btn3];
    [bottomView addSubview:btn4];
    
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

-(void) actionConfig
{
    [alart show];
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
    [self.view addSubview:imageView];
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
    // identifyParams.layerIds = self.featureLayers;
    AGSIdentifyParameters *identifyParams = [AGSIdentifyParameters new];
    identifyParams.tolerance = 10;
    identifyParams.geometry = self.mappoint;
    identifyParams.dpi = 96;
    identifyParams.size = self.mapView.bounds.size;
    identifyParams.mapEnvelope = self.mapView.visibleArea.envelope;
    identifyParams.returnGeometry = YES;
    identifyParams.layerOption = AGSIdentifyParametersLayerOptionVisible;
    identifyParams.spatialReference = self.mapView.spatialReference;
    
    //execute the task
    [self.identifyTask executeWithParameters:identifyParams];
    
}
//#pragma mark - AGSCalloutDelegate methods
////show the attributes if accessory button is clicked
//- (void) didClickAccessoryButtonForCallout:(AGSCallout *)callout	{
//    
//    //save the selected graphic, to later assign to the results view controller
//    
//    DetailInfoViewController *detailVC = [[DetailInfoViewController alloc] initWithData:calloutInfo];
//    
//    [self.navigationController pushViewController:detailVC animated:YES];
//}


- (void)queryTask:(AGSQueryTask *)queryTask operation:(NSOperation*)op didExecuteWithFeatureSetResult:(AGSFeatureSet *)featureSet
{
    
}


-(void) findTask:(NSString *)key
{
    [self test];
    AGSQuery *query = [AGSQuery query];
    query.text =key;
    query.returnGeometry = YES;
    query.outSpatialReference = self.mapView.spatialReference;
    [self.queryTask executeWithQuery:query];
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
            
            NSString *name = [((AGSIdentifyResult*)[results objectAtIndex:i]).feature  attributeAsStringForKey:@"名称"];
            if (!name)
                name = [((AGSIdentifyResult*)[results objectAtIndex:i]).feature  attributeAsStringForKey:@"Name"];
            if (!name)
                continue;
            
            ItemCallOutView *calloutView = [[ItemCallOutView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
            self.mapView.callout.customView = calloutView;

            CallOutItem *item = [[CallOutItem alloc] init];
            item.title = name;
            item.moreInfo = [[((AGSIdentifyResult*)[results objectAtIndex:i]).feature allAttributes] copy];
            calloutView.model = (id<ItemCallOutViewModel>)item;
            
            calloutView.moreInfoCallback = ^(NSDictionary *moreInfo){
                    DetailInfoViewController *detailVC = [[DetailInfoViewController alloc] initWithData:moreInfo];
                
                    [self.navigationController pushViewController:detailVC animated:YES];
            };

            
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


#pragma mark - actions
-(void) actionSearch
{
    [self findTask:@"兴寿"];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    
    //if mapscale changed
//    if([keyPath isEqual:@"mapAnchor"]){
//        [self addSymbol];
//    }
}
#pragma mark - AGSMapViewLayerDelegate
    
-(void) mapViewDidLoad:(AGSMapView*)mapView {
    
    [self actionNavigation];
}



@end


