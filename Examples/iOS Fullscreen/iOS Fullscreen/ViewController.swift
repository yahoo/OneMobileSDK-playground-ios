//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

class ViewController: UIViewController {
    
    var playerViewController: PlayerViewController? {
        return childViewControllers.first { controller in
            return (controller as? PlayerViewController) != nil
        } as? PlayerViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        OneSDK.Provider.default.getSDK()
            .then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47") }
            .dispatch(on: .main)
            .onSuccess { player in
                guard let playerViewController = self.playerViewController else { return }
                self.modalPresentationStyle = .overFullScreen
                let currentFrame = playerViewController.view.frame
                playerViewController.modalPresentationStyle = .custom
                playerViewController.transitioningDelegate = self
                
                func moveToFullScreen() {
                    if self.presentedViewController == nil {
                        playerViewController.willMove(toParentViewController: nil)
                        playerViewController.view.removeFromSuperview()
                        playerViewController.removeFromParentViewController()
                        self.present(playerViewController, animated: true, completion: nil)
                    } else {
                        self.dismiss(animated: true) {
                            self.addChildViewController(playerViewController)
                            playerViewController.view.frame = currentFrame
                            self.view.addSubview(playerViewController.view)
                            playerViewController.didMove(toParentViewController: self)
                        }
                    }
                }
                
                let defaultControls = DefaultControlsViewController()
                defaultControls.sidebarProps = [.init(isEnabled: true,
                                                      isSelected: false,
                                                      icons: .init(normal: #imageLiteral(resourceName: "icon-fullscreen"),
                                                                   selected: nil,
                                                                   highlighted: #imageLiteral(resourceName: "icon-fullscreen-active")),
                                                      handler: moveToFullScreen)]
                playerViewController.contentControlsViewController = defaultControls
                playerViewController.player = player
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
    
    let transition = FullscreenAnimator()
}

class FullscreenAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.5
    var originFrame = CGRect.zero
    var presenting = true
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard let toView = transitionContext.view(forKey: .to) else { return }
        if presenting { originFrame = toView.frame }
        
        containerView.addSubview(toView)
        UIView.animate(withDuration: duration,
                       animations: {
                        toView.frame = self.presenting ? containerView.frame : self.originFrame
        },
                       completion: { _ in
                        transitionContext.completeTransition(true)
        })
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.presenting = false
        return transition
    }
}
