//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit

class TestViewController: UIViewController {
    var toggleFullscreen = { }
    
    @IBAction func fullscreenTouched(_ sender: Any) {
        toggleFullscreen()
    }
    
    override func loadView() {
        super.loadView()
        
        view.layer.borderWidth = 3
        view.layer.borderColor = UIColor.red.cgColor
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(#function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print(#function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print(#function)
    }
}

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var testViewController: UIViewController? { return childViewControllers.first { $0 is TestViewController } }
    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let testViewController = testViewController as? TestViewController else { return }
        
        presentAnimator = PresentAnimator(startFrame: containerView.frame)
        dismissAnimator = DismissAnimator(finalFrame: containerView.frame)
        
        testViewController.modalPresentationStyle = .custom
        testViewController.transitioningDelegate = self
        
        testViewController.toggleFullscreen = { [weak self] in
            if self?.presentedViewController == nil {
                testViewController.willMove(toParentViewController: nil)
                testViewController.view.removeFromSuperview()
                testViewController.removeFromParentViewController()
                
                self?.present(testViewController, animated: true, completion: nil)
            } else {
                self?.dismiss(animated: true) {
                    self?.addChildViewController(testViewController)
                    self?.containerView.addSubview(testViewController.view)
                    testViewController.view.frame = self?.containerView.bounds ?? CGRect.zero
                    testViewController.didMove(toParentViewController: self)
                }
            }
        }
    }
    
    var presentAnimator: PresentAnimator?
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    var dismissAnimator: DismissAnimator?
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
}
