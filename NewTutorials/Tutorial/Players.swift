//  Copyright © 2017 Oath. All rights reserved.

import Foundation
import OneMobileSDK

func singleVideo() -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK()
        .then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47") }
}

func arrayOfVideos() -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK()
        .then { $0.getPlayer(videoIDs: ["593967be9e45105fa1b5939a",
                                        "577cc23d50954952cc56bc47",
                                        "5939698f85eb427b86aa0a14"]) }
}

func videoPlaylist() -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK()
        .then { $0.getPlayer(playlistID: "577cc27b88d2ff0d0f5acc71") }
}

func mutedVideo() -> Future<Result<Player>> {
    func mute(player: inout Player) { player.mute() }
    return singleVideo().map(mute)
}

func videoWithoutAutoplay() -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK()
        .then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47",
                             autoplay: false) }
}

func liveVideo() -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK()
        .then { $0.getPlayer(videoID: "59833447b90afb42310c19da") }
}

func subtitlesVideo() -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK()
        .then { $0.getPlayer(videoID: "59b0122a8c08e07695c98519") }
}
