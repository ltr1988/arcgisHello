//
//  ViewController.h
//  arcgisHelloworld
//
//  Created by fifila on 16/6/9.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoAGSMapView.h"
#import "SearchChoiceController.h"
#import "QRCodeReaderDelegate.h"

@interface MapViewController : SupportRotationSelectBaseViewController<SearchChoiceControllerDelegate,QRCodeReaderDelegate>

@property (weak, nonatomic) InfoAGSMapView *mapView;
@end

