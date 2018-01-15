//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls


func setupPlayingVideos(tutorialCasesViewController: TutorialCasesViewController) {
    func select(player: Future<Result<Player>>) -> (UIViewController) -> () {
        return {
            guard let wrapper = $0 as? PlayerViewControllerWrapper else { return }
            wrapper.player = player
        }
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Single video", select: select(player: singleVideo())),
               .init(name: "Array of videos", select: select(player: arrayOfVideos())),
               .init(name: "Video playlist", select: select(player: videoPlaylist())),
               .init(name: "Muted video", select: select(player: mutedVideo())),
               .init(name: "Video without autoplay", select: select(player: videoWithoutAutoplay()))])
}

func select(controller: @escaping (PlayerViewControllerWrapper) -> ()) -> (UIViewController) -> () {
    return {
        guard let wrapper = $0 as? PlayerViewControllerWrapper else { return }
        controller(wrapper)
    }
}

func setupCustomUX(tutorialCasesViewController: TutorialCasesViewController) {
    typealias Props = PlayerViewControllerWrapper.Props
    
    func customColors(wrapper: PlayerViewControllerWrapper) {
        wrapper.props.player = singleVideo()
        wrapper.props.controls.color = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    }
    
    func customSidebar(wrapper: PlayerViewControllerWrapper) {
        wrapper.props.controls.sidebarProps = [.init(isEnabled: true,
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
        wrapper.player = singleVideo()
    }
    
    func hiddenControls(wrapper: PlayerViewControllerWrapper) {
        wrapper.props.controls.isSomeHidden = true
        wrapper.player = arrayOfVideos()
    }
    
    func liveDotColor(wrapper: PlayerViewControllerWrapper) {
        wrapper.props.controls.liveDotColor = UIColor.red
        wrapper.player = liveVideo()
    }
    
    func filteredSubtitles(wrapper: PlayerViewControllerWrapper) {
        wrapper.props.controls.isFilteredSubtitles = true
        wrapper.player = subtitlesVideo()
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Custom color", select: select(controller: customColors)),
               .init(name: "Custom sidebar", select: select(controller: customSidebar)),
               .init(name: "Hidden 10s seek and settings", select: select(controller: hiddenControls)),
               .init(name: "Live dot color", select: select(controller: liveDotColor)),
               .init(name: "Filtered subtitles", select: select(controller: filteredSubtitles))])
}

func setupObserving(tutorialCasesViewController: TutorialCasesViewController) {
    func videoStats(wrapper: PlayerViewControllerWrapper) {
        wrapper.props.showStats = true
        wrapper.player = videoPlaylist()
    }
    
    func loopingVideos(wrapper: PlayerViewControllerWrapper) {
        wrapper.props.looping = true
        wrapper.player = videoPlaylist()
    }
    
    func hooking(wrapper: PlayerViewControllerWrapper) {
        wrapper.props.nextVideoHooking = true
        wrapper.player = videoPlaylist()
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Video stats", select: select(controller: videoStats)),
               .init(name: "Looping videos", select: select(controller: loopingVideos)),
               .init(name: "Next video hooking", select: select(controller: hooking))])
}
