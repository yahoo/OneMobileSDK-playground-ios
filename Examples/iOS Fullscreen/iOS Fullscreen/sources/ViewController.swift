//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

class ViewController: UIViewController {
    override func loadView() {
        super.loadView()
        
        let fullscreenViewController = FullscreenViewController()
        addChildViewController(fullscreenViewController)
        fullscreenViewController.view.frame = CGRect(x: 0,
                                                     y: 100,
                                                     width: view.frame.width,
                                                     height: 400)
        view.addSubview(fullscreenViewController.view)
        fullscreenViewController.didMove(toParentViewController: self)
        
        let controls = DefaultControlsViewController()
        
        let fullscreenIcons = SideBarView.ButtonProps.Icons(
            normal: #imageLiteral(resourceName: "icon-fullscreen"),
            selected: nil,
            highlighted: #imageLiteral(resourceName: "icon-fullscreen-active"))
        
        let minimizeIcons = SideBarView.ButtonProps.Icons(
            normal: #imageLiteral(resourceName: "icon-fullscreen-out"),
            selected: nil,
            highlighted: #imageLiteral(resourceName: "icon-fullscreen-out-active"))
        
        let fullscreen = SideBarView.ButtonProps(
            isEnabled: true,
            isSelected: false,
            icons: fullscreenIcons,
            handler: { [weak fullscreen = fullscreenViewController] in
                guard let fullscreen = fullscreen else { return }
                switch fullscreen.state {
                case .normal(let present):
                    present()
                    controls.sidebarProps[0].icons = minimizeIcons
                case .fullscreen(_, let dismiss):
                    dismiss()
                    controls.sidebarProps[0].icons = fullscreenIcons
                default: break
                }
        })
        
        controls.sidebarProps = [fullscreen]
        
        let playerViewController = PlayerViewController()
        playerViewController.contentControlsViewController = controls
        playerViewController.customizeContentControlsProps = { props in
            guard let controls = props.player else { return props }
            guard var content = controls.item.playable else { return props }
            
            /* Seekbar at bottom */do {
                guard case .normal = fullscreenViewController.state else { return props }
                content.live.isHidden = true
                content.pictureInPictureControl = .unsupported
                content.settings.isHidden = true
                content.title = ""
            }
            
//            /* Change live dot color to red */do {
//                content.live.dotColor = .red
//            }
            
            return .player(.init {
                $0.playlist = controls.playlist
                $0.item = .playable(content)
                })
        }
        fullscreenViewController.childViewController = playerViewController
        
        OneSDK.Provider.default.getSDK()
            .then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47") }
            .dispatch(on: .main)
            .onSuccess { playerViewController.player = $0 }
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
