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
    self.reach = [Reachability reachabilityWithHostname:HOSTIP];
    
    // Set the blocks
    self.reach.reachableBlock = ^(Reachability*reach)
    {
        // keep in mind this is called on a background thread
        // and if you are updating the UI it needs to happen
        // on the main thread, like this:
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"REACHABLE!");
        });
    };
    
    self.reach.unreachableBlock = ^(Reachability*reach)
    {
        NSLog(@"UNREACHABLE!");
    };
    
    // Start the notifier, which will cause the reachability object to retain itself!
    [self.reach startNotifier];
}
@end
