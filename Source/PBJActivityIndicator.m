//
//  PBJActivityIndicator.m
//
//  Created by Patrick Piemonte on 3/25/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "PBJActivityIndicator.h"

@interface PBJActivityIndicator ()
{
}

- (void)_updateActivityIndicator;

@end

@implementation PBJActivityIndicator

@synthesize suppress = _suppress;

#pragma mark - singleton

+ (PBJActivityIndicator *)sharedActivityIndicator
{
    static PBJActivityIndicator *singleton = nil;
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        singleton = [[PBJActivityIndicator alloc] init];
    });
    return singleton;
}

#pragma mark - getters/setters

- (void)setActivity:(BOOL)active forType:(NSUInteger)activityType
{
    NSInteger counterIncrement = active ? 1 : -1;
    NSUInteger delayInSeconds = active ? 0 : 2;

    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^(void) {

        BOOL wasActive = (_activityActive != 0);

        // update counter for type
        if (!_activityCounters) {
            _activityCounters = calloc(sizeof(NSInteger), activityType);
        } else if (_activityCountersMax < activityType) {
            NSInteger *counters = calloc(sizeof(NSInteger), activityType);
            
            memcpy(_activityCounters, counters, sizeof(NSInteger) * _activityCountersMax);
            _activityCountersMax = activityType;
            
            free(_activityCounters);
            _activityCounters = counters;
        }
        _activityCounters[activityType] += counterIncrement;

        // update active state
        _activityActive += counterIncrement;

        BOOL isActive = (_activityActive != 0);
        
        if ((!wasActive && isActive) || (wasActive && !isActive))
            [self _updateActivityIndicator];
    });
}

- (void)setSuppress:(BOOL)suppressed
{
    _suppress = suppressed;
    [self _updateActivityIndicator];
}

- (void)_updateActivityIndicator
{
    BOOL isActive = (_activityActive != 0);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(isActive && !_suppress)];
}

@end
