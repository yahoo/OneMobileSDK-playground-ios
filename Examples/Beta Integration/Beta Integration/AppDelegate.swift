//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK

let oneSDK = OneSDK.Provider.default.getSDK()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        return true
    }

}

