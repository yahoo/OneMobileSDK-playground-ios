//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

class PlayingVideosViewController: UITableViewController {
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    private let sdk = OneSDK.Provider.default.getSDK()
    
    func run(player: Future<Result<Player>>) {
        view.isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        let stopWaiting = {
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
        }
        
        player
            .dispatch(on: .main)
            .onSuccess {
                let playerViewController = PlayerViewController()
                playerViewController.contentControlsViewController = DefaultControlsViewController()
                playerViewController.player = $0
                self.navigationController?.pushViewController(playerViewController, animated: true)
                stopWaiting()}
            .onError { error in
                let alert = UIAlertController(title: "Error",
                                              message: "\(error)",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK",
                                              style: .default,
                                              handler: nil))
                self.present(alert, animated: true, completion: nil)
                stopWaiting()}
    }
}
