![PBJActivityIndicator](https://raw.github.com/piemonte/PBJActivityIndicator/master/PBJActivityIndicator.gif)

## PBJActivityIndicator
'PBJActivityIndicator' is an iOS component for displaying the status bar loading indicator efficiently across multiple objects.

When integrated, mobile apps that perform a variety of network requests can easily display an indication of activity without flickering or incorrect loading state. This can be accomplished by calling into 'PBJActivityIndicator' before a request is sent and then after request succeeds or fails.

Please review the [release history](https://github.com/piemonte/PBJActivityIndicator/releases) for more information. If you have questions or ideas, the [github issues page](https://github.com/piemonte/PBJActivityIndicator/issues) is a great means to start a discussion but also allows others to benefit and chime in on the project too.

## Installation

[CocoaPods](http://cocoapods.org) is the recommended method of installing PBJActivityIndicator, just add the following line to your `Podfile`:

#### Podfile

```ruby
pod 'PBJActivityIndicator'
```

## Usage

The activity indicator singleton is provided for convenience, using an instance variable is also just as effective.

```objective-c
#import "PBJActivityIndicator.h"
```

```objective-c

    // enable the activity indicator for the integer type, 'MyRequestTypeHttpGet'
    [[PBJActivityIndicator sharedActivityIndicator] setActivity:YES forType:MyRequestTypeHttpGet];

    // perform some type of loading request, disable the indicator in the completion blocks or delegate callback
    [dataRequester requestDataWithSuccessHandler:^() {
    
        // disable indicator on success
        [[PBJActivityIndicator sharedActivityIndicator] setActivity:NO forType:MyRequestTypeHttpGet];
    
    } failureHandler:^() {
    
        // disable indicator on failure
        [[PBJActivityIndicator sharedActivityIndicator] setActivity:NO forType:MyRequestTypeHttpGet];
    
    }];

```

Another technique for integrating 'PBJActivityIndicator' is to create a block that sets the activity within a particular component.

```objective-c
#import "PBJActivityIndicator.h"
```

```objective-c
    PBJActivityIndicatorBlock activityIndicatorBlock = ^(BOOL activity) {
        // Tip: it is possible to add logging particular to the activity here
        [[PBJActivityIndicator sharedActivityIndicator] setActivity:activity forType:MyRequestServiceType];
    };
```

Within that request service object, call the block to activate the appropriate state.

```objective-c
    // enable the indicator before making a request for the service 'MyRequestServiceType'
    if (activityIndicatorBlock)
        activityIndicatorBlock(YES);
```

```objective-c
    // disable the indicator after the request succeeds or fails
    if (activityIndicatorBlock)
        activityIndicatorBlock(NO);
```

## License

PBJActivityIndicator is available under the MIT license, see the [LICENSE](https://github.com/piemonte/PBJActivityIndicator/blob/master/LICENSE) file for more information.
