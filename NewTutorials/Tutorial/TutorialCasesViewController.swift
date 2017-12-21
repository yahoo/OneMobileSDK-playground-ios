//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls


class TutorialCasesViewController: UITableViewController {
    struct Props {
        var rows: [TextCell.ViewModel] = []
    }
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    var props: Props = Props() {
        didSet {
            guard isViewLoaded else { return }
            tableView.reloadData()
        }
    }
    
    func show(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as? TextCell else {
            fatalError("Unknown cell")
        }
        cell.viewModel = props.rows[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        props.rows[indexPath.row].action()
    }
}

class PlayerViewControllerWrapper: UIViewController {
    struct Props {
        var isLoading = false
        var controlsColor: UIColor?
        var isHiddenSomeControls = false
        var liveDotColor: UIColor?
        var sidebarProps: SideBarView.Props = []
        var isFilteredSubtitles = false
    }
    
    var props = Props() {
        didSet {
            view.setNeedsLayout()
        }
    }
    
    private let playerViewController: PlayerViewController = {
        let playerViewController = PlayerViewController()
        // Using default controls but it's possible to use custom by subclassing from ContentControlsViewController and set it to contentControlsViewController
        playerViewController.contentControlsViewController = DefaultControlsViewController()
        return playerViewController
    }()
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.activityIndicatorViewStyle = .gray
        activityIndicatorView.isHidden = true
        return activityIndicatorView
    }()
    
    func attach(player: Player) {
        playerViewController.player = player
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        do {
            playerViewController.willMove(toParentViewController: self)
            addChildViewController(playerViewController)
            view.addSubview(playerViewController.view)
            playerViewController.didMove(toParentViewController: self)
            activityIndicatorView.color = view.tintColor
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicatorView)
        
        playerViewController.customizeContentControlsProps = { [weak self] props in
            // Mudifing content props only if content video can be played
            guard props.player?.item.playable != nil else { return props }
            var props = props
            
            // Changing color of live dot indicator
            props.player?.item.playable?.live.dotColor = self?.props.liveDotColor
            
            // Hiding 10s seek button and setting button
            if self?.props.isHiddenSomeControls == true {
                props.player?.item.playable?.seekbar?.seeker.seekTo = nil
                props.player?.item.playable?.settings = .hidden
            }
            
            // Filtering subtitles by name
            if self?.props.isFilteredSubtitles == true {
                guard case .`internal`(var group)? = props.player?.item.playable?.legible else { return props }
                guard let options = group?.options else { return props }
                var props = props
                group?.options = options.filter { !$0.name.contains("English") }
                props.player?.item.playable?.legible = .`internal`(group)
            }
            
            return props
        }
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        activityIndicatorView.isHidden = !props.isLoading
        props.isLoading ?
            activityIndicatorView.startAnimating() :
            activityIndicatorView.stopAnimating()
        
        // Changing color of content view controller controls
        playerViewController.view.tintColor = props.controlsColor
        
        // Adding sidebar buttons
        if let defaultControlsViewController = playerViewController.contentControlsViewController as? DefaultControlsViewController {
            defaultControlsViewController.sidebarProps = props.sidebarProps
        }
    }
}
