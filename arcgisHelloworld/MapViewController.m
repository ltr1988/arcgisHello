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
#import "DetailInfoViewController.h"
#import "ItemCallOutView.h"
#import "CallOutItem.h"
#import "CommonDefine.h"
#import "AppDelegate.h"
#import "UIButton+UIButtonSetEdgeInsets.h"
#import "MapViewManager.h"
#import "WebViewController.h"
#import "MapViewController+InfoMapping.h"
#import "MapSearchInfoViewController.h"
#import "WeatherManager.h"
#import "DepthCalloutView.h"
#import "Search3DHttpManager.h"
#import "Search3DShenMaiModel.h"
#import "Search3DShenMaiItem.h"
#import "MJExtension.h"
#import "UIImageView+AFNetworking.h"
#import "ImageContentViewController.h"
#import "Search3DResultModel.h"
#import "Search3DResultItem.h"

@interface MapViewController () <UIAlertViewDelegate,AGSMapViewTouchDelegate, AGSCalloutDelegate, AGSIdentifyTaskDelegate,AGSMapViewLayerDelegate,AGSLayerDelegate>
{
    UIAlertView *alart;
    UIView *maskView;
}
@property (nonatomic, strong) AGSIdentifyTask *identifyTask;

@end

@implementation MapViewController

-(BOOL) hideNavBar
{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupSubviews];
    
    //create identify task
    
    [self doReloadTask];
    [self setupObservers];
    [[WeatherManager sharedInstance] requestData];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void) setupObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showLocation:) name:@"ShowLocationNotification" object:nil];
}

-(void) doReloadTask
{
    self.identifyTask = [AGSIdentifyTask identifyTaskWithURL:[NSURL URLWithString:[NSString stringWithFormat:WMSRESTURL,[MapViewManager IP]]]];
    self.identifyTask.delegate = self;
}

