//
//  PBJActivityIndicator.m
//
//  Created by Patrick Piemonte on 3/25/13.
//
//  Copyright (c) 2013-2014 Patrick Piemonte (http://patrickpiemonte.com)
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

#import "PBJActivityIndicator.h"

@interface PBJActivityIndicator ()
{
    NSInteger _activityActive;
    BOOL _suppressed;
    
    NSMapTable *_activityCounters;
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
    NSUInteger delayInSeconds = active ? 0 : 2;
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(time, dispatch_get_main_queue(), ^(void) {

        if (!_activityCounters) {
            _activityCounters = [NSMapTable weakToStrongObjectsMapTable];
        }
        
        NSNumber *count = [_activityCounters objectForKey:@(activityType)];
        if (count) {
            [_activityCounters removeObjectForKey:@(activityType)];
        } else {
            count = @(0);
        }
        
        NSUInteger updatedCount = active ? [count unsignedIntegerValue] + 1 : [count unsignedIntegerValue] - 1;
        if (updatedCount != 0)
            [_activityCounters setObject:@(updatedCount) forKey:@(activityType)];

        if ([_activityCounters count] == 0)
            _activityCounters = nil;

        // update active state
        BOOL wasActive = (_activityActive != 0);
        _activityActive += (active ? 1 : -1);
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

- (BOOL)isActive
{
    return _activityActive != 0;
}

#pragma mark - private

- (void)_updateActivityIndicator
{
    BOOL isActive = (_activityActive != 0);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:(isActive && !_suppressed)];
}

@end
