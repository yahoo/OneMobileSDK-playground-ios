//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /*
         This code ignores iOS hardware ringer silent mode - so
         video will be playing with sound.
         Use it if you want to override default behavior.
        */
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
        } catch {
            assertionFailure("Audio session `setCategory` failed!")
        }

        return true
    }
}