-(void) setupSubviews
{
    CGFloat btnsize = 36;
    
    CGFloat rightBtnOffsetX = self.view.frame.size.width- btnsize - 20;
    CGFloat rightBtnOffsetY = self.view.frame.size.height- 2 * btnsize - 20 - 70;//70 for bottom view height
    
    CGFloat leftBtnOffsetX = 20;
    
    CGFloat leftPaddingY = 15;
    CGFloat leftBtnOffsetY = self.view.frame.size.height- 2 * btnsize - 20 - leftPaddingY - 70;
    
    CGRect frame;
    
    
    UIButton *btnChangMapType = [[UIButton alloc] initWithFrame:CGRectMake(rightBtnOffsetX, 70, btnsize, btnsize)];
    btnChangMapType.backgroundColor = [UIColor whiteColor];
    btnChangMapType.layer.cornerRadius = 5;
    btnChangMapType.titleLabel.font = [UIFont systemFontOfSize:12];
    [btnChangMapType setTitle:@"影像" forState:UIControlStateNormal];
    [btnChangMapType setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btnChangMapType.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btnChangMapType addTarget:self action:@selector(actionSwitchMapType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnChangMapType];
    
    UIButton *btn3DMaishen = [[UIButton alloc] initWithFrame:CGRectMake(rightBtnOffsetX, 80+btnsize, btnsize, btnsize)];
    btn3DMaishen.backgroundColor = [UIColor whiteColor];
    btn3DMaishen.layer.cornerRadius = 5;
    btn3DMaishen.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn3DMaishen setTitle:@"埋深" forState:UIControlStateNormal];
    [btn3DMaishen setImage:[UIImage imageNamed:@"icon_maishen"] forState:UIControlStateNormal];
    [btn3DMaishen setImage:[UIImage imageNamed:@"icon_maishen"] forState:UIControlStateHighlighted];
    btn3DMaishen.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btn3DMaishen addTarget:self action:@selector(actionSwitch3DMaishenType:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3DMaishen];
    
    
    UIButton *btnMyLocation = [[UIButton alloc] initWithFrame:CGRectMake(leftBtnOffsetX, leftBtnOffsetY, btnsize, btnsize)];
    btnMyLocation.backgroundColor = [UIColor clearColor];
    [btnMyLocation setImage:[UIImage imageNamed:@"icon_map_position"] forState:UIControlStateNormal];
    btnMyLocation.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btnMyLocation addTarget:self action:@selector(actionMyLocation) forControlEvents:UIControlEventTouchUpInside];
    btnMyLocation.clipsToBounds = YES;
    
    btnMyLocation.layer.cornerRadius = btnsize/2;
    [self.view addSubview:btnMyLocation];
    
    frame = btnMyLocation.frame;
    frame.origin.y += btnsize +leftPaddingY;
    
    UIButton *btnNavi = [[UIButton alloc] initWithFrame:frame];
    btnNavi.backgroundColor = [UIColor clearColor];
    [btnNavi setImage:[UIImage imageNamed:@"icon_map_daohang"] forState:UIControlStateNormal];
    btnNavi.imageView.contentMode = UIViewContentModeScaleAspectFit;
    btnNavi.clipsToBounds = YES;
    //    [btnNavi setTitle:@"导航" forState:UIControlStateNormal];
    [btnNavi addTarget:self action:@selector(actionNavi) forControlEvents:UIControlEventTouchUpInside];
    btnNavi.layer.cornerRadius = btnsize/2;
    [self.view addSubview:btnNavi];
    
    
    UIButton *btnSearch = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, self.view.frame.size.width - 40, btnsize)];
    btnSearch.backgroundColor = [UIColor whiteColor];
    btnSearch.layer.cornerRadius = btnsize/2;
    btnSearch.layer.shadowColor = [UIColor blackColor].CGColor;
    btnSearch.layer.shadowRadius = 4;
    btnSearch.layer.shadowOffset = CGSizeMake(4, 4);
    btnSearch.layer.shadowOpacity = 0.8;
    [btnSearch addTarget:self action:@selector(actionSearch) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnSearch];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, btnsize-10, btnsize)];
    imageView.image= [UIImage imageNamed:@"icon_search"];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btnSearch addSubview:imageView];
    
    UILabel *placehoder = [[UILabel alloc] initWithFrame:CGRectMake(10+btnsize, 0, btnSearch.frame.size.width - 10 - btnsize, btnsize)];
    placehoder.textColor = [UIColor grayColor];
    placehoder.text = @"搜索";
    placehoder.font = UI_FONT(14);
    [btnSearch addSubview:placehoder];
    
    
    UIButton *btnZoomIn = [[UIButton alloc] initWithFrame:CGRectMake(rightBtnOffsetX, rightBtnOffsetY, btnsize, btnsize)];
    btnZoomIn.backgroundColor = [UIColor clearColor];
    [btnZoomIn setImage:[UIImage imageNamed:@"btn_fd"] forState:UIControlStateNormal];
    [btnZoomIn setImage:[UIImage imageNamed:@"btn_fd"] forState:UIControlStateSelected];
    btnZoomIn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btnZoomIn addTarget:self action:@selector(actionPlus) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZoomIn];
    
    frame = btnZoomIn.frame;
    frame.origin.y += btnsize;
    UIButton *btnZoomOut = [[UIButton alloc] initWithFrame:frame];
    btnZoomOut.backgroundColor = [UIColor clearColor];
    [btnZoomOut setImage:[UIImage imageNamed:@"btn_sx"] forState:UIControlStateNormal];
    [btnZoomOut setImage:[UIImage imageNamed:@"btn_sx"] forState:UIControlStateSelected];
    btnZoomOut.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [btnZoomOut addTarget:self action:@selector(actionMinus) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:btnZoomOut];
    
    self.mapView = [MapViewManager sharedMapView];
    self.mapView.frame = self.view.bounds;
    [self.view insertSubview:self.mapView atIndex:0];
    self.mapView.touchDelegate = self;
