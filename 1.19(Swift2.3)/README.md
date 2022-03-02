# Introduction

This document will help you integrate **1.19.x** OneMobileSDK. It also describes key differences comparing to version **1.18.x** so you will be able easily migrate from previous version.

Main feature of **1.19.x** version is use of  MicroService API to simplify integration and improve API stability of SDK.

Details about **1.18.x** could be found [here](http://yahoo.github.io/mobile-sdk-ios/).

# Installing version 1.19

In your **Podfile**:

```
# OneMobileSDK podspec repo
source "https://github.com/yahoo/OneMobileSDK-releases.git"
```

Next, choose one from the Pods below that suits your project:

```
# Compatible with Swift 2.2
pod 'OneMobileSDK-Swift2.2', '~> 1.19'
```

```
# Compatible with Swift 2.3
pod 'OneMobileSDK-Swift2.3', '~> 1.19'
```

# Integration

Import `OneMobileSDK`:

```swift
import OneMobileSDK
```

## Basic example (Using MicroService API)

Construct `OneSDK` from MicroService and create `Player` from it.

```swift
let sdk = OneSDK.Provider().getSDK()
sdk.then({
	$0.getPlayerForVideoID("your_video_id")
}).withCallback { result in
	do {
		let player = try result()
		// Player is ready to use here.
	} catch {
		// handle error
	}
}
```

## Override context

By default `OneSDK` sends `Context.current` to the MicroService API. You can override any fields of this `Context`.

For example you would like to use *Stage* environment:

```swift
var provider = OneSDK.Provider()
provider.context.sdk.environment = "stage"        
```

Or you would like to add some extra information. `extra` is `[String: AnyObject]` container. Pass any JSON convertible information there.

Example:

```swift
var provider = OneSDK.Provider()
provider.context.extra = ["sitesection" : "news"]
```

## Override SDK configuration

You can override configuration that is coming from MicroService API.
For example you would like to set `isHLSEnabled` to `false`:

```swift
let sdk = OneSDK.Provider().getConfiguration().map({ configuration in
	var configuration = configuration
	configuration.features.isHLSEnabled = false
	return configuration
}).map(OneSDK.init)

sdk.then({
	$0.getPlayerForVideoID("your_video_id")
}).withCallback { result in
	do {
		let player = try result()
		// Player is ready to use here.
	} catch {
		// handle error
	}
}
```
