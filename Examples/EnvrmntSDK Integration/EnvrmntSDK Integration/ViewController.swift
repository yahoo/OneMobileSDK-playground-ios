//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls
import VideoRenderer
import EnvrmntRenderer
import VRSDK

class ViewController: UIViewController {

    @IBAction func playVideoTouched(_ sender: Any) {
        Renderer.Repository.shared.register(renderer: RendererViewController.renderer)

        let oneSdk = OneSDK.Provider.default.getSDK()
        
        oneSdk
            .then {
                $0.getPlayer(playlistID: "58f0bcd6955a317b117831d8")
            }
            .dispatch(on: .main)
            .onSuccess { player in
                let playerViewController = PlayerViewController()
                playerViewController.contentControlsViewController = DefaultControlsViewController()
                playerViewController.player = player
                playerViewController.edgesForExtendedLayout = []
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
