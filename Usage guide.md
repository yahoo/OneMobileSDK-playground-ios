## :musical_note: NOTE *** _This doc is obsolete, and may no longer be accurate_ ***
Please refer to this link instead: https://github.com/aol-public/OneMobileSDK-playground-ios/blob/master/README.md




# How to start using OneMobileSDK v2.x

## Integrate SDK with your project

You can integrate SDK in your project in several ways.

1. Cocoapods - look on Podfile example in this repository.
2. Carthage - look on Cartfile example in this repository.
3. Binary - grab packed framework directly from https://github.com/vidible/OneMobileSDK-releases/releases

## Creating an `OneSDK` object

TL;DR:
```swift
let sdk = OneSDK.Provider.default.getSDK()
```

`OneSDK` is a factory of `Player`s which share common settings and configurations.
But `OneSDK` itself need to be configured properly.
`OneSDK` should be initialized via config (`OneSDK.Configuration`) which can be received from web service.

To do so you need to request `OneSDK` future from an `OneSDK.Provider`

### OneSDK.Provider

This class is responsible for giving you a future to setted up OneSDK object.
You can use devault provider (will work for most cases) or customize it. Do to so:
```swift
var provider = OneSDK.Provider.default
provider.context.extra = ["site-section": "cars"]

let sdk = provider.getSDK()
```
Note: Contents of `extra` field is `JSON` aka `[String: Any]`
so you need provide something that can be eaten up by `JSONSerialization` object.

### OneSDK.Context

Each `OneSDK.Provider` instance contains `context` field which is used to match application and settings on web service.
In `default` provider we use current application context: `OneSDK.Context.current`.

This context is completed with values available in your application plist, device information, etc.

`extra` portion of context is empty by default, however, you can pass any JSON compatible dictionary here.
Content of this dictionary will be treated by web service in app specific way.

### OneSDK.Configuration

`OneSDK.Provider` have another method `func getConfiguration() -> Future<Result<OneSDK.Configuration>>`.

While preferred way to construct an `OneSDK` is a provider, `OneSDK` contains initializer with `Configuration` object.
You can use it when you want to alter recommended settings. For example:
```swift
func patch(config: OneSDK.Configuration) -> OneSDK.Configuration {
  var config = config
  config.features.isHLSEnabled = false
  return config
}

let sdk = provider.getConfiguration()
  .map(patch)
  .map(OneSDK.init)
```

### Note
Content of `OneSDK.Configuration` will change from version to version
as we are going to more and more web oriented (and resilent!) solution.
Please, expect code to not be stable.

### Migration note

If you porting code from 1.x version of an SDK:

1. `WithCallback` is dropped from SDK in a favor of `Future` and `Result` primitives.
2. `OneSDK` initializers is limited to configuration options.

Example of player construction:

#### SDK 1.18.x

```swift
let sdk = One.SDK(pid: "your_pid",
            aid: "your_aid",
            bcid: "your_bcid",
            companyKey: "your_company_key")
sdk.playerForVideoID("your_video_id") { result in
    let player = try? result()
    // player is ready to be used
}
```

#### SDK 2.x

```swift
OneSDK.Provider.default.getSDK().then {
    $0.getPlayer(videoID:"your_video_id")
    }.onComplete { player in
        // Result<Player> is ready to be used.
}
```
