//  Copyright © 2017 One by Aol : Publishers. All rights reserved.

import UIKit
import AVKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    @IBOutlet weak var reloadButton: UIButton!
    var activeAVPlayerViewController: AVPlayerViewController?
    
    override var preferredFocusEnvironments: [UIFocusEnvironment] {
        return [self.reloadButton, self.collectionView!]
    }
    
    @IBAction func firstItemReloadAction(_ sender: Any) {
        self.activeAVPlayerViewController?.willMove(toParentViewController: nil)
        self.activeAVPlayerViewController?.view.removeFromSuperview()
        self.activeAVPlayerViewController?.removeFromParentViewController()
        self.activeAVPlayerViewController = nil
        
        self.collectionView?.reloadItems(at: [IndexPath(row:0, section:0)])
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        let playerViewController = AVPlayerViewController()
        self.activeAVPlayerViewController = playerViewController
        playerViewController.willMove(toParentViewController: self)
        self.addChildViewController(playerViewController)
        playerViewController.view.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: cell.frame.size.height)
        cell.contentView.addSubview(playerViewController.view)
        playerViewController.didMove(toParentViewController: self)
    
        return cell
    }
}
