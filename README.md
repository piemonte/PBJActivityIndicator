## PBJActivityIndicator
'PBJActivityIndicator' is an iOS component for displaying the status bar indicator efficiently across multiple objects.

Mobile applications that perform a variety of network requests can easily provide indication of network use without any indicator flickering or incorrect state. This can be accomplished by calling an activity indictor block before a request is sent and then after the request succeeds or fails.

It is also possible to add request specific debug logging within the activity blocks.

## Installation

[CocoaPods](http://cocoapods.org) is the recommended method of installing PBJActivityIndicator, just add the following line to your `Podfile`:

#### Podfile

```ruby
pod 'PBJActivityIndicator'
```

## Usage

The activity indicator singleton is provided for convince, an ivar is also just as effective.

```objective-c
#import "PBJActivityIndicator.h"
```

```objective-c
    PBJActivityIndicatorBlock activityIndicatorBlock = ^(BOOL activity) {
        // it is also possible to add logging particular to the activity here
        [[PBJActivityIndicator sharedActivityIndicator] setActivity:activity forType:PBJActivityServiceTypeFollowers];
    };
```

```objective-c
    // before making a request for the service 'Followers', enable activity indicator
    if (activityIndicatorBlock)
        activityIndicatorBlock(YES);
```

```objective-c
    // after the request completes or fails, disable the activity indicator
    if (activityIndicatorBlock)
        activityIndicatorBlock(NO);
```

## License

PBJActivityIndicator is available under the MIT license, see the LICENSE file for more information.
