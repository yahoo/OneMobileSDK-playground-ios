//  Copyright © 2017 Oath. All rights reserved.

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        guard let navigation = window?.rootViewController as? UINavigationController else { return false }
        guard let tutorials = navigation.viewControllers.first as? TutorialCasesViewController else { return false }
        setup(tutorialCasesViewController: tutorials)
        return true
    }
}
