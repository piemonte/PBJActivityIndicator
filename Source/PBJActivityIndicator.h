//
//  PBJActivityIndicator.h
//
//  Created by Patrick Piemonte on 3/25/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

//
// brief activity indicator how-to:
//
// 1. define an enum to track activity across different component types
//    typedef NS_ENUM(NSUInteger, PBJActivityServiceType) ...
//
// 2. setup your components use a block, based on their network activity type (followers, pictures, etc.)
//
//  PBJActivityIndicatorBlock block = ^(BOOL activity) {
//      [self setActivity:networkActivity forType:PBJActivityServiceTypeFollowers];
//  };
//
// 3. before and after any network requests simply call, block(YES) and then block(NO), the rest is magic
//

typedef void (^PBJActivityIndicatorBlock)(BOOL activity);

@interface PBJActivityIndicator : NSObject
{
@private
	BOOL _suppress;
    
    NSInteger _activityActive;
    
    NSInteger *_activityCounters;
    NSUInteger _activityCountersMax;
}

+ (PBJActivityIndicator *)sharedActivityIndicator;

// suppress all activity state, (nice for applicationDidEnterBackground, applicationWillEnterForeground)
@property (nonatomic, getter=isSuppressed) BOOL suppress;

- (void)setActivity:(BOOL)active forType:(NSUInteger)activityType;

@end
