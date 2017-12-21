//  Copyright © 2017 Oath. All rights reserved.

import UIKit

class PresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    let startFrame: CGRect
    
    init(duration: TimeInterval = 1.0, startFrame: CGRect) {
        self.startFrame = startFrame
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        guard
            let toView = transitionContext.view(forKey: .to),
            let toViewController = transitionContext.viewController(forKey: .to) else { return }
        
        containerView.addSubview(toView)
        toView.frame = startFrame
        
        func animation() {
            toView.frame = transitionContext.finalFrame(for: toViewController)
            toView.layoutIfNeeded()
        }
        
        if transitionContext.isAnimated {
            UIView.animate(withDuration: duration,
                           animations: animation,
                           completion: { _ in transitionContext.completeTransition(true) })
        } else {
            animation()
        }
    }
}

class DismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    let finalFrame: CGRect
    
    init(duration: TimeInterval = 1.0, finalFrame: CGRect) {
        self.finalFrame = finalFrame
        self.duration = duration
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        
        func animation() {
            fromView.frame = self.finalFrame
            fromView.layoutIfNeeded()
        }
        
        if transitionContext.isAnimated {
            UIView.animate(withDuration: duration,
                           animations: animation,
                           completion: { _ in transitionContext.completeTransition(true) })
        } else {
            animation()
        }
    }
}
