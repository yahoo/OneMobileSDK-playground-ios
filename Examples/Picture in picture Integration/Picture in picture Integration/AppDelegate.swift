//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /*
         Setup audio session for picture in picture playback.
         Application has to be configured correctly to be able to initiate picture in picture.
         This configuration involves:
         
         1. Setting UIBackgroundMode to audio under the project settings.
         
         2. Setting audio session category to AVAudioSessionCategoryPlayback or AVAudioSessionCategoryPlayAndRecord (as appropriate)
         
         https://developer.apple.com/library/content/samplecode/AVFoundationPiPPlayer/Listings/README_md.html#//apple_ref/doc/uid/TP40016166-README_md-DontLinkElementID_7
         */
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        }
        catch {
            preconditionFailure("Audio session setCategory failed")
        }
        
        return true
    }
}

