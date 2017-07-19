//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit

class FullscreenViewController: UIViewController, UIViewControllerTransitioningDelegate {
    var childViewController: UIViewController? {
        willSet {
            guard let child = childViewController else { return }
            
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        didSet {
            guard let child = childViewController else { return }
            
            addChildViewController(child)
            child.view.frame = view.bounds
            view.addSubview(child.view)
            child.didMove(toParentViewController: self)
        }
    }
    
    func presentFullScreen() {
        guard let parent = parent else { return }
        guard case .normal = state else { return }
        let context = State.Context(superView: view.superview,
                                    parent: parent,
                                    frame: view.frame)
        state = .appearing(context)
        
        removeFromParentViewController()
        let controller = parent.presentedViewController ?? parent
        
        controller.present(self, animated: true) {
            self.state = .fullscreen(context,
                                     dismiss: { [weak self] in self?.dismissFullScreen() })
        }
    }
    
    func dismissFullScreen() {
        guard case .fullscreen(let context, _) = state else { return }
        state = .disappearing(context)

        context.parent.dismiss(animated: true) {
            context.parent.addChildViewController(self)
            self.view.frame = context.frame
            context.superView?.addSubview(self.view)
            self.didMove(toParentViewController: context.parent)
        }
    }

    enum State {
        case blank
        case normal(present: (Void) -> Void)
        case appearing(Context)
        case fullscreen(Context, dismiss: (Void) -> Void)
        case disappearing(Context)
        
        struct Context {
            let superView: UIView?
            let parent: UIViewController
            let frame: CGRect
        }
    }
    private(set) var state = State.blank
    
    override var shouldAutomaticallyForwardAppearanceMethods: Bool {
        return false
    }
    
    override func loadView() {
        super.loadView()
        
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }
    
    override func viewWillAppear(_ animated: Bool) {
        switch state {
        case .blank:
            state = .normal(present: { [weak self] in self?.presentFullScreen() })
            fallthrough
        case .normal, .fullscreen:
            print(#function)
            childViewController?.beginAppearanceTransition(true, animated: animated)
        default: break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        switch state {
        case .normal, .fullscreen:
            print(#function)
            childViewController?.endAppearanceTransition()
        case .disappearing:
            state = .normal(present: { [weak self] in self?.presentFullScreen() })
        default: break
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        switch state {
        case .normal, .fullscreen:
            print(#function)
            childViewController?.beginAppearanceTransition(false, animated: animated)
        default: break
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        switch state {
        case .normal, .fullscreen:
            print(#function)
            childViewController?.endAppearanceTransition()
        default: break
        }
    }
    
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard case .appearing(let context) = state else { return nil }
        return PresentAnimator(duration: 1.0, startFrame: context.frame)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        guard case .disappearing(let context) = state else { return nil }
        return DismissAnimator(duration: 1.0, finalFrame: context.frame)
    }
}
