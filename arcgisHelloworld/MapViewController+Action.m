//
//  MapViewController+Action.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapViewController+Action.h"
#import "RouteManager.h"
#import "MapViewController.h"
#import "EventReportViewController.h"
#import "QRCodeViewController.h"

@implementation MapViewController (Action)
#pragma mark - route-navi
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


#pragma mark - bottom view actions
-(void) actionSearchUpload
{
    
}

-(void) actionEventUpload
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventReportViewController *controller = [sb instantiateViewControllerWithIdentifier:@"eventReportViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) actionQRCodeSwipe
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    QRCodeViewController *controller = [sb instantiateViewControllerWithIdentifier:@"qrCodeViewController"];
    [self.navigationController pushViewController:controller animated:YES];

}

-(void) actionNavigation
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


@end
