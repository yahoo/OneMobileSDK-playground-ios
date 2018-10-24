//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import AVKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        /*
         This code ignores iOS hardware ringer silent mode - so
         video will be playing with sound.
         Use it if you want to override default behavior.
        */
        let audioSession = AVAudioSession.sharedInstance()
        do {
            if #available(iOS 10.0, *) {
                try audioSession.setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default)
            }
        } catch {
            assertionFailure("Audio session setCategory failed")
        }

        return true
    }
}
