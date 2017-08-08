 This example demonstrates how to get picture in picture playback of content video. The example also demonstrates the configuration setup required by an application to be able to use picture in picture.
 
 - Demonstration of Picture-in-Picture functionality built in OneMobileSDK

inactive state | active state
--- | --- 
![pip_inactive_screen_shot](https://user-images.githubusercontent.com/23476223/29076763-1f8e4d36-7c5f-11e7-81b2-de838d998639.png)|![pip_active_screen_shot](https://user-images.githubusercontent.com/23476223/29076575-9684aeae-7c5e-11e7-976d-c2ff4ce5f291.png)

 - Required configuration setup for the client app:

  1. Setting UIBackgroundMode to audio under the project settings.
  2. Setting audio session category to AVAudioSessionCategoryPlayback or AVAudioSessionCategoryPlayAndRecord (as appropriate)

If an application is not configured correctly, picture in picture button will never become enabled.

