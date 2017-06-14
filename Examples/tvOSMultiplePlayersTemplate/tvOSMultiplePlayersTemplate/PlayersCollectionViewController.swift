
//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK
import AVFoundation
import AVKit

class PlayersCollectionViewController: UICollectionViewController {
    
    var dataSource: PlayersCollectionDTO?
    var provider = OneSDK.Provider.default
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let dataSource = self.dataSource else { return }
        
        for playerData in dataSource.playersData {
            self.provider.context.extra = ["noAds": true]
            self.provider.getSDK()
                .then { $0.videoProvider.getVideosBy(videoIDs: [playerData.videoId]) }
                .dispatch(on: .main)
                .onComplete(callback: handle)
        }
    }
    
    func handle(result: Result<VideoProvider.Response>) {
        
        switch result {
        case .value(let response):
            
            self.provider.getSDK()
                .map{ return $0.makePlayer(videoResponse: response, autoplay: false) }
                .dispatch(on: .main)
                .onSuccess(call: { (player) in
                    
                    let systemPlayerViewController = SystemPlayerViewController()
                    systemPlayerViewController.player = player
                    
                    guard let videoId = response.videos.flatMap({ (videoResponse) -> String? in
                        switch(videoResponse) {
                        case .video(let video):
                            return video.id
                        default: return nil
                        }
                    }).first, let index = self.dataSource?.insert(playerVC: systemPlayerViewController, toVideoWithId: videoId) else {
                        return
                    }
                    
                    _ = player.addObserver({ (props) in
                        if let isPlaybackReady = props.playbackItem?.content.isPlaybackReady {
                            print("isPlaybackReady = ", isPlaybackReady)
                        }
                    })
                    
                    let indexPath = IndexPath(row: index, section: 0)
                    let playerCell = self.collectionView?.cellForItem(at: indexPath) as? PlayersCollectionViewCell
                    playerCell?.removePlayerVCProperly()
                    self.collectionView?.reloadItems(at: [indexPath])
                })
        case .error(let error):
            let alert = UIAlertController(title: "Error",
                                          message: "\(error)",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.playersData.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayersCollectionCellId", for: indexPath)
        
        if let playerCell = cell as? PlayersCollectionViewCell,
            let dataSource = self.dataSource, indexPath.row < dataSource.playersData.count,
            let systemPlayerViewController = dataSource.playersData[indexPath.row].playerVC {
            playerCell.removePlayerVCProperly()
            
            systemPlayerViewController.view.frame = CGRect(x: 0, y: 0, width: playerCell.contentView.frame.size.width, height: playerCell.contentView.frame.size.height)
            playerCell.systemPlayerViewController = systemPlayerViewController
            
            systemPlayerViewController.willMove(toParentViewController: self)
            self.addChildViewController(systemPlayerViewController)
            playerCell.contentView.addSubview(systemPlayerViewController.view)
            systemPlayerViewController.didMove(toParentViewController: self)
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return false
    }
}

struct PlayersCollectionDTO {
    
    struct PlayerCellDTO {
        let videoId: String
        var playerVC: SystemPlayerViewController?
        
        init(videoId: String) {
            self.videoId = videoId
            self.playerVC = nil
        }
    }
    
    mutating func insert(playerVC: SystemPlayerViewController, toVideoWithId id: String) -> Int? {
        
        let index = self.playersData.index { (playerDTO) -> Bool in
            return playerDTO.videoId == id
        }
        
        if let index = index {
            self.playersData[index].playerVC = playerVC
        }
        
        return index
    }
    
    var playersData: [PlayerCellDTO]
}

class PlayersCollectionViewCell: UICollectionViewCell {
    var systemPlayerViewController: SystemPlayerViewController?
    
    func removePlayerVCProperly() {
        self.systemPlayerViewController?.willMove(toParentViewController: nil)
        self.systemPlayerViewController?.removeFromParentViewController()
        self.systemPlayerViewController?.view.removeFromSuperview()
        self.systemPlayerViewController = nil
    }
}
