//
//  PBJActivityIndicator.h
//
//  Created by Patrick Piemonte on 3/25/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// 1. define strings to indicator activity type
//      Note: an activity type is simple an integer used to track a particular type of activity, (HTTPGet == 1, HTTPPost == 2, etc)
//
// 2. add a setActivity call before and after your network requests (complete but also failure blocks!)
//

typedef void (^PBJActivityIndicatorBlock)(BOOL activity);

@interface PBJActivityIndicator : NSObject

+ (PBJActivityIndicator *)sharedActivityIndicator;

// suppress all activity indicator state, (use with applicationDidEnterBackground, applicationWillEnterForeground)
@property (nonatomic, getter=isSuppressed) BOOL suppressed;

- (void)setActivity:(BOOL)active forType:(NSUInteger)activityType;

@end
