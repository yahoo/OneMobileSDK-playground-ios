//  Copyright © 2017 Oath. All rights reserved.

import UIKit
import OneMobileSDK
import PlayerControls


func setupPlayingVideos(tutorialCasesViewController: TutorialCasesViewController) {
    func select(player: Future<Result<Player>>) -> (UIViewController) -> () {
        return {
            guard let wrapper = $0 as? PlayerViewControllerWrapper else { return }
            wrapper.props.player = player
        }
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Single video", select: select(player: singleVideo())),
               .init(name: "Array of videos", select: select(player: arrayOfVideos())),
               .init(name: "Video playlist", select: select(player: videoPlaylist())),
               .init(name: "Muted video", select: select(player: mutedVideo())),
               .init(name: "Video without autoplay", select: select(player: videoWithoutAutoplay()))])
}

func setupCustomUX(tutorialCasesViewController: TutorialCasesViewController) {
    typealias Props = PlayerViewControllerWrapper.Props
    
    func customColors(props: inout Props) {
        props.player = singleVideo()
        props.controls.color = UIColor(red:0.51, green:0.87, blue:0.47, alpha:1.0)
    }
    
    func customSidebar(props: inout Props) {
        props.player = singleVideo()
        props.controls.sidebarProps = [.init(isEnabled: true,
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
    
    func hiddenControls(props: inout Props) {
        props.player = arrayOfVideos()
        props.controls.isSomeHidden = true
    }
    
    func liveDotColor(props: inout Props) {
        props.player = liveVideo()
        props.controls.liveDotColor = UIColor.red
    }
    
    func filteredSubtitles(props: inout Props) {
        props.player = subtitlesVideo()
        props.controls.isFilteredSubtitles = true
    }
    
    func select(props: @escaping (inout Props) -> ()) -> (UIViewController) -> () {
        return {
            guard let wrapper = $0 as? PlayerViewControllerWrapper else { return }
            props(&wrapper.props)
        }
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Custom color", select: select(props: customColors)),
               .init(name: "Custom sidebar", select: select(props: customSidebar)),
               .init(name: "Hidden 10s seek and settings", select: select(props: hiddenControls)),
               .init(name: "Live dot color", select: select(props: liveDotColor)),
               .init(name: "Filtered subtitles", select: select(props: filteredSubtitles))])
}
