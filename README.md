# O2 Mobile SDK Tutorial - for iOS and tvOS

Welcome to the O2 Mobile SDK (OMSDK or SDK). The purpose of this document and the linked source code examples is to provide you information about features and capabilities of SDK. You have to be familiar with modern iOS/tvOS development technologies and dependency managers like CocoaPods or Carthage.

This document will describe basic concepts and then will link you to sample projects and code, that are kept up-to-date with the latest versions of the the developer tools, API, and language we support. Our iOS and tvOS samples use CocoaPods as the default dependency manager (except for any Carthage-specific samples). 

As always, we highly appreciate, welcome, and value all feedback on this documentation or the OMSDK in any way, shape, or form. If you have any suggestions for corrections, additions, or any further clarity, please don’t hesitate to email the [Video Support Team](mailto:video.support@oath.com).

If you want to see the code - go to this [section](#tldr)!

## Table of Contents

[O2 Mobile SDK Tutorial - for iOS and tvOS](#o2-mobile-sdk-tutorial---for-ios-and-tvos)
1. [What is the O2 Mobile SDK?](#what-is-the-o2-mobile-sdk)
2. [Main SDK Features](#main-sdk-features)
3. [Why would I use the O2 Mobile SDK?](#why-would-i-use-the-o2-mobile-sdk)
4. [Advertising Info and User Tracking](#advertising-info-and-user-tracking)
5. [Starting Requirements](#starting-requirements)
6. [Onboarding your Apps for SDK Authentication](#onboarding-your-apps-for-sdk-authentication)
7. [High-Level Architecture Overview](#high-level-architecture-overview)
8. [How the SDK works](#how-the-sdk-works)
9. [Default (Player) Controls UX](#default-player-controls-ux)
10. [TLDR: Quick Start](#tldr)
11. [Tutorial 1: Playing Videos](#tutorial-1-playing-videos)
	1. [Setting default player controls’ tint color](#setting-default-player-controls-tint-color)
	2. [Playing with AutoPlay on/off](#playing-with-autoplay-onoff)
	3. [Playing Muted](#playing-muted)
	4. [Disabling HLS (or forcing MP4 playback)](#disabling-hls-or-forcing-mp4-playback)
12. [Tutorial 2: Customizing the Default Controls UX](#tutorial-2-customizing-the-default-controls-ux)
	1. [Hiding Various Controls buttons](#hiding-various-controls-buttons)
	2. [Closed Captioning / SAP Settings button](#closed-captioning--sap-settings-button)
	3. [Using the 4 Custom Sidebar buttons](#using-the-4-custom-sidebar-buttons)
	4. [Setting the LIVE indicator’s tint color](#setting-the-live-indicators-tint-color)
	5. [Animations Customization and Disabling](#animations-customization-and-disabling)
	6. [Custom colors for seeker elements](#custom-colors-for-seeker-elements)
13. [Tutorial 3: Observing the Player](#tutorial-3-observing-the-player)
	1. [Current Playback State and Position](#current-playback-state-and-position)
	2. [Looping Playback](#looping-playback)
	3. [LIVE, VOD, or 360°?](#live-vod-or-360)
	4. [Manually Hooking up Previous or Next Videos](#manually-hooking-up-previous-or-next-videos)
14. [Tutorial 4: Error Handling in the SDK](#tutorial-4-error-handling-in-the-sdk)
	1. [SDK Initialization Errors](#sdk-initialization-errors)
	2. [Player Initialization Errors](#player-initialization-errors)
	3. [Restricted Videos](#restricted-videos)
	4. [Deleted Videos](#deleted-videos)
	5. [Invalid or Unknown Videos](#invalid-or-unknown-videos)
15. [Specific Notes for iPhone X](#specific-notes-for-iphone-x)
	1. [Player Controls on the iPhone X](#player-controls-on-the-iphone-x)
	2. [Home Indicator Auto Hidden Setup](#home-indicator-auto-hidden-setup)
16. [Specific Notes for tvOS Apps](#specific-notes-for-tvos-apps)
	1. [Tutorial 5: Playing Videos on tvOS](#tutorial-5-playing-videos-on-tvos)
17. [Next Steps](#next-steps)
	1. [Getting O2 Video/Playlist IDs into your apps](#getting-o2-videoplaylist-ids-into-your-apps)
	2. [Controlling Ads via your O2 Portal Account](#controlling-ads-via-your-o2-portal-account)
18. [FAQ](#faq)
    1. [iOS hardware ringer](#ios-hardware-ringer)
    2. [Extracting SDK version in runtime](#extracting-sdk-version-in-runtime) 


## What is the O2 Mobile SDK?
The O2 Mobile SDK (OMSDK or SDK) is a native iOS SDK with the sole purpose for playing and monetizing videos from the Oath O2 video platform in your app. The OMSDK is written in Swift and is delivered as a framework. You can include this in your app projects either via CocoaPods or Carthage. Currently, Swift Package Manager not supported on iOS or tvOS.

As part of playing videos, the OMSDK also handles video ads (pre-roll, mid-roll, and post-roll) and associated videos and ads playback and performance analytics. Analytics are focused on tracking what is played, how far it is played (e.g., deciles, quartiles), and details about the actual device or network. For more details on the analytics supported or to access the analytics data, you will work with the [Video Support Team](mailto:video.support@oath.com) to build reports that focus specifically on your app’s video and ads performance.

The SDK includes a complete default video player controls UX (user experience), which includes a limited albeit robust set of customization options. The controls implementation is fully open source, and the SDK architecture allows for you to include your own fully customized controls UX, should you not be interested in the built-in default one.

## Main SDK Features
* Playback of one or more individual videos or a single playlist of videos
* Video playback of VOD (video on demand), 360°, and LIVE streaming video types
* Supports either .mp4 or .m3u8 (HLS) formats
* Video ads (VAST support of .mp4 format only)
* Prerolls and midrolls support
* Tap an ad to access ad URL (more information) via an in-app-browser
* Full video and ads analytics
* Default video player controls UX (full source code open sourced)
* HLS support for multiple closed captioning (CC) and SAP audio languages
* Mute/Unmute support
* Automatic filtering of geo-restricted videos (Automatically done on micro-service backend)
* Complete apps control of the frame where videos play
* Native iOS Picture-in-Picture support
* Apple AirPlay support

## Why would I use the O2 Mobile SDK?
The O2 Mobile SDK is used to natively play O2 videos. If you have a native app, you should use the SDK. The main reason as to why you’d want to use the SDK, is because you get all the ads and analytics for free. The ads are important for monetization. Analytics are important for tracking your app’s video and video ads performance and usage. This helps you understand what your users are watching with your app, and how much.

There are several technical advantages to using the native OMSDK over a web player-based solution. We won’t go into these in depth in this document, but here are some of the advantages:
* Performance
* Mobile network awareness
* Frugal memory, thread, and device resource usage
* Security – comparing to webviews / embedded browsers and some platforms don’t have webviews (e.g., Apple TV)
* Fine-grained control, less limits
* More customization options

## Advertising Info and User Tracking
The O2 Mobile SDK does not track anything that is not related to playing videos or video ads. We use the IDFA (ID for advertisers) value and respect the user's settings for Limit Ad Tracking (iOS enforces this anyway). The device geolocation is determined by our backend video servers based on IP address, for the purposes of determining and filtering out content that is geo-restricted by content owners. The SDK does not explicitly use the built-in Location Services APIs, and thus does not require your users to grant access to device location data.

## Starting Requirements
* **Xcode 9.3+**
* **Swift 4.1 (use in Obj-C projects is also possible by writing wrapper around Swift framework)**
* **CocoaPods or Carthage**
* **Mobile device running iOS 9 or later or AppleTV device running tvOS 9 or later**
* **Account in the O2 Portal, and access to Oath-ingested video content**
* **Onboarded application bundle ID**

## Onboarding your Apps for SDK Authentication
In order for the OMSDK to authenticate itself for video playback within your app, we pass the containing app’s unique App Store bundle identifier to our back end service. You need to email the [Video Support Team](mailto:video.support@oath.com) to register all of your app bundle IDs for OMSDK usage. You can also register multiple bundle IDs against your same app entity. Possible reasons to do this, is to allow for a dev/test app bundle ID or an enterprise bundle ID, that can co-exist on a device alongside your production app. Also, both iOS and Android app bundle IDs can either be the same or different – for the same app. Registration not only authenticates your application, but it ensures your backend video and ads analytics are all configured properly. In addition, this registration information also defines all the video content your app is allowed to playback through the SDK.

The sample projects are all set up to use the following test-only bundle ID: `com.aol.mobile.one.testapp`

## High-Level Architecture Overview
At a high-level, the OMSDK architecture is composed of the following components:
* SDK Core
* A set of Video Renderers that are built-in (e.g., flat 2D and RYOT 360°) And possibility to use external renderers (e.g., Verizon Envrmnt 360°, custom, etc.)
* O2 VRM (video rights management) VAST Ads Engine
* Content and Ads Video Analytics module
* Default video player controls UX implementation

Our modular approach makes it easy for us (or you) to add new renderers in the future, or for you to add your own custom video player controls UX implementation. Under the hood, we rely on the built-in iOS [`AVPlayer`](https://developer.apple.com/documentation/avfoundation/avplayer) to handle the actual video playback.

Remember that new renderers have to be registered on our micro-service. Reach [Video Support Team](mailto:video.support@oath.com) to start this process.

## How the SDK works
At a very basic level, the OMSDK controls only the video frame. Because of this, you are completely in control of your app’s design and UX (look and feel). You can control whether videos play in a small view, in-place over a thumbnail image, or at full-screen. Your app also has complete control over device rotation, use of view/navigation controllers, scrollers, and any transitions between them. The SDK does not dictate any overall visual design or behavior on your app.

If you choose to use the SDK’s built-in default player controls UX implementation, then that part of the video UX is imposed on you. All controls rendering is also done within the frame you provide for the video. Regardless of which controls UX you use, we currently do not allow any customization or overriding of the ads playback UX (which is different from the normal video playback UX), so that visual interface is dictated, and you cannot override it. Future customization options are planned here.

To play a video, you follow these very basic steps:
1. Initialize an instance of the OneSDK
2. Using OneSDK initialize a new `Player` object with a video ID/IDs or playlist ID
3. Set `Player` to the `PlayerViewController`
4. Set `Controls` to the `PlayerViewController`
5. Show `PlayerViewController`!

**That’s it!**

Behind the scenes, what happens is this … the initialization of an instance of the SDK takes your app’s bundle ID, and passes it to our back-end micro services to authenticate your application for video playback within the O2 video platform. The server passes back all the necessary playback and authentication information down to that instance of the SDK, for use during it’s lifespan. When you construct a new `Player` object from that SDK instance, it communicates with our micro services to obtain all the necessary video metadata (e.g., thumbnails and video URLs, duration, etc.). This `Player` object will play and replay the associated video until deinitialized.

More specifically, before a video plays, the SDK’s Ads Engine tries to fulfill a pre-roll ad. While the request for an ad is being processed, the video starts buffering in the background. If an ad is returned in a reasonable amount of time, the `Player` plays the ad using the built-in ads UX. When the ad finishes, the video playback begins. If no ad is to be shown, or the ad request times out, the video playback begins directly.

The runtime circumstances and algorithm for getting an ad or not, are not in the scope of this documentation. Suffice to say, there are many considerations to this (e.g., content owner/seller rules, geolocation, frequency capping, etc.). For more information and details on how ads are served to the OMSDK, please email the [Video Support Team](mailto:video.support@oath.com).

**Note**: The SDK only operates with an active network connection – without it, you will not be able to do anything.

## Default (Player) Controls UX

|Portrait|Landscape|
|--------|---------|
|<img width="300" alt="screen shot 2017-12-21 at 9 06 35 pm" src="https://user-images.githubusercontent.com/16276892/34273124-5943e9de-e693-11e7-90dd-d5d2fc2a2f65.png">|<img width="300" alt="screen shot 2017-12-21 at 9 06 41 pm" src="https://user-images.githubusercontent.com/16276892/34273126-595cdb24-e693-11e7-8bc7-5f95683ec676.png">|

The default player controls UX contains the following elements:
* Play/Pause/Replay button (with loading animation)
* ± 10 second skip buttons
* Previous and Next buttons
* Seekbar
* Video title
* Elapsed time
* Video duration
* LIVE indicator
* 360° View Orientation Compass / Orientation Reset button
* Closed Captioning/SAP Settings button
* Picture-in-Picture (PiP) button
* AirPlay button
* 4 app-custom sidebar buttons

It also includes some gestures to interact with player:

| Controls hide/show gesture|
|---------------------------|
|<img width="650" alt="show-hide-anim" src="https://user-images.githubusercontent.com/31652265/40317058-ec57c4a0-5d28-11e8-9f5c-535c48f17a3b.gif">|

|Content full-screen gesture|
|---------------------------|
|<img width="650" alt="show-hide-anim" src="https://user-images.githubusercontent.com/31652265/40316727-e4ff0228-5d27-11e8-8cb4-14df42c4447f.gif">|

This video controls implementation allows for a few runtime customizations, that you can set on a player by player basis. This includes:
* Setting the tint color for the controls (e.g., matching your app’s brand)
* Hiding various elements of the controls (useful for smaller view versus full-screen playback)
* Setting any of the 4 app-custom sidebar buttons

The built-in tint color of the default video player controls UX is <span style="color:magenta">pink/magenta</span>. This is deliberate; feel free to keep it or change it to mesh with your app’s design or brand theme. The built-in tint color of the ad’s UX is <span style="color:gold">yellow/gold</span>. This cannot be changed at this time. Because of this, we advise that you don’t tint your main controls yellow as well. You also don’t want to use black or gray, because of video contrast, your controls will not be very visible. White, on the other hand is fair game. There is a slightly darkened canvas that is layered above the video, but below the controls layer, that helps make the controls pop out more.

The player controls are shown under several well-established circumstances. This includes whenever the video is paused, such as before a video starts (with AutoPlay off) or while buffering, after any video finishes (with AutoPlay off), or after all videos linked to the player finish. They also will display (fade in) on demand whenever a video is tapped. If a video is actively playing, the controls will automatically hide (fade out) after a predetermined number of seconds. At any time the controls are shown, they can be quickly hidden by tapping on the video (not over a button, of course).

The default player controls UX implementation includes 4 optional app-specific sidebar buttons. You can set any or all of these to use as you see fit. This was built to allow for app-specific video overlay customization in anticipation for up to 4 new behaviors. Because these 4 sidebar buttons are built right into the default controls UX, they will automatically fade in/out with the rest of the video controls. There is no need to handle any of that logic or attempt to synchronize to the animation timings.

We also think that there should be more gestures that will help users interact with our player. One of these is a double tap gesture. By doing double tap in the empty space of the player, the user will be able to change video gravity from aspect fit to aspect fill. This gesture won't have any conflicts with controls show/hide gesture. 

The complete implementation of the default player controls UX is open-source and provided to serve as an implementation sample of its own. Feel free to inspect it, copy it, modify it at will.

The default iOS Controls UI implementation repo can be found here: 
[O2 Mobile SDK Controls for iOS](https://github.com/aol-public/OneMobileSDK-controls-ios)

<a name="tldr"></a>
## TLDR: Quick Start

Please, use tutorials inside this repository to get started. 
The complexity of tutorial is increasing with its number :) 
So for beginning use Tutorial 1!

<a name="tutorial-1"></a>
## Tutorial 1: Playing Videos

This tutorial sample shows you how to quickly init the OMSDK and play videos using all the default options and behaviors, with very little code. Playing a single video, a list of individual videos, or videos from an O2 Playlist are all done the same way. The only difference between playing a single video or multiple videos is that the SDK strings multiple videos together, connects up the previous and next player controls UX buttons, and if AutoPlay is on - plays them straight through.

##### _Tutorial Sample:_

> [Playing Videos](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Setting default player controls’ tint color

The built-in tint color of the default video player controls UX is pink/magenta. This is deliberate. You set the tint color of the default player controls by setting the UIViewController’s tintColor. This can be done programmatically or via Interface Builder (IB) in Xcode, for your UIViewController, if you’re instantiating your view that way. In this sample, you’ll find a code block that shows you how to override the default controls color.

##### _Tutorial Sample:_

> [Setting Controls’ Tint Color](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Playing with AutoPlay on/off

By default, the SDK plays videos with AutoPlay mode on. This means, that as soon as you construct a `Player`, the first video queues to play immediately (first, calling for an ad, of course). In this case, no further user action is required. As soon as the ad or the video is ready to play, it will. To override this behavior and turn off AutoPlay, look for the alternate way to construct the `Player` in this sample.

If AutoPlay mode is off, the user will have to tap the play button to start the playback process. Alternatively, you can programmatically do this by controlling the Player object.

##### _Tutorial Sample:_

> [Turning Off AutoPlay](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Playing Muted

You can easily control the mute state of the `Player` object. In this sample, you’ll find a code block that shows you how to set the mute state of the `Player` object.

##### _Tutorial Sample:_

> [Controlling Mute State](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Disabling HLS (or forcing MP4 playback)

Many (but not all) of the videos in the O2 video platform, have multiple renditions. There may be some set of circumstances where you do not want to use HLS (.m3u8) renditions, and therefore, want to force the alternate high resolution .mp4 rendition. As a result, our SDK has the ability to override or disable getting the default HLS rendition. On iOS and tvOS, this is not something that we specifically advocate, so we won't show you this code in this tutorial. If you believe you have a good need for avoiding the network and visual performance improvements that HLS provides, please email [Video Support Team](mailto:video.support@oath.com) and we will be happy to help you!

<a name="tutorial-2"></a>
## Tutorial 2: Customizing the Default Controls UX

This tutorial sample shows you how to further modify the default controls UX.

##### _Tutorial Sample:_

> [Custom UX Color](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Hiding Various Controls buttons

You can change the look of the default controls UX on a player-by-player basis to suit your app design needs. The elements that can be hidden include:
* ± 10 second skip buttons
* Previous and Next buttons
* Seekbar
* Video title
* Elapsed time
* Video duration
* Closed Captioning/SAP Settings button
* Picture-in-Picture (PiP) button
* AirPlay button

If you hide the title, and bottom element buttons such as CC/SAP, PiP, and AirPlay, the seekbar will fall down closer to the bottom of the video frame, to cover the gap usually left for those elements. See this tutorial for examples of how to hide/show these elements.

##### _Tutorial Sample:_

> [Hiding Default Controls Buttons](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Closed Captioning / SAP Settings button

This new feature of the OMSDK is generally dependent on having this information in the HLS stream. There are ways to filter out what CC languages and SAP audio tracks are available. Also, there’s a way to control what the choices are for a given video. One reason to control this may be to implement a “sticky” closed captioning setting. By default, turning CC on only applies the the current playing video. A next or previous video would not have CC on by default. If you wanted your app to support a sticky setting for this, you would do it yourself. This part of this tutorial will show you how to accomplish this.

##### _Tutorial Sample:_

> [Filtered Subtitles](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Using the 4 Custom Sidebar buttons

Use this sample to see how to add custom code and behaviors to one of the 4 sidebar buttons. The Sidebar buttons are part of the default player controls UX and are there for you to add up to 4 different overlays/behaviors to your player. You provide the button graphics – icons for normal, selected, and highlighted modes, and you provide a handler to be called in the case of a button tap. The SDK will handle showing/hiding the buttons along with the other player controls.

##### _Tutorial Sample:_

> [Custom Sidebar Buttons](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Setting the LIVE indicator’s tint color

The LIVE indicator only appears during a LIVE streaming video playback. This will not appear for a video on demand video. Part of the LIVE indicator is the ability to colorize the • that appears next to the LIVE indicator. In general, you may want to use a standard pure-red color. However, it’s possible that you want to use your app’s brand color or while here instead. You can use black or any dark-gray color, but that is ill advised, because of the general nature of video to have lots of blacks in it. The sample code in this example shows how to set this.

##### _Tutorial Sample:_

> [LIVE Indicator Color](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Animations Customization and Disabling

We've added some new animations to our default player controls UX. If you want to change the animation duration, or disable the animations, you can. The sample code in this example shows how to turn off these animations as well as how to change the animation duration.

##### _Tutorial Sample:_

> [Animations Customization and Disabling](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Custom Colors for Seeker Elements

The 2.28 version of SDK now includes a new feature to set custom colors for each element of player's seeker, like current time, progress, cue points etc. It is also possible to set custom color only for one of seeker elements, when the others will have the same color as the view's tint color.

##### _Tutorial Sample:_

> [Custom colors for seeker elements](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

<a name="tutorial-3"></a>
## Tutorial 3: Observing the Player

This tutorial sample shows you how to observe just about everything you can observe from OMSDK `Player` objects. As you would suspect, many properties that can be observed, can also be set or manipulated.

#### Current Playback State and Position

Determining the current state of the `Player` is a key need for apps … most app-level video playback logic starts here. In addition to the play/pause state, also includes the current position. Once you can query for these property values, you can also programmatically modify them.

##### _Tutorial Sample:_

> [Video States](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Looping Playback

If your app has some need to loop a `Player` (one video or many), such as running a kiosk-style interface, for example. This is an easy operation to accomplish with the OMSDK. Look in this example, to see how to determine when playback finishes, and how to reset the video index back to the first video and start it over.

##### _Tutorial Sample:_

> [Looping Videos](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

<a name="live-vod-360"></a>
#### LIVE, VOD, or 360°?

You may need to inspect some more metadata on the video, such as what type of video this is – LIVE, video on demand, or 360°. This tutorial sample shows how to inspect this. You may need to make certain app design or UX decisions accordingly, based on the type of video that’s currently playing.

#### Manually Hooking up Previous or Next Videos

There are many legitimate app UX circumstance, that can dictate the dynamicness of a video player – meaning, that not every app design will simply be setup to operate off fixed playlists or lists of videos. As such, the Player can be modified on the fly to dynamically handle what video is played when the previous or next buttons are tapped. This example tutorial has sample code that shows you precisely how to do this. However, be judicious with the usage of this behavior, and make sure it matches a natural flow of content for the user.

##### _Tutorial Sample:_

> [Hooking Up Next Video](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

<a name="tutorial-4"></a>
## Tutorial 4: Error Handling in the SDK

This tutorial sample shows you how to handle various different types of errors that can occur when using the OMSDK and how to catch and identify them. How you handle these in your app is up to you. The SDK is designed to either return a valid SDK or Player instance otherwise it returns an error. There is no middle ground. If you don’t get a valid instance, you should look at the error result instead to determine why. This section describes some common issues.

#### SDK Initialization Errors

For various reasons, the SDK may fail to initialize. The most common reason for this, is you’re trying to use the OMSDK without first having [onboarded your app’s bundle ID](##Onboarding\ your\ Apps\ for\ SDK\ Authentication). In this case, you’ll get an error that looks like something like this:
```
{
	"error": "Not found - com.company.ungregisteredapp"
} 
```

#### Player Initialization Errors

For various reasons, the `Player` and `OneSDK` may fail to initialize. Errors are usually self-descriptive. 
Contact [Video Support Team](mailto:video.support@oath.com) if you are stuck and we will be happy to help you!

#### Restricted Videos

Videos can be restricted for playback in two very distinct ways. The first is geo restricted content. The second is device restricted content. If you’re attempting to initialize a `Player` with content that’s restricted against your device or geolocation, that content is automatically filtered out. Only valid, playable video IDs are accepted, and have their metadata pulled into the `Player` instance. If you end up with no `Player` instance, it’s because there are no valid video IDs for it to operate on. So, you get an error to this effect. This tutorial sample shows how to detect that a video is not playable because it is restricted.

##### _Tutorial Sample:_

> [Restricted Video](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Deleted Videos

Videos can be deleted by the content owners, for a multitude of reasons including being removed for legal or copyright violations. If you’re attempting to initialize a `Player` with content that represents deleted videos, that content is also filtered out. Only valid, playable video IDs are accepted, and have their metadata pulled into the `Player` instance. If you end up with no `Player` instance, it’s because there are no valid video IDs for it to operate on. So, you get an error to this effect. This tutorial sample shows how to detect that a video is not playable because it has been deleted.

##### _Tutorial Sample:_

> [Deleted Video](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

#### Invalid or Unknown Videos

Only valid, playable video IDs are accepted, and have their metadata pulled into the `Player` instance. If you end up with no `Player` instance, it’s because there are no valid video IDs for it to operate on. If you pass some ID that is incorrect, invalid, or unknown, the SDK has no idea what to do. So, you get an error to this effect. This tutorial sample shows how to detect that a video is not playable because the ID that was passed is invalid or unknown.

##### _Tutorial Sample:_

> [Unknown Video](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials)

## Specific Notes for tvOS Apps

The OMSDK supports tvOS with the same source framework as iOS. We are utilising `AVPlayerViewController` for both content and advertisement playback. Controls also used from this class. As expected - no customisation of UI is allowed for tvOS implementation.

Because there is no way to tap on the screen, you cannot access the ad URL. Additionally, tvOS has no support for web views – so there would be no consistent way to render the ad URL.

<a name="tutorial-5"></a>
### Tutorial 5: Playing Videos on tvOS

This tutorial sample shows you how to do many of the same things as iOS as described above in [Tutorial 1](#tutorial-1), but for tvOS. In terms of the OMSDK, the biggest difference is that you cannot use the default Custom Controls UX with tvOS – you must use the built-in `AVPlayerViewController` controls. With this, you get direct access to the advanced Siri Remote control features, for example.

##### _Tutorial Sample:_

> [Playing Videos on tvOS](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials/Tutorial_tvOS)


## Specific Notes for iPhone X

### Player Controls on the iPhone X

The OMSDK also supports the iPhone X. Video, thumbnail and shadow are stretched to the entire view, when main controls and LIVE indicator are limited by the safe area.

|Portrait|
|--------|
|<img width="302" alt="new-port" src="https://user-images.githubusercontent.com/31652265/36854565-feaaf04e-1d79-11e8-9db0-5359cc2ac0fe.png"> <img width="300" alt="newad-port" src="https://user-images.githubusercontent.com/31652265/36856781-82ec2724-1d7f-11e8-9124-05000b2355ab.png">|

|Landscape|
|--------|
|<img width="600" alt="new-land" src="https://user-images.githubusercontent.com/31652265/36854733-5b511dbe-1d7a-11e8-8c2b-b47d16238b36.png">
<img width="600" alt="newad-land" src="https://user-images.githubusercontent.com/31652265/36856788-8775270a-1d7f-11e8-8fa9-c375fd0b546b.png">|

### Home Indicator Auto Hidden setup

One of the most important changes in iPhone X is that it doesn't have Home Button anymore. It was replaced with a Home Indicator - a small horizontal bar on the bottom of the screen. It is obvious that no one wants to see that indicator showing while the video is playing (especially in full-screen), so we've added logic to our default controls UX that will turn on 'Home Indicator Auto Hidden' mode after our controls are hidden.

### What You Must Do to Enable this Auto-Hiding Behavior in your App

To implement this desired behavior, in the main view controller that contains the `Player` object, you should override the default `childViewControllerForHomeIndicatorAutoHidden` method of `UIViewController`, which has to return the `defaultControlsViewController`. If you don't add that method to your controller, it wouldn't use our implementation, so you will be able to control it on your own.

To see how it works, simply launch our Tutorials app on an iPhone X and play any video.

##### _Tutorial Sample:_

> [Adding Method Override to Support iPhone X](https://github.com/aol-public/OneMobileSDK-playground-ios/tree/master/NewTutorials/Tutorial)

## Next Steps 

### Getting O2 Video/Playlist IDs into your apps

The OMSDK operates on O2 video and playlist IDs. That said, it is the application’s responsibility to dynamically acquire video IDs and/or playlist IDs either via your own CMS (content management system) or perhaps via a direct O2 Search API call. Since apps are generally dynamic in their content (video or otherwise), you need to figure out how to deliver these content IDs into your app, so they can be passed to the SDK to play against. Although unadvised, the easiest possible approach is to hardcode one or more playlist ID[s] into an app, and let those playlists dynamically change their content via the O2 Portal. The upside to this is you don’t need a CMS or further server communications on your end to get video information into your app, and thus to the SDK. The downside, is that if any of those IDs are ever deleted, the app will virtually be useless in terms of O2 video playback.

For more information about the O2 Search API, the O2 Portal, or creation and manipulation of playlists, please email the [Video Support Team](mailto:video.support@oath.com).

### Controlling Ads via your O2 Portal Account

You have some options with respect to ads and the OMSDK. During early development, your developers are going to want ads disabled because they’re intrusive to the development process, and unnecessary. Before you launch, you will likely want to see test or Public Service Announcement (PSA) ads enabled all the time, so you can get a feel for how ads will impact your users in various parts of your app. And, as you launch, you’ll want to enable live production ads for your app, so you’re ready to go as soon as your app passes through the App Store submission process.

To make changes to the ads settings for your app, please contact [Video Support Team](mailto:video.support@oath.com) and they’ll promptly assist you.

## FAQ

### iOS hardware ringer

By default the hardware ringer position (muted/unmuted) is respected - if it is in muted state the video will play without sound.
To override this behavior you need to add following code before creating a player. 
This needs to be done only once - for example this in `AppDelegate` class.

```
let audioSession = AVAudioSession.sharedInstance()
do {
    try audioSession.setCategory(AVAudioSessionCategoryPlayback)
} catch {
    assertionFailure("Audio session `setCategory` failed!")
}
```

Details about this category can be found [here](https://developer.apple.com/documentation/avfoundation/avaudiosessioncategoryplayback?language=objc).

### Extracting SDK version in runtime

If you are looking for SDK version in runtime - here is the code snippet that will extract it:

```
let sdkInfo = Bundle(identifier: "com.aol.one.publishers.OneMobileSDK")?.infoDictionary
print(sdkInfo?["CFBundleShortVersionString"] as? String)
```
