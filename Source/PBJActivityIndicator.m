//
//  PBJActivityIndicator.m
//
//  Created by Patrick Piemonte on 3/25/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "PBJActivityIndicator.h"

@interface PBJActivityIndicator ()
{
	BOOL _suppressed;
    NSInteger _activityActive;
    NSInteger *_activityCounters;
    NSUInteger _activityCountersMax;
}

- (void)_updateActivityIndicator;

@end

@implementation PBJActivityIndicator

@synthesize suppressed = _suppressed;

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
            size_t size = activityType + 1;
            _activityCounters = calloc(sizeof(NSInteger), size);
            _activityCountersMax = activityType;
        } else if (activityType > _activityCountersMax) {
            size_t size = activityType + 1;
            NSInteger *counters = calloc(sizeof(NSInteger), size);
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

- (void)setSuppressed:(BOOL)suppressed
{
    _suppressed = suppressed;
    [self _updateActivityIndicator];
}

#pragma mark - private

- (void)_updateActivityIndicator
{
    BOOL isActive = (_activityActive != 0);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(isActive && !_suppressed)];
}

@end
