//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

class ViewController: UIViewController {
    @IBAction func playVideoTouched(_ sender: Any) {
        OneSDK.Provider.default.getSDK()
            .then { $0.getPlayer(videoIDs: ["593967be9e45105fa1b5939a",
                                            "577cc23d50954952cc56bc47",
                                            "5939698f85eb427b86aa0a14"]) }
            .dispatch(on: .main)
            .onSuccess {
                let playerViewController = PlayerViewController()
                playerViewController.contentControlsViewController = DefaultControlsViewController()
                playerViewController.player = $0
                self.navigationController?.pushViewController(playerViewController, animated: true)
            }
            .onError { error in
                let alert = UIAlertController(title: "Error",
                                              message: "\(error)",
                    preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: nil))
                self.present(alert, animated: true, completion: nil)
        }
    }
}

