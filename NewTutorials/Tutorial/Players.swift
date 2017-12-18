//  Copyright © 2017 Oath. All rights reserved.

import Foundation
import OneMobileSDK

func singleVideo(isAutoplay: Bool = true) -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK().then { $0.getPlayer(videoID: "577cc23d50954952cc56bc47",
                                                                autoplay: isAutoplay) }
}

func arrayOfVideos() -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK().then { $0.getPlayer(videoIDs: ["593967be9e45105fa1b5939a",
                                                                           "577cc23d50954952cc56bc47",
                                                                           "5939698f85eb427b86aa0a14"]) }
}

func videoPlaylist() -> Future<Result<Player>> {
    return OneSDK.Provider.default.getSDK().then { $0.getPlayer(playlistID: "577cc27b88d2ff0d0f5acc71") }
}
