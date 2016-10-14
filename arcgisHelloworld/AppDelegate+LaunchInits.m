//
//  AppDelegate+LaunchInits.m
//  NSBDMobileSearchPlatform
//
//  Created by fifila on 16/7/10.
//  Copyright © 2016年 fifila. All rights reserved.
//

#import "AppDelegate+LaunchInits.h"
#import "CommonDefine.h"

@implementation AppDelegate (LaunchInits)

-(void) setupArcgis
{
    NSError *error;
    NSString* clientID = @"pdjx7KQUiCfm7ixX";
    [AGSRuntimeEnvironment setClientID:clientID error:&error];
    if(error){
        // We had a problem using our client ID
        NSLog(@"Error using client ID : %@",[error localizedDescription]);
    }
}

-(void) setupReachability
{
    
}

-(void) setupLocationAuthorize
{
    
}
@end
