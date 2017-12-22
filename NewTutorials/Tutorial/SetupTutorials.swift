//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls


func show(wrapper: PlayerViewControllerWrapper,
          in tutorialCasesViewController: TutorialCasesViewController,
          with player: Future<Result<Player>>) {
    tutorialCasesViewController.show(viewController: wrapper)
    wrapper.props.player = player
}

func playerViewControllerWrapper() -> PlayerViewControllerWrapper {
    guard let wrapper = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerViewControllerWrapper") as? PlayerViewControllerWrapper else {
        fatalError("Wrapper not found")
    }
    return wrapper
}

func setupPlayingVideos(tutorialCasesViewController: TutorialCasesViewController) {
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Single video",
                     action: { show(wrapper: playerViewControllerWrapper(),
                                    in: tutorialCasesViewController,
                                    with: singleVideo()) }),
               .init(name: "Array of videos",
                     action: { show(wrapper: playerViewControllerWrapper(),
                                    in: tutorialCasesViewController,
                                    with: arrayOfVideos()) }),
               .init(name: "Video playlist",
                     action: { show(wrapper: playerViewControllerWrapper(),
                                    in: tutorialCasesViewController,
                                    with: videoPlaylist()) }),
               .init(name: "Muted video",
                     action: { show(wrapper: playerViewControllerWrapper(),
                                    in: tutorialCasesViewController,
                                    with: mutedVideo()) }),
               .init(name: "Video without autoplay",
                     action: { show(wrapper: playerViewControllerWrapper(),
                                    in: tutorialCasesViewController,
                                    with: videoWithoutAutoplay()) })])
}

func setupCustomUX(tutorialCasesViewController: TutorialCasesViewController) {
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
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Custom color",
                     action: {
                        let wrapper = playerViewControllerWrapper()
                        wrapper.props.controls.color = UIColor.magenta
                        show(wrapper: wrapper,
                             in: tutorialCasesViewController,
                             with: singleVideo()) }),
               .init(name: "Custom sidebar",
                     action: {
                        let wrapper = playerViewControllerWrapper()
                        wrapper.props.controls.sidebarProps = customSidebarProps()
                        show(wrapper: wrapper,
                             in: tutorialCasesViewController,
                             with: singleVideo()) }),
               .init(name: "Hidden 10s seek and settings",
                     action: {
                        let wrapper = playerViewControllerWrapper()
                        wrapper.props.controls.isSomeHidden = true
                        show(wrapper: wrapper,
                             in: tutorialCasesViewController,
                             with: arrayOfVideos()) }),
               .init(name: "Live dot color",
                     action: {
                        let wrapper = playerViewControllerWrapper()
                        wrapper.props.controls.liveDotColor = UIColor.red
                        show(wrapper: wrapper,
                             in: tutorialCasesViewController,
                             with: liveVideo()) }),
               .init(name: "Filtered subtitles",
                     action: {
                        let wrapper = playerViewControllerWrapper()
                        wrapper.props.controls.isFilteredSubtitles = true
                        show(wrapper: wrapper,
                             in: tutorialCasesViewController,
                             with: liveVideo()) })])
}
