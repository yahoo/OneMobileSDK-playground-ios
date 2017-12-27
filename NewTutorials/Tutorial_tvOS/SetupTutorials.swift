//  Copyright © 2017 Oath. All rights reserved.

import UIKit


func setup(tutorialCasesViewController: TutorialCasesViewController) {
    func playSingleVideo(viewController: UIViewController) {
        guard let wrapper = viewController as? SystemPlayerViewControllerWrapper else { return }
        wrapper.props.player = singleVideo()
    }
    
    func playArrayOfVideos(viewController: UIViewController) {
        guard let wrapper = viewController as? SystemPlayerViewControllerWrapper else { return }
        wrapper.props.player = arrayOfVideos()
    }
    
    func playVideoPlaylist(viewController: UIViewController) {
        guard let wrapper = viewController as? SystemPlayerViewControllerWrapper else { return }
        wrapper.props.player = videoPlaylist()
    }
    
    func playMutedVideo(viewController: UIViewController) {
        guard let wrapper = viewController as? SystemPlayerViewControllerWrapper else { return }
        wrapper.props.player = mutedVideo()
    }
    
    func playVideoWithoutAutoplay(viewController: UIViewController) {
        guard let wrapper = viewController as? SystemPlayerViewControllerWrapper else { return }
        wrapper.props.player = videoWithoutAutoplay()
    }
    
    func playFilteredVideo(viewController: UIViewController) {
        guard let wrapper = viewController as? SystemPlayerViewControllerWrapper else { return }
        wrapper.props.player = singleVideo()
        wrapper.props.filter = {
            let gauss = CIFilter(name: "CIGaussianBlur")
            gauss?.setValue(5, forKey: "inputRadius")
            return gauss
        }()
    }
    
    tutorialCasesViewController.props = .init(
        rows: [.init(name: "Single video", select: playSingleVideo),
               .init(name: "Array of videos", select: playArrayOfVideos),
               .init(name: "Video playlist", select: playVideoPlaylist),
               .init(name: "Muted video", select: playMutedVideo),
               .init(name: "Video without autoplay", select: playVideoWithoutAutoplay),
               .init(name: "Filtered video", select: playFilteredVideo)])
}
