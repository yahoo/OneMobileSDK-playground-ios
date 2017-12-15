//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

func setupPlayingVideos(vc: TutorialCasesViewController) {
    func process(player: Future<Result<Player>>) {
        guard let wrapper = vc.storyboard?.instantiateViewController(withIdentifier: "PlayerViewControllerWrapper") as? PlayerViewControllerWrapper else {
            fatalError("Wrapper not found")
        }
        
        vc.show(viewController: wrapper)
        wrapper.props.player = player
    }
    
    vc.props = .init(rows: [.init(name: "Single video",
                                  action: { process(player: singleVideo()) }),
                            .init(name: "Array of videos",
                                  action: { process(player: arrayOfVideos()) }),
                            .init(name: "Video playlist",
                                  action: { process(player: videoPlaylist()) }),
                            .init(name: "Muted video",
                                  action: { process(player: mutedVideo()) }),
                            .init(name: "Video without autoplay",
                                  action: { process(player: videoWithoutAutoplay()) })])
}
