//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

class ViewController: UIViewController {
    @IBAction func playVideoTouched(_ sender: Any) {
        oneSDK
            .then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47") }
            .dispatch(on: .main)
            .onSuccess { player in
                self.render(player: player)
                self.observe(player: player)
            }
            .onError { error in
                self.process(error: error)
        }
    }
    
    private func render(player: Player) {
        let playerViewController = PlayerViewController()
        playerViewController.contentControlsViewController = DefaultControlsViewController()
        playerViewController.player = player
        navigationController?.pushViewController(playerViewController, animated: true)
    }
    
    private func observe(player: Player) {
        _ = player.addUIObserver { props in
            /* There are 2 types of player item's -
            available for playback and unavailable. */ do {
                switch props.item {
                case .available: break
                case .unavailable: break
                }
            }
            /* Interested only in playback item. */ do {
                if let item = props.playbackItem {
                    /* Content video props */
                    _ = item.content
                    
                    /* Ad video props */
                    _ = item.ad
                }
            }
            
            /* Interested in handling unavailable item. */ do {
                if let item = props.errorItem {
                    _ = item.reason
                }
            }
        }
    }
    
    private func process(error: Swift.Error) {
        let alert = UIAlertController(title: "Error",
                                      message: "\(error)",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

