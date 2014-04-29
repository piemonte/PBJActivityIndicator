//
//  PBJAppDelegate.m
//  ActivityIndicator
//
//  Created by Patrick Piemonte on 7/22/13.
//  Copyright (c) 2013-present, Patrick Piemonte, http://patrickpiemonte.com
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//  the Software, and to permit persons to whom the Software is furnished to do so,
//  subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//  FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
