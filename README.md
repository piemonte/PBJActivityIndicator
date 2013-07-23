## PBJActivityIndicator
'PBJActivityIndicator' is an iOS component for displaying the status bar indicator efficiently across multiple request objects.

Mobile applications that perform a variety of network requests can easily provide indication of network use without any indicator flickering or incorrect state. This is accomplished by calling an activity indictor block before the request is sent and after the request succeeds or fails.

It is also possible to add request specific debug logging within the activity blocks.

### Basic Use

The activity indicator singleton is provided for convince, an ivar is also just as effective.

```objective-c
#import "PBJActivityIndicator.h"
```

```objective-c
    PBJActivityIndicatorBlock activityIndicatorBlock = ^(BOOL activity) {
        // it is possible to also insert logging particular to the activity
        [[PBJActivityIndicator sharedActivityIndicator] setActivity:activity forType:PBJActivityServiceTypeFollowers];
    };
```

```objective-c
    // before making a request for the service 'Followers', enable activity indicator
    if (activityIndicatorBlock)
        activityIndicatorBlock(YES);

// …   

    // after the request completes or fails, disable the activity indicator
    if (activityIndicatorBlock)
        activityIndicatorBlock(NO);

```
