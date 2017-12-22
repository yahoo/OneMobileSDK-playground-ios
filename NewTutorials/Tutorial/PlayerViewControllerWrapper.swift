//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls


class PlayerViewControllerWrapper: UIViewController {
    struct Props {
        var player: Future<Result<Player>>?
        var controlsViewController: ContentControlsViewController = DefaultControlsViewController()
    }
    
    var props = Props() {
        didSet {
            view.setNeedsLayout()
            
            guard let player = props.player else { playerViewController?.player = nil; return }
            
            func show(error: Error) {
                let alert = UIAlertController(title: "Error",
                                              message: "\(error)",
                    preferredStyle: .alert)
                alert.addAction(.init(title: "OK",
                                      style: .default,
                                      handler: nil))
                present(alert,
                        animated: true,
                        completion: nil)
            }
            
            isLoading = true
            player
                .dispatch(on: .main)
                .onSuccess { [weak self] in self?.playerViewController?.player = $0 }
                .onError(call: show)
                .onComplete { [weak self] _ in self?.isLoading = false }
        }
    }
    private var isLoading = false {
        didSet {
            view.setNeedsLayout()
        }
    }
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!
    private var playerViewController: PlayerViewController? {
        return childViewControllers.first as? PlayerViewController
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        activityIndicatorView.isHidden = !isLoading
        isLoading ?
            activityIndicatorView.startAnimating() :
            activityIndicatorView.stopAnimating()
        
        playerViewController?.contentControlsViewController = props.controlsViewController
    }
}
