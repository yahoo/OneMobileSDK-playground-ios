//  Copyright © 2017 Oath. All rights reserved.

import UIKit

class ViewController: UIViewController {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let playersCollectionViewController = segue.destination as? PlayersCollectionViewController else { return }

        playersCollectionViewController.models = [
            PlayersCollectionViewController.Model(videoId: "593967be9e45105fa1b5939a",
                                                  systemPlayerViewController: nil),
            PlayersCollectionViewController.Model(videoId: "577cc23d50954952cc56bc47",
                                                  systemPlayerViewController: nil),
            PlayersCollectionViewController.Model(videoId: "59397934955a316f1c4f65b4",
                                                  systemPlayerViewController: nil),
            PlayersCollectionViewController.Model(videoId: "5939698f85eb427b86aa0a14",
                                                  systemPlayerViewController: nil)]
    }
}

