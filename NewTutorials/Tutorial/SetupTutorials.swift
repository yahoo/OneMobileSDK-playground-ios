//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls


func setupPlayingVideos(tutorialCasesViewController: TutorialCasesViewController) {
    func playSingleVideo(viewController: UIViewController) {
        guard let wrapper = viewController as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = singleVideo()
    }
    
    func playArrayOfVideos(viewController: UIViewController) {
        guard let wrapper = viewController as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = arrayOfVideos()
    }
    
    func playVideoPlaylist(viewController: UIViewController) {
        guard let wrapper = viewController as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = videoPlaylist()
    }
    
    func playMutedVideo(viewController: UIViewController) {
        guard let wrapper = viewController as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = mutedVideo()
    }
    
    func playVideoWithoutAutoplay(viewController: UIViewController) {
        guard let wrapper = viewController as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = videoWithoutAutoplay()
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Single video", select: playSingleVideo),
               .init(name: "Array of videos", select: playArrayOfVideos),
               .init(name: "Video playlist", select: playVideoPlaylist),
               .init(name: "Muted video", select: playMutedVideo),
               .init(name: "Video without autoplay", select: playVideoWithoutAutoplay)])
}

func setupCustomUX(tutorialCasesViewController: TutorialCasesViewController) {
    func customColors(wrapper: UIViewController) {
        guard let wrapper = wrapper as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = singleVideo()
        wrapper.props.controls.color = UIColor.magenta
    }
    
    func customSidebar(wrapper: UIViewController) {
        guard let wrapper = wrapper as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = singleVideo()
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
    }
    
    func hiddenControls(wrapper: UIViewController) {
        guard let wrapper = wrapper as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = arrayOfVideos()
        wrapper.props.controls.isSomeHidden = true
    }
    
    func liveDotColor(wrapper: UIViewController) {
        guard let wrapper = wrapper as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = liveVideo()
        wrapper.props.controls.liveDotColor = UIColor.red
    }
    
    func filteredSubtitles(wrapper: UIViewController) {
        guard let wrapper = wrapper as? PlayerViewControllerWrapper else { return }
        wrapper.props.player = subtitlesVideo()
        wrapper.props.controls.isFilteredSubtitles = true
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Custom color", select: customColors),
               .init(name: "Custom sidebar", select: customSidebar),
               .init(name: "Hidden 10s seek and settings", select: hiddenControls),
               .init(name: "Live dot color", select: liveDotColor),
               .init(name: "Filtered subtitles", select: filteredSubtitles)])
}
