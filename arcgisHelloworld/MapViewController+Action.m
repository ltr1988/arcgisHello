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
#import "QRCodeReaderViewController.h"
#import "VideoPlayViewController.h"
#import "ImagePickerViewController.h"
#import "WebViewController.h"
#import "RouteStartEndPickerController.h"
#import "SearchChoiceController.h"
#import "SearchStartViewController.h"
#import "SearchSessionManager.h"

#import "TextPickerViewController.h"

@implementation MapViewController (Action)

-(void) actionNavi
{
    RouteStartEndPickerController *vc =[[RouteStartEndPickerController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - bottom view actions
-(void) actionSearchUpload
{
    if ([[SearchSessionManager sharedManager] hasSession]) {
        SearchChoiceController *vc = [[SearchChoiceController alloc] init];
        vc.definesPresentationContext = YES;
        vc.providesPresentationContextTransitionStyle = YES;
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }else
    {
        SearchStartViewController *vc = [[SearchStartViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
//    VideoPlayViewController *vc = [[VideoPlayViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void) actionEventUpload
{
    EventReportViewController *controller = [[EventReportViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

-(void) actionQRCodeSwipe
{
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.delegate = self;
    [self.navigationController pushViewController:reader animated:YES];

}

-(void) actionNavigation
{

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

-(void) actionMyWork
{
    
    
    ImagePickerViewController *controller = [[ImagePickerViewController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


#pragma mark choice modal vc delegate
-(void) dismissController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) endSession
{
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        
        SearchStartViewController *vc = [[SearchStartViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

-(void) continueSession
{
    __weak __typeof(self) weakSelf = self;
    [self dismissViewControllerAnimated:YES completion:^{
        TextPickerViewController *vc = [[TextPickerViewController alloc] init];
        //VideoPlayViewController *vc = [[VideoPlayViewController alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self.navigationController popViewControllerAnimated:YES];
    [[[UIAlertView alloc] initWithTitle:@"" message:result delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil] show];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
