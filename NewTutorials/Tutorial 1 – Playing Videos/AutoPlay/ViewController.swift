//  Copyright © 2017 One by AOL : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

class ViewController: UIViewController {
    @IBOutlet weak private var autoplaySwitcher: UISwitch!
    private var isAutoplay = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.autoplaySwitcher.isOn = self.isAutoplay
    }
    
    @IBAction func autoplayToggled(sender: UISwitch) {
        self.isAutoplay = sender.isOn
    }
    
    @IBAction func playVideoTouched(_ sender: Any) {
        OneSDK.Provider.default.getSDK()
            .then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47",
                                 autoplay: self.isAutoplay) }
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
