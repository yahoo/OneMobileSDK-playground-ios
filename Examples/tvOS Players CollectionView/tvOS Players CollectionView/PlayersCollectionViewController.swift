
//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import OneMobileSDK

final class PlayersCollectionViewController: UICollectionViewController {
    var models = [] as [Model]
    
    let sdk: Future<Result<OneSDK>> = {
        var provider = OneSDK.Provider.default
        provider.context.extra = ["noAds" : true]
        return provider.getSDK()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for model in models {
            sdk.then { $0.videoProvider.getVideosBy(videoIDs: [model.videoId]) }
                .and(sdk)
                .dispatch(on: .main)
                .onComplete(callback: handle)
        }
    }
    
    func handle(result: (Result<VideoProvider.Response>, Result<OneSDK>)) {
        switch result {
        case (.value(let response), .value(let sdk)):
            func byIndex(of response: VideoProvider.Response.VideoResponse) -> Int? {
                guard case .video(let video) = response else { return nil }
                return models.index { $0.videoId == video.id }
            }            
            guard let index = response.videos.flatMap(byIndex).first else { return }
            
            let player = sdk.makePlayer(videoResponse: response, autoplay: false)
            
            let systemPVC = SystemPlayerViewController()
            systemPVC.player = player
            models[index].systemPlayerViewController = systemPVC
            
            collectionView?.reloadItems(at: [IndexPath(row: index, section: 0)])
        case (.error(let error), _), (_, .error(let error)):
            let alert = UIAlertController(title: "Error",
                                          message: "\(error)",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default,
                                          handler: nil))
            present(alert, animated: true, completion: nil)
        default: break
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlayersCollectionCellId",
            
                                                      for: indexPath)
        guard
            let controller = models[indexPath.row].systemPlayerViewController,
            let playerCell = cell as? PlayersCollectionViewCell else { return cell }
        
        addChildViewController(controller)
        controller.view.frame = CGRect(x: 0,
                                       y: 0,
                                       width: cell.contentView.frame.width,
                                       height: cell.contentView.frame.height)
        cell.contentView.addSubview(controller.view)
        controller.didMove(toParentViewController: self)
        
        playerCell.removePlayerViewController = {
            controller.willMove(toParentViewController: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParentViewController()
        }
        
        return playerCell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 canFocusItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        (cell as? PlayersCollectionViewCell)?.removePlayerViewController?()
    }
}

extension PlayersCollectionViewController {
    struct Model {
        let videoId: String
        var systemPlayerViewController: SystemPlayerViewController?
    }
}

class PlayersCollectionViewCell: UICollectionViewCell {
    var removePlayerViewController: Optional<(Void) -> Void>
}
