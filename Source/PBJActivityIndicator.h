//
//  PBJActivityIndicator.h
//
//  Created by Patrick Piemonte on 3/25/13.
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

// suppress activity indicator, (use with applicationDidEnterBackground, applicationWillEnterForeground)
@property (nonatomic, getter=isSuppressed) BOOL suppressed;

@property (nonatomic, readonly, getter=isActive) BOOL active;
- (void)setActivity:(BOOL)active forType:(NSUInteger)activityType;

@end
