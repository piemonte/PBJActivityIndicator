//
//  PBJAppDelegate.m
//  ActivityIndicator
//
//  Created by Patrick Piemonte on 7/22/13.
//  Copyright (c) 2013 Patrick Piemonte. All rights reserved.
//

#import "PBJAppDelegate.h"
#import "PBJActivityIndicator.h"
#import "PBJViewController.h"

// PBJActivityIndicator types
typedef NS_ENUM(NSInteger, PBJActivityServiceType) {
    PBJActivityServiceTypeFavorites = 0,
    PBJActivityServiceTypeFollowers,
    PBJActivityServiceTypePhotos,
    PBJActivityServiceTypeCount
};

@implementation PBJAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // activityIndicatorBlock can be a property in other components
    PBJActivityIndicatorBlock activityIndicatorBlock = ^(BOOL activity) {
        // it is possible to insert logging here, particular to this activity
        [[PBJActivityIndicator sharedActivityIndicator] setActivity:activity forType:PBJActivityServiceTypeFollowers];
    };

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[PBJViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    // before making a network request for the service 'Followers', enable activity indicator
    if (activityIndicatorBlock)
        activityIndicatorBlock(YES);

    // ...

    // after request completes and fails, disable activity indicator from it's completionHandler
//    if (activityIndicatorBlock)
//        activityIndicatorBlock(NO);
    
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[PBJActivityIndicator sharedActivityIndicator] setSuppressed:YES];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    [[PBJActivityIndicator sharedActivityIndicator] setSuppressed:NO];
}

@end
