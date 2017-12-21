//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls


class PlayerViewControllerWrapper: UIViewController {
    struct Props {
        var player: Future<Result<Player>>?
        // Using default controls but it's possible to use custom by subclassing from ContentControlsViewController and set it to contentControlsViewController
        var controlsViewController: ContentControlsViewController = DefaultControlsViewController()
        var controlsColor: UIColor?
        var isHiddenSomeControls = false
        var liveDotColor: UIColor?
        var sidebarProps: SideBarView.Props = []
        var isFilteredSubtitles = false
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
            
            func render(player: Player) {
                playerViewController?.customizeContentControlsProps = { [weak self] props in
                    // Mudifing content props only if content video can be played
                    guard var player = props.player else { return props }
                    guard var controls = player.item.playable else { return props }
                    
                    // Changing color of live dot indicator
                    controls.live.dotColor = self?.props.liveDotColor
                    
                    // Hiding 10s seek button and setting button
                    if self?.props.isHiddenSomeControls == true {
                        controls.seekbar?.seeker.seekTo = nil
                        controls.settings = .hidden
                    }
                    
                    // Filtering subtitles by name
                    if self?.props.isFilteredSubtitles == true {
                        guard case .`internal`(var group) = controls.legible else { return props }
                        guard let options = group?.options else { return props }
                        group?.options = options.filter { !$0.name.contains("English") }
                        controls.legible = .`internal`(group)
                    }
                    
                    var props = props
                    player.item = .playable(controls)
                    props = .player(player)
                    
                    return props
                }
                
                playerViewController?.player = player
            }
            
            isLoading = true
            player
                .dispatch(on: .main)
                .onSuccess(call: render)
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
        
        // Changing color of content view controller controls
        playerViewController?.view.tintColor = props.controlsColor
        
        // Adding sidebar buttons
        if let defaultControlsViewController = playerViewController?.contentControlsViewController as? DefaultControlsViewController {
            defaultControlsViewController.sidebarProps = props.sidebarProps
        }
    }
}
