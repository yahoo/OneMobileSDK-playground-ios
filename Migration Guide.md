# Migration Guide

**OneMobileSDK** version **2.30** is the **final** release - all future changes will be added to **VerizonVideoPartnerSDK**.

This guide will be helpful for those who want to grab the latest and greatest [**VVPSDK**](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-iOS) (formerly **OneMobileSDK**).

As a benefit of making the migration - we dropped binary distribution and all sources are distributed as is - so you will no longer need to follow Xcode Swift updates - only the major one's :)

## Public API

Of course, there are changes in the **Public API**, but there are **NO** changes in terms of functionality if we compare **SDKs**.

All **tutorials** are ready for use and updated to latest **VerizonVideoPartnerSDK** - here is [**link to tutorials**](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-iOS/tree/master/tutorials).

## Steps

So what needs to be changed in your project:

1. Update the **Podfile**:
   - **OneMobileSDK:**
        ```ruby
        source "https://github.com/vidible/OneMobileSDK-releases.git"

        pod 'OneMobileSDK-Xcode10'
        ```
   - **VerizonVideoPartnerSDK:**
        ```ruby
        # link to podspec sources remains the same (org was renamed (vidible -> VerizonAdPlatforms) - but old link still works)
        source 'https://github.com/VerizonAdPlatforms/OneMobileSDK-releases-iOS.git'

        # Renamed OneMobileSDK
        pod 'VerizonVideoPartnerSDK'
        ```
2. Change the import in place where you have used **OneMobileSDK**.
    - **OneMobileSDK:**
        ```swift
        import OneMobileSDK
        ```
    - **VerizonVideoPartnerSDK:**
        ```swift
        import VerizonVideoPartnerSDK
        ``` 
3. Shorthand `OneSDK` -> `VVPSDK`
   - **OneMobileSDK:**
        ```swift
        OneSDK.Provider()
        ```
    - **VerizonVideoPartnerSDK:**
        ```swift
        VVPSDK.Provider()
        ``` 
4. XIB or Stroryboard Module Name (if you are instantiating `PlayerViewController` from XIB or Storyboard)

    If you are using `PlayerViewController` in XIB file - you have to rename the module from `OneMobileSDK` to `VerizonVideoPartner` - otherwise the class will not be loaded.
