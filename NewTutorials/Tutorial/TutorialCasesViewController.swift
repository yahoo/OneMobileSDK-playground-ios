//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

func setupPlayingVideos(vc: TutorialCasesViewController) {
    func onSuccess(player: Player) {
        let playerViewController = PlayerViewController()
        playerViewController.contentControlsViewController = DefaultControlsViewController()
        playerViewController.player = player
        vc.navigationController?.pushViewController(playerViewController, animated: true)
    }
    
    vc.props = .init(
        rows: [
            TextCell.ViewModel.init(name: "Single video", action: {
                vc.show(player: singleVideo().dispatch(on: .main).onSuccess(call: onSuccess))
            }),
            TextCell.ViewModel.init(name: "Array of videos", action: {
                vc.show(player: arrayOfVideos().dispatch(on: .main).onSuccess(call: onSuccess))
            }),
            TextCell.ViewModel.init(name: "Video playlist", action: {
                vc.show(player: videoPlaylist().dispatch(on: .main).onSuccess(call: onSuccess))
            }),
            TextCell.ViewModel.init(name: "Muted video", action: {
                func mute(player: inout Player) { player.mute() }
                vc.show(player: singleVideo().map(mute).dispatch(on: .main).onSuccess(call: onSuccess))
            }),
            TextCell.ViewModel.init(name: "Video without autoplay", action: {
                vc.show(player: singleVideo(isAutoplay: false).dispatch(on: .main).onSuccess(call: onSuccess))
            })])
}

class TutorialCasesViewController: UITableViewController {
    struct Props {
        var rows: [CellViewModel] = []
    }
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    var props: Props = Props()
    
    func show(player: Future<Result<Player>>) {
        view.isUserInteractionEnabled = false
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        
        func stopWaiting() {
            self.view.isUserInteractionEnabled = true
            self.activityIndicator.stopAnimating()
        }
        
        player
            .dispatch(on: .main)
            .onSuccess { _ in stopWaiting() }
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return props.rows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell") as? TextCell else {
            fatalError("Unknown cell")
        }
        guard let viewModel = props.rows[indexPath.row] as? TextCell.ViewModel else {
            fatalError("Unknown view model")
        }
        
        cell.viewModel = viewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = props.rows[indexPath.row] as? TextCell.ViewModel else {
            fatalError("Unknown view model")
        }
        viewModel.action()
    }
}