//    self.mapView.callout.delegate = self;
    self.mapView.layerDelegate = self;
    
    [self.mapView mapLayerForName:@"Tiled Layer"].delegate = self;
    [self.mapView mapLayerForName:@"WMS Layer"].delegate = self;
    self.mapView.bottomView = [self bottomView];
    }


-(UIView *) bottomView
{
    float height = 70;
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight-height, kScreenWidth, height)];
    bottomView.backgroundColor = [UIColor clearColor];
    
    
    UIButton *btn1,*btn2,*btn3,*btn4;
    
    float width = kScreenWidth/4.0;
    float x = 0;
    
    btn1 = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    btn1.backgroundColor = [UIColor whiteColor];
    [btn1 setImage:[UIImage imageNamed:@"icon_searchreport"] forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(actionSearchUpload) forControlEvents:UIControlEventTouchUpInside];
    [btn1 setTitle:@"巡查填报" forState:UIControlStateNormal];
    btn1.titleLabel.font = UI_FONT(14);
    
    x = CGRectGetMaxX(btn1.frame);
    btn2 = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    btn2.backgroundColor = [UIColor whiteColor];
    [btn2 setImage:[UIImage imageNamed:@"icon_eventreport"] forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(actionEventUpload) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"事件上报" forState:UIControlStateNormal];
    btn2.titleLabel.font = UI_FONT(14);
    
    x = CGRectGetMaxX(btn2.frame);
    btn3 = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    btn3.backgroundColor = [UIColor whiteColor];
    [btn3 setImage:[UIImage imageNamed:@"icon_swck"] forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(action3D) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"查三维" forState:UIControlStateNormal];
    btn3.titleLabel.font = UI_FONT(14);
    
    x = CGRectGetMaxX(btn3.frame);
    btn4 = [[UIButton alloc] initWithFrame:CGRectMake(x, 0, width, height)];
    btn4.backgroundColor = [UIColor whiteColor];
    [btn4 setImage:[UIImage imageNamed:@"icon_mywork"] forState:UIControlStateNormal];
    [btn4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(actionMyWork) forControlEvents:UIControlEventTouchUpInside];
    [btn4 setTitle:@"更多" forState:UIControlStateNormal];
    btn4.titleLabel.font = UI_FONT(14);
    
    [btn1 verticalCenterImageAndTitle];
    
    [btn2 verticalCenterImageAndTitle];
    [btn3 verticalCenterImageAndTitle];
    [btn4 verticalCenterImageAndTitle];
    
    [bottomView addSubview:btn1];
    [bottomView addSubview:btn2];
    [bottomView addSubview:btn3];
    [bottomView addSubview:btn4];
    
    return bottomView;
}


- (void)viewDidUnload {
    //Stop the GPS, undo the map rotation (if any)
    if(self.mapView.locationDisplay.dataSourceStarted){
        [self.mapView.locationDisplay stopDataSource];
        self.mapView.rotationAngle = 0;
    }
    self.mapView = nil;
}

