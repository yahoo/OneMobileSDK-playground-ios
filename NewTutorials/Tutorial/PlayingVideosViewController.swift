//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

func setup(playingVideoViewController vc: PlayingVideosViewController) {
    var utility = Utility()
    
    vc.props = PlayingVideosViewController.Props.init(
        sections: [
            .init(rows: [
                TextCell.ViewModel.init(name: "Single video", action: {
                    vc.run(player: utility.singleVideo())
                }),
                TextCell.ViewModel.init(name: "Array of videos", action: {
                    vc.run(player: utility.arrayOfVideos())
                }),
                TextCell.ViewModel.init(name: "Video playlist", action: {
                    vc.run(player: utility.videoPlaylist())
                })]),
            .init(rows: [
                SwitchCell.ViewModel.init(name: "Mute", action: {
                    utility.toggleMute()
                }),
                SwitchCell.ViewModel.init(name: "Autoplay", action: {
                    utility.toggleAutoplay()
                })])
        ])
}

class PlayingVideosViewController: UITableViewController {
    struct Props {
        let sections: [Section]
        struct Section {
            let rows: [CellViewModel]
        }
    }
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    var props: Props!
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return props.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.sections[section].rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch props.sections[indexPath.section].rows[indexPath.row] {
        case let viewModel as TextCell.ViewModel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as? TextCell else {
                fatalError("Unknown cell")
            }
            cell.viewModel = viewModel
            return cell
        case let viewModel as SwitchCell.ViewModel:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SwitchCell") as? SwitchCell else {
                fatalError("Unknown cell")
            }
            cell.viewModel = viewModel
            return cell
        default: fatalError("Unknown view model")
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch props.sections[indexPath.section].rows[indexPath.row] {
        case let viewModel as TextCell.ViewModel: viewModel.action()
        default: break
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        switch props.sections[indexPath.section].rows[indexPath.row] {
        case is SwitchCell.ViewModel: return nil
        default: return indexPath
        }
    }
}
