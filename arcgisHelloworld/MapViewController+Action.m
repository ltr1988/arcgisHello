//
//  MapViewController+Action.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapViewController+Action.h"
#import "MapViewController.h"
#import "EventReportViewController.h"
#import "QRCodeViewController.h"
#import "VideoPlayViewController.h"
#import "ImagePickerViewController.h"
#import "WebViewController.h"
#import "RouteViewController.h"

@implementation MapViewController (Action)

-(void) actionNavi
{
    RouteViewController *vc =[[RouteViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - bottom view actions
-(void) actionSearchUpload
{
    VideoPlayViewController *vc = [[VideoPlayViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void) actionEventUpload
{
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    EventReportViewController *controller = [sb instantiateViewControllerWithIdentifier:@"eventReportViewController"];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) actionQRCodeSwipe
{
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    QRCodeViewController *controller = [sb instantiateViewControllerWithIdentifier:@"qrCodeViewController"];
//    [self.navigationController pushViewController:controller animated:YES];
    
    
    WebViewController *controller = [[WebViewController alloc] init];
    
    [controller setUrl:[NSURL URLWithString:@"http://www.baidu.com"]];
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

-(void) actionQRCodeMyWork
{
    
    
    ImagePickerViewController *controller = [[ImagePickerViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
