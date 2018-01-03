//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import CoreImage
import OneMobileSDK

func setup(tutorialCasesViewController: TutorialCasesViewController) {
    func select(player: Future<Result<Player>>, filter: CIFilter? = nil) -> (UIViewController) -> () {
        return {
            guard let wrapper = $0 as? SystemPlayerViewControllerWrapper else { return }
            wrapper.props.player = player
            wrapper.props.filter = filter
        }
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Single video", select: select(player: singleVideo())),
               .init(name: "Array of videos", select: select(player: arrayOfVideos())),
               .init(name: "Video playlist", select: select(player: videoPlaylist())),
               .init(name: "Muted video", select: select(player: mutedVideo())),
               .init(name: "Video without autoplay", select: select(player: videoWithoutAutoplay())),
               .init(name: "Filtered video", select: select(player: singleVideo(),
                                                            filter: CIFilter(name: "CICMYKHalftone")))])
}
