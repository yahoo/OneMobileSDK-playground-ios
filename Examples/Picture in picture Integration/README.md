# Picture-In-Picture + OneMobileSDK
Example contains:
 
 - Demonstration of Picture-in-Picture functionality built in OneMobileSDK

default/inactive state | active state
--- | --- 
![pip_inactive_screen_shot](https://user-images.githubusercontent.com/23476223/29076763-1f8e4d36-7c5f-11e7-81b2-de838d998639.png)|![pip_active_screen_shot](https://user-images.githubusercontent.com/23476223/29076575-9684aeae-7c5e-11e7-976d-c2ff4ce5f291.png)

 - **Required** steps of configuration for the client app (details also could be found [here](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/AdoptingMultitaskingOniPad/QuickStartForPictureInPicture.html)):

  1. Set UIBackgroundMode for audio under the project settings.
  2. Set audio session category to AVAudioSessionCategoryPlayback or AVAudioSessionCategoryPlayAndRecord.
