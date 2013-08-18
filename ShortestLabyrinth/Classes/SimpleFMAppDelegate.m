//
//  SimpleFMAppDelegate.m
//  SimpleFM
//
//  Created by Norihisa Nagano
//  Modified by Yuta Mizushima
//

#import "SimpleFMAppDelegate.h"
#import "SimpleFMViewController.h"

@implementation SimpleFMAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
