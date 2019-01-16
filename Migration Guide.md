# Migration Guide – One Mobile SDK ⇒ Verizon Video Partner SDK

We have a new successor SDK going forward. **OneMobileSDK** version **2.30** is the **final** release under this name and repo – we have moved to fully open source and have spun up a new repo. All future changes will be added to [**VerizonVideoPartnerSDK (VVPSDK)**](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-iOS). 

This guide will be helpful for those who want to grab the latest and greatest [**VerizonVideoPartnerSDK**](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-iOS) (formerly **OneMobileSDK**). As a benefit of making the migration - we dropped binary distribution and all sources are distributed as is - so you will no longer need to follow Xcode Swift updates - only the major one's 😀.

## Public API

There are, of course, changes in the **Public API**, but there are **NO** changes in terms of functionality if we compare the two *SDKs*.

**Note:** All the SDK **tutorials** have been updated to latest **VerizonVideoPartnerSDK** and are ready for use. You can find them here: [**link to new tutorials**](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-iOS/tree/master/tutorials).

## Migration Steps

The following few changes need to be made in your OneMobileSDK projects:

### 1. Update your **Podfile**:
   - **OneMobileSDK:**
        ```ruby
        source "https://github.com/vidible/OneMobileSDK-releases.git"

        pod 'OneMobileSDK-Xcode10'
        ```
   - **VerizonVideoPartnerSDK:**
        ```ruby
        # New link to podspec sources
        source 'https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-releases-iOS'

        # Renamed SDK pod name
        pod 'VerizonVideoPartnerSDK'
        ```
### 2. Change the import in place where you have used **OneMobileSDK**
   - **OneMobileSDK:**
        ```swift
        import OneMobileSDK
        ```
   - **VerizonVideoPartnerSDK:**
        ```swift
        import VerizonVideoPartnerSDK
        ``` 
### 3. Shorthand `OneSDK` ⇒ `VVPSDK`
   - **OneMobileSDK:**
        ```swift
        OneSDK.Provider()
        ```
   - **VerizonVideoPartnerSDK:**
        ```swift
        VVPSDK.Provider()
        ``` 
### 4. XIB or Stroryboard Module Name (if you are instantiating `PlayerViewController` from XIB or Storyboard)

If you are using `PlayerViewController` in XIB file - you have to rename the module from `OneMobileSDK` to `VerizonVideoPartner` - otherwise the class will not be loaded.
    
**That's it!**

## Contact Us

As always, we highly appreciate, welcome, and value all feedback on this documentation or the VVPSDK in any way, shape, or form. If you have any suggestions for corrections, additions, or any further clarity, please don’t hesitate to email the [Video Support Team](mailto:video.support@oath.com).
