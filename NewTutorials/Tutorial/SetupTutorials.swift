//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls


func bind(player: Future<Result<Player>>,
          wrapper: PlayerViewControllerWrapper,
          vc: TutorialCasesViewController) {
    vc.show(viewController: wrapper)
    wrapper.props.player = player
}

func playerViewControllerWrapper() -> PlayerViewControllerWrapper {
    guard let wrapper = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerViewControllerWrapper") as? PlayerViewControllerWrapper else {
        fatalError("Wrapper not found")
    }
    return wrapper
}

func setupPlayingVideos(vc: TutorialCasesViewController) {
    vc.props = .init(rows: [.init(name: "Single video",
                                  action: { bind(player: singleVideo(),
                                                 wrapper: playerViewControllerWrapper(),
                                                 vc: vc) }),
                            .init(name: "Array of videos",
                                  action: { bind(player: arrayOfVideos(),
                                                 wrapper: playerViewControllerWrapper(),
                                                 vc: vc) }),
                            .init(name: "Video playlist",
                                  action: { bind(player: videoPlaylist(),
                                                 wrapper: playerViewControllerWrapper(),
                                                 vc: vc) }),
                            .init(name: "Muted video",
                                  action: { bind(player: mutedVideo(),
                                                 wrapper: playerViewControllerWrapper(),
                                                 vc: vc) }),
                            .init(name: "Video without autoplay",
                                  action: { bind(player: videoWithoutAutoplay(),
                                                 wrapper: playerViewControllerWrapper(),
                                                 vc: vc) })])
}

func setupCustomUX(vc: TutorialCasesViewController) {
    func customSidebarProps() -> SideBarView.Props {
        return [.init(isEnabled: true,
                      isSelected: false,
                      icons: .init(normal: UIImage(named: "icon-fav")!,
                                   selected: UIImage(named: "icon-fav-active")!,
                                   highlighted: nil),
                      handler: .nop),
                .init(isEnabled: true,
                      isSelected: false,
                      icons: .init(normal: UIImage(named: "icon-share")!,
                                   selected: UIImage(named: "icon-share-active")!,
                                   highlighted: nil),
                      handler: .nop)]
    }
    
    vc.props = .init(rows: [.init(name: "Custom color",
                                  action: {
                                    let wrapper = playerViewControllerWrapper()
                                    wrapper.props.controlsColor = UIColor.magenta
                                    bind(player: singleVideo(),
                                         wrapper: wrapper,
                                         vc: vc) }),
                            .init(name: "Custom sidebar",
                                  action: {
                                    let wrapper = playerViewControllerWrapper()
                                    wrapper.props.sidebarProps = customSidebarProps()
                                    bind(player: singleVideo(),
                                         wrapper: wrapper,
                                         vc: vc) }),
                            .init(name: "Hidden 10s seek and settings",
                                  action: {
                                    let wrapper = playerViewControllerWrapper()
                                    wrapper.props.isHiddenSomeControls = true
                                    bind(player: arrayOfVideos(),
                                         wrapper: wrapper,
                                         vc: vc) }),
                            .init(name: "Live dot color",
                                  action: {
                                    let wrapper = playerViewControllerWrapper()
                                    wrapper.props.liveDotColor = UIColor.red
                                    bind(player: liveVideo(),
                                         wrapper: wrapper,
                                         vc: vc) }),
                            .init(name: "Filtered subtitles",
                                  action: {
                                    let wrapper = playerViewControllerWrapper()
                                    wrapper.props.isFilteredSubtitles = true
                                    bind(player: subtitlesVideo(),
                                         wrapper: wrapper,
                                         vc: vc) })])
}