#pragma mark - alart delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *btnTitle = [alertView buttonTitleAtIndex:buttonIndex];
    if ([btnTitle isEqualToString:@"Cancel"]) {
        NSLog(@"你点击了退出");
        
        
    }
    else if ([btnTitle isEqualToString:@"OK"] ) {
        UITextField *tf = [alart textFieldAtIndex:0];
        [MapViewManager SetIP:tf.text];
        [self doReloadTask];
    }
    [alart dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

-(void) actionConfig
{
    [alart show];
}


#pragma mark - AGSLayerDelegate methods

- (void)layerDidLoad:(AGSLayer *)layer
{
    
}

- (void)layer:(AGSLayer *)layer didFailToLoadWithError:(NSError *)error
{
    if ([layer respondsToSelector:@selector(resubmit)]) {
        [layer performSelector:@selector(resubmit)];
    }else
    {
        [MapViewManager resetLayer:self.mapView];
        [self.mapView mapLayerForName:@"Tiled Layer"].delegate = self;
        [self.mapView mapLayerForName:@"WMS Layer"].delegate = self;
    }
}
#pragma mark - AGSMapViewTouchDelegate methods

- (void)mapView:(AGSMapView *)mapView didClickAtPoint:(CGPoint)screen mapPoint:(AGSPoint *)mappoint features:(NSDictionary *)features{
    
    
    [self.mapView.callout dismiss];
    if ([self loaded3DMap])
        [self requestMaishenWithPoint:mappoint];
    else
        [self identifyPoint:mappoint];
    
    
}

-(void) requestMaishenWithPoint:(AGSPoint *)mappoint
{
    [self.mapView.callout dismiss];
    [[Search3DHttpManager sharedManager] request3DShenMaiWithX:mappoint.x y:mappoint.y SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
        Search3DShenMaiModel *model = [Search3DShenMaiModel objectWithKeyValues:dict];
        if (model && model.datalist.count>0)
        {
            Search3DShenMaiItem *item = model.datalist.firstObject;
            __weak __typeof(self) weakself = self;
            DepthCalloutView *dcallout = [[DepthCalloutView alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
            dcallout.imageTapped = ^(UIImage *image){
                if (image) {
                    
                    ImageContentViewController *vc = [[ImageContentViewController alloc] init];
                    [vc setImage:image];
                    [weakself.navigationController pushViewController:vc animated:YES];
                }
                NSLog(@"tapped");
                
            };

            self.mapView.callout.customView = dcallout;
            if ([item imageUrl]) {
                NSURL * url = [NSURL URLWithString:[item imageUrl]];
                [dcallout.imageView setImageWithURL:url placeholderImage:nil];
            }else
            {
                [dcallout.imageView setImage:nil];
            }
            
            dcallout.lbLine1.text = [NSString stringWithFormat:@"埋深:%@米",item.depth];
            
            [self.mapView.callout showCalloutAt:mappoint screenOffset:CGPointMake(0, 0) animated:YES];
            
        }
    } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
    }];
}

-(void) identifyPoint:(AGSPoint *)mappoint
{
    
    AGSIdentifyParameters *identifyParams = [AGSIdentifyParameters new];
    identifyParams.tolerance = 10;
    identifyParams.geometry = mappoint;
    identifyParams.dpi = 96;
    identifyParams.size = self.mapView.bounds.size;
    identifyParams.mapEnvelope = self.mapView.visibleArea.envelope;
    identifyParams.returnGeometry = YES;
    identifyParams.layerOption = AGSIdentifyParametersLayerOptionVisible;
    identifyParams.spatialReference = self.mapView.spatialReference;
    
    //execute the task
    [self.identifyTask executeWithParameters:identifyParams];
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
            
            self.mapView.callout.customView = nil;
            self.mapView.callout.title = name;
            self.mapView.callout.accessoryButtonHidden = YES;
            AGSPoint * p = (AGSPoint *)((AGSIdentifyResult*)[results objectAtIndex:i]).feature.geometry;
            [self.mapView.callout showCalloutAt:p screenOffset:CGPointMake(0, 0) animated:YES];
//            AGSGraphicsLayer *glayer = (AGSGraphicsLayer *)[self.mapView mapLayerForName:@"Graphics Layer"];
//            if (glayer) {
//                [glayer removeAllGraphics];
//                AGSPictureMarkerSymbol* myPictureSymbol = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImageNamed:@"icon_location"];
//                myPictureSymbol.size = CGSizeMake(36, 36);
//                //向右上方偏移5个像素
//                myPictureSymbol.offset = CGPointMake(0, 18);
//                AGSGraphic *symbol = [AGSGraphic graphicWithGeometry:((AGSIdentifyResult*)[results objectAtIndex:i]).feature.geometry symbol:myPictureSymbol attributes:nil];
//                [glayer addGraphic:symbol];
//            }
            
            NSString *departName = [((AGSIdentifyResult*)[results objectAtIndex:i]).feature  attributeAsStringForKey:@"ManE"];
            ItemCallOutView *calloutView = [[ItemCallOutView alloc] initWithFrame:CGRectMake(0, 0, self.mapView.frame.size.width, 64)];
            self.mapView.infoView = calloutView;
            
            
            NSDictionary *infoDict = [((AGSIdentifyResult*)[results objectAtIndex:i]).feature allAttributes];
            
            NSString *objectNumber = infoDict[@"ObjectNum"];
            
            NSMutableDictionary *convertDict = [NSMutableDictionary dictionary];
            for (NSString *key in infoDict.allKeys) {
                NSString *convertKey = [self stringFromInfoKey:key];
                convertDict[convertKey] = infoDict[key];
            }
            
            dispatch_group_t group = dispatch_group_create();
            
            
            __block NSString *modelUrl = nil;
            if (objectNumber) {
                dispatch_group_enter(group);
                [[Search3DHttpManager sharedManager] request3DModelWithObjectnum:objectNumber SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
                    Search3DResultModel *model = [Search3DResultModel objectWithKeyValues:dict];
                    if (model && model.datalist.count>0) {
                        Search3DResultItem *item = model.datalist.firstObject;
                        modelUrl = [item.modelpath copy];
                    }
                    dispatch_group_leave(group);
                } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                    dispatch_group_leave(group);
                }];
            }
            
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                CallOutItem *item = [[CallOutItem alloc] init];
                item.title = name;
                item.detail = departName?:@"";
                item.moreInfo = [convertDict copy];
                
                if (nil != modelUrl) {
                    
                    item.webSiteInfo = @{@"modelUrl":modelUrl};
                }
                calloutView.model = (id<ItemCallOutViewModel>)item;
                
                
                __weak __typeof(self) weakSelf = self;
                calloutView.moreInfoCallback = ^(NSDictionary *moreInfo){
                    DetailInfoViewController *detailVC = [[DetailInfoViewController alloc] initWithData:moreInfo];
                    
                    [weakSelf.navigationController pushViewController:detailVC animated:YES];
                };
                calloutView.webSiteCallback = ^(NSDictionary *moreInfo){
                    NSString *url = moreInfo[@"modelUrl"];
                    WebViewController *controller = [[WebViewController alloc] init];
                    
                    [controller setUrl:[NSURL URLWithString:url]];
                    
                    [weakSelf.navigationController pushViewController:controller animated:YES];
                };
                
                //show callout
                [self.mapView showInfoView:YES];
            });
            
            

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

