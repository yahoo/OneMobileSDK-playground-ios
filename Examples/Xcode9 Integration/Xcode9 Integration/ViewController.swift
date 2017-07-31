//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

class ViewController: UIViewController {
    @IBAction func playVideoTouched(_ sender: Any) {
        OneSDK.Provider.default.getSDK()
            .then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47") }
            .dispatch(on: .main)
            .onSuccess(call: render)
            .onError(call: render)
    }
    
    private func render(player: Player) {
        let playerViewController = PlayerViewController()
        playerViewController.contentControlsViewController = DefaultControlsViewController()
        playerViewController.player = player
        present(playerViewController, animated: true, completion: nil)
    }
    
    private func render(error: Swift.Error) {
        let alert = UIAlertController(title: "Error",
                                      message: "\(error)",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

