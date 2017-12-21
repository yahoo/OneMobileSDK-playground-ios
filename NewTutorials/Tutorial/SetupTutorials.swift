//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls

func bind(player: Future<Result<Player>> = singleVideo(),
          wrapper: PlayerViewControllerWrapper = PlayerViewControllerWrapper(),
          vc: TutorialCasesViewController) {
    wrapper.props.isLoading = true
    vc.show(viewController: wrapper)
    
    player
        .dispatch(on: .main)
        .onSuccess(call: wrapper.attach)
        .onError(call: vc.show)
        .onComplete { _ in wrapper.props.isLoading = false }
}

func setupPlayingVideos(vc: TutorialCasesViewController) {
    vc.props = .init(rows: [.init(name: "Single video",
                                  action: { bind(player: singleVideo(),
                                                 vc: vc) }),
                            .init(name: "Array of videos",
                                  action: { bind(player: arrayOfVideos(),
                                                 vc: vc) }),
                            .init(name: "Video playlist",
                                  action: { bind(player: videoPlaylist(),
                                                 vc: vc) }),
                            .init(name: "Muted video",
                                  action: { bind(player: mutedVideo(),
                                                 vc: vc) }),
                            .init(name: "Video without autoplay",
                                  action: { bind(player: videoWithoutAutoplay(),
                                                 vc: vc) })])
}

func setupCustomUX(vc: TutorialCasesViewController) {
    func customSidebarProps() -> SideBarView.Props {
        return [.init(isEnabled: true,
                      isSelected: false,
                      icons: .init(normal: UIImage(named: "icon-fav")!,
                                   selected: UIImage(named: "icon-fav-active")!,
                                   highlighted: nil),
                      handler: { }),
                .init(isEnabled: true,
                      isSelected: false,
                      icons: .init(normal: UIImage(named: "icon-share")!,
                                   selected: UIImage(named: "icon-share-active")!,
                                   highlighted: nil),
                      handler: { })]
    }
    
    vc.props = .init(rows: [.init(name: "Custom color",
                                  action: {
                                    let wrapper = PlayerViewControllerWrapper()
                                    wrapper.props.controlsColor = UIColor.magenta
                                    bind(wrapper: wrapper,
                                         vc: vc) }),
                            .init(name: "Custom sidebar",
                                  action: {
                                    let wrapper = PlayerViewControllerWrapper()
                                    wrapper.props.sidebarProps = customSidebarProps()
                                    bind(wrapper: wrapper,
                                         vc: vc) }),
                            .init(name: "Hidden 10s seek and settings",
                                  action: {
                                    let wrapper = PlayerViewControllerWrapper()
                                    wrapper.props.isHiddenSomeControls = true
                                    bind(player: arrayOfVideos(),
                                         wrapper: wrapper,
                                         vc: vc) }),
                            .init(name: "Live dot color",
                                  action: {
                                    let wrapper = PlayerViewControllerWrapper()
                                    wrapper.props.liveDotColor = UIColor.red
                                    bind(player: liveVideo(),
                                         wrapper: wrapper,
                                         vc: vc) }),
                            .init(name: "Filtered subtitles",
                                  action: {
                                    let wrapper = PlayerViewControllerWrapper()
                                    wrapper.props.isFilteredSubtitles = true
                                    bind(player: subtitlesVideo(),
                                         wrapper: wrapper,
                                         vc: vc) })])
}
