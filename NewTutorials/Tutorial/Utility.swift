//  Copyright © 2016 One by Aol : Publishers. All rights reserved.

import Foundation
import OneMobileSDK

struct Utility {
    private let provider = OneSDK.Provider.default
    private var isMute = false
    private var isAutoplay = false
    
    mutating func toggleMute() {
        isMute = !isMute
    }
    
    mutating func toggleAutoplay() {
        isAutoplay = !isAutoplay
    }
    
    func singleVideo() -> Future<Result<Player>> {
        return provider.getSDK().then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47",
                                                     autoplay: self.isAutoplay) }
            .map(mute)
    }
    
    func arrayOfVideos() -> Future<Result<Player>> {
        return provider.getSDK().then { $0.getPlayer(videoIDs: ["593967be9e45105fa1b5939a",
                                                                "577cc23d50954952cc56bc47",
                                                                "5939698f85eb427b86aa0a14"],
                                                     autoplay: self.isAutoplay) }
            .map(mute)
    }
    
    func videoPlaylist() -> Future<Result<Player>> {
        return provider.getSDK().then { $0.getPlayer(playlistID: "577cc27b88d2ff0d0f5acc71",
                                                     autoplay: self.isAutoplay) }
            .map(mute)
    }
    
    private func mute(player: inout Player) { isMute ? player.mute() : player.unmute() }
}