#pragma mark - actions
-(void) actionSearch
{
    MapSearchInfoViewController *vc = [[MapSearchInfoViewController alloc] init];
    @weakify(self)
    vc.graphicSelectedCallback = ^(NSDictionary *info)
    {
        @strongify(self)
        AGSGraphic * graphic = info[@"graphics"];
        AGSGeometry *geometry = graphic.geometry;
        if (![geometry isKindOfClass:[AGSPoint class]]) {
            return;
        }
        AGSPoint *point = (AGSPoint *)geometry;
        
        [self.mapView zoomToScale:500000 withCenterPoint:point animated:YES];
        
        NSString *name = [graphic attributeAsStringForKey:@"名称"];
        if (!name)
            name = [graphic attributeAsStringForKey:@"NAME"];
        if (!name)
            return;
        
        self.mapView.callout.customView = nil;
        self.mapView.callout.title = name;
        self.mapView.callout.accessoryButtonHidden = YES;
        AGSPoint * p = (AGSPoint *)geometry;
        [self.mapView.callout showCalloutAt:p screenOffset:CGPointMake(0, 0) animated:YES];
//        AGSGraphicsLayer *glayer = (AGSGraphicsLayer *)[self.mapView mapLayerForName:@"Graphics Layer"];
//        if (glayer) {
//            [glayer removeAllGraphics];
//            AGSPictureMarkerSymbol* myPictureSymbol = [AGSPictureMarkerSymbol pictureMarkerSymbolWithImageNamed:@"icon_location"];
//            myPictureSymbol.size = CGSizeMake(36, 36);
//            //向右上方偏移5个像素
//            myPictureSymbol.offset = CGPointMake(0, 18);
//            AGSGraphic *symbol = [AGSGraphic graphicWithGeometry:geometry symbol:myPictureSymbol attributes:nil];
//            [glayer addGraphic:symbol];
//        }
        
        NSString *departName = [graphic attributeAsStringForKey:@"MANE"];
        NSString *objectNumber = [graphic attributeAsStringForKey:@"OBJECTNUM"];
        ItemCallOutView *calloutView = [[ItemCallOutView alloc] initWithFrame:CGRectMake(0, 0, self.mapView.frame.size.width, 80)];
        self.mapView.infoView = calloutView;
        
        
        NSDictionary *infoDict = [graphic allAttributes];
        NSMutableDictionary *convertDict = [NSMutableDictionary dictionary];
        for (NSString *key in infoDict.allKeys) {
            NSString *convertKey = [self stringFromInfoKey:key];
            convertDict[convertKey] = infoDict[key];
        }
        
        
        dispatch_group_t group = dispatch_group_create();
        
        
        __block NSString *modelUrl = nil;
        if (objectNumber) {
            dispatch_group_enter(group);
            [[Search3DHttpManager sharedManager] request3DModelWithObjectnum:objectNumber SuccessCallback:^(NSURLSessionDataTask *task, id dict) {
                Search3DResultModel *model = [Search3DResultModel objectWithKeyValues:dict];
                if (model && model.datalist.count>0) {
                    Search3DResultItem *item = model.datalist.firstObject;
                    modelUrl = [item.modelpath copy];
                }
                dispatch_group_leave(group);
            } failCallback:^(NSURLSessionDataTask *task, NSError *error) {
                dispatch_group_leave(group);
            }];
        }
        
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            CallOutItem *item = [[CallOutItem alloc] init];
            item.title = name;
            item.detail = departName?:@"";
            item.moreInfo = [convertDict copy];
            
            if (nil != modelUrl) {
                
                item.webSiteInfo = @{@"modelUrl":modelUrl};
            }
            calloutView.model = (id<ItemCallOutViewModel>)item;
            
            
            __weak __typeof(self) weakSelf = self;
            calloutView.moreInfoCallback = ^(NSDictionary *moreInfo){
                DetailInfoViewController *detailVC = [[DetailInfoViewController alloc] initWithData:moreInfo];
                
                [weakSelf.navigationController pushViewController:detailVC animated:YES];
            };
            calloutView.webSiteCallback = ^(NSDictionary *moreInfo){
                NSString *url = moreInfo[@"modelUrl"];
                WebViewController *controller = [[WebViewController alloc] init];
                
                [controller setUrl:[NSURL URLWithString:url]];
                
                [weakSelf.navigationController pushViewController:controller animated:YES];
            };
            
            //show callout
            [self.mapView showInfoView:YES];
        });
        
        return;
        
        
    };
    [self.navigationController pushViewController:vc animated:YES];
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
    
    [self actionMyLocation];
}


-(void) showLocation:(NSNotification *)notify
{
    NSDictionary* info = notify.userInfo;
    // x,y->double title->string
    
    double x,y;
    x = [info[@"x"] doubleValue];
    y = [info[@"y"] doubleValue];
    AGSPoint *point = [[AGSPoint alloc] initWithX:x y:y spatialReference:self.mapView.spatialReference];

    self.mapView.callout.customView = nil;
    self.mapView.callout.title = info[@"title"];
    self.mapView.callout.accessoryButtonHidden = YES;
    AGSPoint * p = (AGSPoint *)point;
    [self.mapView.callout showCalloutAt:p screenOffset:CGPointMake(0, 0) animated:YES];

}

-(BOOL) loaded3DMap
{
    return self.mapView.layerMask & LayerMask3DLayer;
}

#pragma distance

@end


