//
//  MapViewController+Action.h
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController (Action)
-(void) actionNavi;
-(void) actionMyLocation;

-(void) actionPlus;
-(void) actionMinus;

//bottom 4 buttons
-(void) actionSearchUpload;
-(void) actionEventUpload;
-(void) actionQRCodeSwipe;
-(void) actionLiveData;
-(void) action3D;
-(void) actionMyWork;

-(void) naviToPoint:(AGSPoint *)point desc:(NSString *)desc;
@end
