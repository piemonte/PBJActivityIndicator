## PBJActivityIndicator
'PBJActivityIndicator' is an iOS component for displaying the status bar loading indicator efficiently across multiple request objects.

This helps avoid flickering as well as improper state (active even though no activity is in progress). It is also possible to add service specific logging for debugging within the activity blocks.

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

// …

    // before making a request for the service 'Followers', enable activity indicator
    if (activityIndicatorBlock)
        activityIndicatorBlock(YES);

// …   

    // after the request completes or fails, disable the activity indicator
    if (activityIndicatorBlock)
	activityIndicatorBlock(NO);

```
